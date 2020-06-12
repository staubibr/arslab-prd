[Top]
components : lynxhare 

[lynxhare]
type : cell
width : 20
height : 20
delay : inertial
defaultDelayTime : 100
border : wrapped 
%neighbors : lynxhare(-1,0) lynxhare(0,0) lynxhare(1,0) lynxhare(0,1) lynxhare(0,-1) lynxhare(-1,1) lynxhare(1,-1) lynxhare(0,-2) lynxhare(-1,-1)

neighbors :				                  lynxhare(-2,0)
neighbors :               lynxhare(-1,-1) lynxhare(-1,0) lynxhare(-1,1)
neighbors : lynxhare(0,-2) lynxhare(0,-1) lynxhare(0,0)  lynxhare(0,1) lynxhare(0,2)
neighbors :                lynxhare(1,-1) lynxhare(1,0)  lynxhare(1,1)
neighbors : 			                  lynxhare(2,0)  

initialvalue : 0
initialrowvalue :  1      00111011100011100200
initialrowvalue :  2      01001001010100100100
initialrowvalue :  3      10100110100011111010
initialrowvalue :  4      00111120100110110010
initialrowvalue :  5      10111010201011100110
initialrowvalue :  7      01011001111100100100
initialrowvalue :  8      00111110121011011011
initialrowvalue :  9      00001120100110111010
initialrowvalue :  10     00111001100111110110
initialrowvalue :  11     01001001010100100100
initialrowvalue :  12     10111110100011111010
initialrowvalue :  14     00201100100000110010
initialrowvalue :  16     00111011100011120000
initialrowvalue :  17     01001001111100100100
initialrowvalue :  18     00111110100011111010
initialrowvalue :  19     00001100100000110210


localtransition : lynxhare-rule

[lynxhare-rule]

%Growth Rules
%For Hares
rule : 1 100 { (0,0) = 1 and (-1,0) != 0 and (0,1) != 0 and (1,0) != 0 and (0,-1) != 0 } 
rule : 1 100 { (0,0) = 1 and (0,-1) = 1 and (-1,0) = 1 and (0,1) = 1 }
rule : 1 100 { (0,0) = 1 and (-1,0) = 1 and (0,1) = 1 and (1,0) = 1}
rule : 1 100 { (0,0) = 1 and (0,1) = 1 and (1,0) = 1 and (0,-1) = 1 }
rule : 1 100 { (0,0) = 1 and (1,0) = 1 and (0,-1) = 1 and (-1,0) = 1 }

%For Lynxes
rule : 2 70 { (0,0) = 2 and  (-1,0) = 2 and (0,1) = 2 and (1,0) = 2 and (0,-1) = 2 }
rule : 2 70 { (0,0) = 2 and (0,-1) = 2 and (-1,0) = 2 }
rule : 2 70 { (0,0) = 2 and (0,1) = 2 and (-1,0) = 2 } 
rule : 2 70 { (0,0) = 2 and (0,1) = 2 and (1,0) = 2 } 
rule : 2 70 { (0,0) = 2 and (0,-1) = 2 and (1,0) = 2 } 

%Lynx Rules
rule : 0 70 { (0,0) = 2 and (-1,0) = 1 } 
rule : 0 70 { (0,0) = 2 and (0,1) = 1 } 
rule : 0 70 { (0,0) = 2 and (1,0) = 1 } 
rule : 0 70 { (0,0) = 2 and (0,-1) = 1 }

rule : 2 70 { (0,0) = 1 and (1,0) = 2 } 
rule : 2 70 { (0,0) = 1 and (0,-1) = 2 and (-1,-1) = 0} 
rule : 2 70 { (0,0) = 1 and (-1,0) = 2 and ((-2,0) = 0 and (-1,1) = 0) } 
rule : 2 70 { (0,0) = 1 and (0,1) = 2 and ((0,2) = 0 and (-1,1) = 0 and (1,1) = 0 )}

rule : 0 100 { (0,0) = 1 and ((0,1) = 0 or (1,0) = 0 or (0,-1) = 0 or (-1,0) = 0 )}

 
%Hare Movement Rules
rule : 1 100 { (0,0) = 0 and (1,0) = 1 }
rule : 1 100 { (0,0) = 0 and ((0,-1) = 1 and (-1,-1) = 1) } 
rule : 1 100 { (0,0) = 0 and ((-1,0) = 1 and (-2,0) = 1 and (-1,1) = 1) } 
rule : 1 100 { (0,0) = 0 and ((0,1) = 1 and (-1,1) = 1 and (0,2) = 1 and (1,1) = 1) } 

%Lynx Movement Rules
rule : 2 70 { (0,0) = 0 and (1,0) = 2 and (1,1) != 1 and (2,0) != 1 and (1,-1) != 1} 
rule : 2 70 { (0,0) = 0 and ((0,-1) = 2 and (-1,-1) = 2)} 
rule : 2 70 { (0,0) = 0 and ((-1,0) = 2 and (-2,0) = 2 and (-1,1) = 2) } 
rule : 2 70 { (0,0) = 0 and ((0,1) = 2 and (-1,1) = 2 and (0,2) = 2 and (1,1) = 2)} 

rule : 0 100 { t } 