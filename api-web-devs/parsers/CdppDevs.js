'use strict';

import Core from '../tools/core.js';
import Parser from "./parser.js";

import { Simulation, TransitionDEVS, TransitionsDEVS, Diagram, Options, Files } from './files.js';

import Settings from '../components/settings.js';

export default class CDppDEVS extends Parser { 
		
	Parse(files) {
		var d = Core.Defer();

		var ma = files.find(function(f) { return f.name.match(/.ma/i); });
		var svg = files.find(function(f) { return f.name.match(/.svg/i); });
		var log = files.find(function(f) { return f.name.match(/.log/i); });

		if (!ma || !log) {
			d.Reject(new Error("A model (.ma) and a log (.log) file must be provided for the CD++ DEVS parser."));
		
			return d.promise;
		}
		
		var name = log.name.substr(0, log.name.length - 4);
	
		this.Read(ma, this.ParseMaFile.bind(this)).then((ma) => {
			var p1 = this.Read(svg, this.ParseSVGFile.bind(this));
			var p2 = this.ReadByChunk(log, this.ParseLogChunk.bind(this, ma));
			
			var defs = [p1, p2];
	
			Promise.all(defs).then((data) => {
				var svg = data[0];
				var log = data[1];
				
				if (!ma) return d.Reject(new Error("Unable to parse the model (.ma) file."));
				
				if (!log) return d.Reject(new Error("Unable to parse the log (.log) file or it contained no X and Y messages."));
				
				var simulation = new Simulation(name, "CDpp", "DEVS", data[0].models, data[0].size);
				var transitions = new TransitionsDEVS(data[2]);
				var diagram = new Diagram(data[1]);
				var options = new Options(Settings.Default());
				
				var files = new Files(simulation, transitions, diagram, options);

				d.Resolve(files);
			}, (error) => { d.Reject(error); });
			
		}, (error) => { d.Reject(error); });

		return d.promise;
	}

	ParseMaFile(file) {		
		var blocks = file.trim().slice(1).split("\n[");
		var links = [];
		
		// This is messy but due to the structure of ma files
		var models = blocks.map(b => {		
			var model = { name:null, type:null, submodels:[], ports:[], links:[] }
		
			b.trim().split("\n").forEach((l, i) => {
				l = l.trim().toLowerCase();
				
				if (i == 0) model.name = l.substr(0, l.length - 1);
				
				else if (l.startsWith("components")) {
					model.submodels.push(l.split(/\s|@/)[2]);
				}
				
				//else if (l.startsWith("out")) {
				//	l.split(/\s/).slice(2).forEach(p => model.ports.push({ name:p, type:"output" }));
				//}
				
				//else if (l.startsWith("in")) {
				//	l.split(/\s/).slice(2).forEach(p => model.ports.push({ name:p, type:"input" }));
				//}
				
				else if (l.startsWith("link")) {
					var ports = l.split(/\s/).slice(2);
					var output = ports[0].split(/@/);
					var input = ports[1].split(/@/);
					
					links.push({
						portA : output[0],
						modelA : output[1] || model.name,
						portB : input[0],
						modelB : input[1] || model.name
					})
				}
			});
			
			model.type = (model.submodels.length > 0) ? "coupled" : "atomic";
			
			return model;
		});
		
		links.forEach(l => {
			var mA = models.find(m => m.name == l.modelA);
			var mB = models.find(m => m.name == l.modelB);
			
			if (!mA.ports.find(p => p.name == l.portA)) {
				mA.ports.push({ name:l.portA, type:"output" });
			}
			
			if (!mB.ports.find(p => p.name == l.portB)) {
				mB.ports.push({ name:l.portB, type:"input" });
			}
			
			mA.links.push(l);
			mB.links.push(l);
		})
		
		return {
			size : models.length,
			models : models,
			links : links
		}
	}
	
	ParseSVGFile( file) {	
		return file;
	}
	
	ParseLogChunk(ma, parsed, chunk) {	
		debugger;
	
		function IndexOf(chunk, text, start) {
			var idx = chunk.indexOf(text, start);
			
			return idx > -1 ? idx : Infinity;
		}
		
		var yStart = IndexOf(chunk, 'Mensaje Y', 0);
		var xStart = IndexOf(chunk, 'Mensaje X', 0);
		
		while (xStart < Infinity || yStart < Infinity) {
			var type = (xStart < yStart) ? 'X' : 'Y';
			
			var start = (type == 'X') ? xStart : yStart;
			
			var end = chunk.indexOf('\n', start);
			
			if (end == -1) end = chunk.length + 1;
			
			var length = end - start;
			
			if (type == 'X') xStart = IndexOf(chunk, 'Mensaje X', start + length);
			if (type == 'Y') yStart = IndexOf(chunk, 'Mensaje Y', start + length);
			
			var split = chunk.substr(start, length).split('/');
			
			// Parse coordinates, state value & frame timestamp
			var tmp1 = split[2].trim().split("(");
			var tmp2 = split[4].trim().split(" ");
			
			// NOTE : Don't use regex, it's super slow.
			var t = split[1].trim();			// time
			var m = tmp1[0];					// model name
			var c = tmp1[1].slice(0, -1);		// id / coordinate
			var p = split[3].trim();			// port
			var v = parseFloat(split[4]);		// value
			var d = tmp2[2].split("(")[0];		// destination

			// NOTE: Here we replace model id by name because name is also unique (are we sure?) but more intuitive. 
			// We do this to allow users to use names when drawing SVG diagrams. This way, names in SVG will match
			// with names in transitions.
			parsed.push(new TransitionDEVS(type, t, m, p, d, v));
		}
		
		return parsed;
	}
}