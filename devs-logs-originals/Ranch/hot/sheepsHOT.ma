[top]
components : sheeps

[sheeps]
type : cell
dim : (20,20)
delay : transport
defaultDelayTime  : 100
border : nowrapped 
neighbors : sheeps(-1,-1) sheeps(-1,0) sheeps(-1,1) 
neighbors : sheeps(0,-1)  sheeps(0,0)  sheeps(0,1)
neighbors : sheeps(1,-1)  sheeps(1,0)  sheeps(1,1)
initialvalue : 0
initialrow : 0	   2 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0
initialrow : 1     2 0 0 0 0 0 2 0 0 0 0 2 0 0 0 0 0 2 2 0
initialrow : 4     0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0
initialrow : 5     2 0 0 0 0 2 0 2 0 0 0 0 0 0 0 0 0 0 0 2
initialrow : 8     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 9     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 10    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 11    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 12    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 13    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 14    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 15    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 16    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 17    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 18    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
initialrow : 19    1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
localtransition : hot-rule

[hot-rule]
rule : 2          1000 { randInt(10) < 7 and (0,0) = 0 }
rule : 0	  1000 { (0,0) = 1 and randInt(10) < 5 }
rule : 1          1000 { (0,0) = 1 and randInt(10) >= 5 }
rule : 0          1000 { randInt(10) >= 7 and (0,0) = 0 }
rule : {(0,0)} 	  1000 { t } 