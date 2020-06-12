#include(rulesA.inc)

[top]
components : EmployeeBehaviour

[EmployeeBehaviour]
type : cell
dim : (15,15,3)
delay : transport
defaultDelayTime : 100
border : wrapped 

%Corresponding cell in Plane 2 is in the neighborhood of each cell in plane 0
neighbors :                                                   EmployeeBehaviour(0,0,2)
%Moore's Neighborhood of 25 cells in plane 0 is a part of the neighborhood of each of the cells in plane 0
neighbors : EmployeeBehaviour(-2,-2,0) EmployeeBehaviour(-2,-1,0) EmployeeBehaviour(-2,0,0) EmployeeBehaviour(-2,1,0) EmployeeBehaviour(-2,2,0)
neighbors : EmployeeBehaviour(-1,-2,0) EmployeeBehaviour(-1,-1,0) EmployeeBehaviour(-1,0,0) EmployeeBehaviour(-1,1,0) EmployeeBehaviour(-1,2,0)
neighbors : EmployeeBehaviour(0,-2,0) EmployeeBehaviour(0,-1,0)  EmployeeBehaviour(0,0,0)  EmployeeBehaviour(0,1,0)   EmployeeBehaviour(0,2,0)
neighbors : EmployeeBehaviour(1,-2,0) EmployeeBehaviour(1,-1,0)  EmployeeBehaviour(1,0,0)  EmployeeBehaviour(1,1,0)   EmployeeBehaviour(1,2,0)
neighbors : EmployeeBehaviour(2,-2,0) EmployeeBehaviour(2,-1,0)  EmployeeBehaviour(2,0,0)  EmployeeBehaviour(2,1,0)   EmployeeBehaviour(2,2,0)
%Moore's Neighborhood of 25 cells in plane 1 is a part of the neighborhood of each of the cells in plane 0
neighbors : EmployeeBehaviour(-2,-2,1) EmployeeBehaviour(-2,-1,1) EmployeeBehaviour(-2,0,1) EmployeeBehaviour(-2,1,1) EmployeeBehaviour(-2,2,1)
neighbors : EmployeeBehaviour(-1,-2,1) EmployeeBehaviour(-1,-1,1) EmployeeBehaviour(-1,0,1) EmployeeBehaviour(-1,1,1) EmployeeBehaviour(-1,2,1)
neighbors : EmployeeBehaviour(0,-2,1) EmployeeBehaviour(0,-1,1)  EmployeeBehaviour(0,0,1)  EmployeeBehaviour(0,1,1)   EmployeeBehaviour(0,2,1)
neighbors : EmployeeBehaviour(1,-2,1) EmployeeBehaviour(1,-1,1)  EmployeeBehaviour(1,0,1)  EmployeeBehaviour(1,1,1)   EmployeeBehaviour(1,2,1)
neighbors : EmployeeBehaviour(2,-2,1) EmployeeBehaviour(2,-1,1)  EmployeeBehaviour(2,0,1)  EmployeeBehaviour(2,1,1)   EmployeeBehaviour(2,2,1)



initialvalue : 1
localtransition : EBehaviour-rule
initialCellsValue : EmployeeBehaviour.val
zone : insistence { (0,0,2)..(14,14,2) } 
zone : influence { (0,0,1)..(14,14,1) } 

%Employee behaviour (Plane 0) rules
[EBehaviour-rule]

% If a cell has Positive Behaviour i.e. (0,0,0) = 1 the rules are as follows:
rule : {1} 100 { (0,0,0) = 1 and ( ((#macro(ped) + (0,0,2)) >= #macro(ned)) and ((#macro(ped) + (0,0,2)) >= #macro(zed)) ) } 
rule : {-1} 100 { (0,0,0) = 1 and (#macro(ned) > #macro(zed)) }
rule : {0} 100 { (0,0,0) = 1 and (#macro(zed) > #macro(ned)) }
rule : {(-1)*randInt(1)} 100 { (0,0,0) = 1 and (#macro(ned) = #macro(zed)) }%next state is random integer which is either 0 or -1

% If a cell has Negative Behaviour i.e. (0,0,0) = -1 the rules are as follows:
rule : {-1} 100 { (0,0,0) = -1 and ( ((#macro(ned) + (0,0,2)) >= #macro(ped)) and ((#macro(ned) + (0,0,2)) >= #macro(zed)) ) }  
rule : {1} 100 { (0,0,0) = -1 and (#macro(ped) > #macro(zed)) }
rule : {0} 100 { (0,0,0) = -1 and (#macro(zed) > #macro(ped)) }
rule : {randInt(1)} 100 { (0,0,0) = -1 and (#macro(ped) = #macro(zed)) }%next state is random integer which is either 0 or 1

% If a cell has Zero Behaviour i.e. (0,0,0) = 0 the rules are as follows:
rule : {0} 100 { (0,0,0) = 0 and ( ((#macro(zed) + (0,0,2)) >= #macro(ned)) and ((#macro(zed) + (0,0,2)) >= #macro(ped)) ) } 
rule : {1} 100 { (0,0,0) = 0 and (#macro(ped) > #macro(ned)) }
rule : {-1} 100 { (0,0,0) = 0 and (#macro(ned) > #macro(ped)) }
rule : {power(-1,randInt(1))*1} 100 { (0,0,0) = 0 and (#macro(ned) = #macro(ped)) }%next state is random integer which is either -1 or 1

%Influence (Plane 1) rules
[influence]
%Constant influence cells
rule : { (0,0,0) } 100 { t }

%Insistence (Plane 2) rules
[insistence]
%Constant insistent cells
rule : { (0,0,0) } 100 { t }


