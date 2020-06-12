'use strict';

import Core from '../tools/core.js';
import Evented from '../components/evented.js';
import ChunkReader from '../components/chunkReader.js';

export default class Parser extends Evented { 

	Parse() {		
		throw new Error("Parsers must implement a Parse() function");
	}
	
	
	ParseCsvChunk(parsed, chunk) {
		var lines = chunk.split("\n");
		
		for (var i = 0; i < lines.length; i++) {
			parsed.push(lines[i].trim().split(","));
		}
		
		return parsed;
	}
	
	Read(file, delegate) {
		var reader = new ChunkReader();
		
		return reader.Read(file, delegate);
	}
	
	ReadByChunk(file, delegate) {
		var reader = new ChunkReader();
		
		return reader.ReadByChunk(file, "\n", delegate);
	}
	
	ReadByChunk(file, delegate) {
		var reader = new ChunkReader();
		
		var wrap = (parsed, chunk, progress) => {
			if (!parsed) parsed = [];
		
			parsed = delegate(parsed, chunk);
			
			this.Emit("Progress", { progress: progress });
			
			return parsed;
		}
		
		return reader.ReadByChunk(file, "\n", wrap);
	}
}