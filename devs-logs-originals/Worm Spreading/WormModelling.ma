#include(s_qrule.inc)

[top]
components : WormModel

[WormModel]
type : cell
dim : (50,50)
delay : transport
defaultDelayTime  : 10
border : nowrapped
neighbors : (-2,-2) (-2,-1) (-2,0) (-2,1) (-2,2)
neighbors : (-1,-2) (-1,-1) (-1,0) (-1,1) (-1,2)
neighbors : (0,-2) (-0,-1) (0,0) (0,1) (0,2)
neighbors : (1,-2) (1,-1) (1,0) (1,1) (1,2)
neighbors : (2,-2) (2,-1) (2,0) (2,1) (2,2)
initialvalue : 0
initialCellsValue : WormModelling.val
localtransition : WormSpreading

[WormSpreading]
% s to q 
rule : 1 100  { (0,0)=0 and ( #macro(Inner_Factor) * #macro(inner_be2) + #macro(Outer_Factor) * #macro(outer_be2) > 7) and random < ( #macro(Vigilance) *  ( #macro(Inner_Factor) * #macro(inner_be2)/8 + #macro(Outer_Factor) * #macro(outer_be2)/16 ) ) }
rule : 1 100  { (0,0)=0 and ( #macro(Inner_Factor) * #macro(inner_be1) + #macro(Outer_Factor) * #macro(outer_be1) > 0) and random < ( #macro(Vigilance) *  ( #macro(Inner_Factor) * #macro(inner_be1)/8 + #macro(Outer_Factor) * #macro(outer_be1)/16 ) ) }  
% q to s 
rule : { if ( random < #macro(Get_Inmune_After_Questioned), -1, 0) } 100  { (0,0)=1 } 
% q to r
% s to i
rule : 2 100  { (0,0)=0 and stateCount(2) > 0 and random < #macro(Possibility_Of_Spreading) *  ( #macro(Inner_Factor) * #macro(inner_be2)/8 + #macro(Outer_Factor) * #macro(outer_be2)/16 )  } 
% i to r
rule : -1 100 { (0,0)=2 and ( #macro(Inner_Factor) * #macro(inner_be2) + #macro(Outer_Factor) * #macro(outer_be2) > 5) and random < ( #macro(Responsibility) *  ( #macro(Inner_Factor) * #macro(inner_be2)/8 + #macro(Outer_Factor) * #macro(outer_be2)/16 ) ) }
rule : { (0,0) } 100 { t }