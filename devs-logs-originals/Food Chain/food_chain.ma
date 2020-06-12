[top]
components : food_chain

[food_chain]
type : cell
dim : (20,20)
delay : transport
defaultDelayTime : 100
border : wrapped 

%Von Neuman Neighborhood
neighbors :                  food_chain(-1,0) 
neighbors : food_chain(0,-1) food_chain(0,0) food_chain(0,1)
neighbors :                  food_chain(1,0) 

initialvalue : 0
initialCellsValue : food_chain.val
localtransition : food_chain-rule

[food_chain-rule]
%bear(4) eats fox(3) and jumps to that place
rule : 4 100 { ((0,0) = 3 and (0,1) = 4) or
               ((0,0) = 3 and (1,0) = 4) or
               ((0,0) = 3 and (0,-1) = 4) or
               ((0,0) = 3 and (-1,0) = 4) }

%bear(4) dies as it is alone               
rule : 0 100 { (-1,0) = 4 or (0,0) = 4 or (0,1) = 4 or (1,0) = 4 or (0,-1) = 4 }

%bear(4) jumps to vacancy(1) in it's neighborhood
rule : 4 100 { ((0,0) = 1 and (0,1) = 4) or
               ((0,0) = 1 and (1,0) = 4) or
               ((0,0) = 1 and (0,-1) = 4) or
               ((0,0) = 1 and (-1,0) = 4) }

%fox(3) eats rabbit(2) and jumps to that place               
rule : 3 100 { ((0,0) = 2 and (0,1) = 3) or
               ((0,0) = 2 and (1,0) = 3) or
               ((0,0) = 2 and (0,-1) = 3) or
               ((0,0) = 2 and (-1,0) = 3) }

%fox(3) dies as it is alone                             
rule : 0 100 { (-1,0) = 3 or (0,0) = 3 or (0,1) = 3 or (1,0) = 3 or (0,-1) = 3 }

%fox(3) jumps to vacancy(1) in it's neighborhood
rule : 3 100 { ((0,0) = 1 and (0,1) = 3) or
               ((0,0) = 1 and (1,0) = 3) or
               ((0,0) = 1 and (0,-1) = 3) or
               ((0,0) = 1 and (-1,0) = 3) }
               
%rabbit(2) reproduces in vacancy(1) of it's neighborhood               
rule : 2 100 { ((0,0) = 1 and (0,1) = 2) or
               ((0,0) = 1 and (1,0) = 2) or
               ((0,0) = 1 and (0,-1) = 2) or
               ((0,0) = 1 and (-1,0) = 2) }

%for all the other cases retain value               
rule : {(0,0)} 100 { t }




