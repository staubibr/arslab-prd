[top]
components : Region 

[Region]
type : cell
dim : (30,30)
delay : transport
defaultDelayTime  : 100
border : wrapped

neighbors : Region(-1,-1) Region(-1,0) Region(-1,1)
neighbors : Region(0,-1)  Region(0,0)  Region(0,1)
neighbors : Region(1,-1)  Region(1,0)  Region(1,1)
initialvalue : 0
localtransition : RegionBehavior
StateVariables: settlement spread edge road corridor city disaster ecology
StateValues: 0 0.0 0 0 0 0 0 0
InitialVariablesValue: Region.stvalues

NeighborPorts: scenario1 scenario2 scenario3 scenario4


[RegionBehavior]
% Calculate spread & edge
rule : { $spread } { $spread := (-1,0); } 100 { (-1,0)>0 and (0,0)=0 and (1,0)=0 }
rule : { $spread } { $spread := (1,0); $edge := (1,0); } 100 { (0,0)=0 and (1,0)>0 }
rule : { $spread } { $spread := (0,-1); } 100 { (0,-1)>0 and (0,0)=0 and (0,1)=0 }
rule : { $spread } { $spread := (0,1); $edge := (0,1); } 100 { (0,0)=0 and (0,1)>0 }
% Calculate edge
rule : { $edge } { $edge := 0; } 100 { (-1,0)>0 and (0,0)>0 and (1,0)=0 }
rule : { $edge } { $edge := 0; } 100 { (0,-1)>0 and (0,0)>0 and (0,1)=0 }

% Calculate Gtotal
rule : { 
~scenario1 := randInt(1) + $settlement + $spread + $edge + $road + $corridor + (0,0) + 
(1,0) + (0,-1) + (-1,-1) + (1,1) + (-1,0) + (0,1) + (-1,1) + (1,-1); 
~scenario2 := randInt(1) + $settlement + $spread + $edge + $road + $corridor + $city + (0,0) + 
(1,0) + (0,-1) + (-1,-1) + (1,1) + (-1,0) + (0,1) + (-1,1) + (1,-1); 
~scenario3 := randInt(1) + $settlement + $spread + $edge + $road + $corridor + $ecology + (0,0) + 
(1,0) + (0,-1) + (-1,-1) + (1,1) + (-1,0) + (0,1) + (-1,1) + (1,-1); 
~scenario4 := randInt(1) + $settlement + $spread + $edge + $road + $corridor + $disaster + (0,0) + 
(1,0) + (0,-1) + (-1,-1) + (1,1) + (-1,0) + (0,1) + (-1,1) + (1,-1); 
~out := randInt(1) + $settlement + $spread + $edge + $road + $corridor;
} 
100
{ $settlement > 0 or $spread > 0 or $edge > 0 or $road > 0 or $corridor > 0 or $city > 0 or $ecology > 0 or $disaster > 0 }
rule: { ~out := 0; ~scenario1 := 0; ~scenario2 := 0; ~scenario3 := 0; ~scenario4 := 0; } 100 { t }
