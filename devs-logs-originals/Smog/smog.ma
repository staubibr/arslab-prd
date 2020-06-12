[top]
components : smog

[smog]
type : cell
width : 20
height : 20
delay : transport
defaultDelayTime : 100000
border : nowrapped
neighbors : smog(-1,0) smog(1,0)
neighbors : smog(0,-1) smog(0,0) smog(0,1) 
initialvalue : 0

localtransition : smog-rule
statevariables: value
statevalues: 0
initialvariablesvalue: smog.stvalues


[smog-rule]
rule : { $value } { $value := 15; } 100000 { $value =15 }
rule : { $value } { $value := 1; } 100000 { $value =1 }
rule : { $value } { $value := 2; } 200000 { $value =16 and normal(0.4,0.3)>0.15 }
rule : { $value } { $value := 2; } 200000 { $value =17 and normal(0.4,0.3)>0.15 }
rule : { $value } { $value := 2; } 250000 { $value =18 and normal(0.4,0.3)>0.15 }
rule : { $value } { $value := 8; } 250000 { $value =7 and normal(0.4,0.3)>0.15 }
rule : { $value } { $value := 3; } 300000 { $value =2 }
rule : { $value } { $value := 9; } 300000 { $value =8 }
rule : { $value } { $value := 4; } 400000 { $value =3 }
rule : { $value } { $value := 10; } 400000 { $value =9 }
rule : { $value } { $value := 5; } 500000 { $value =4 }
rule : { $value } { $value := 11; } 500000 { $value =10 }
rule : { $value } { $value := 6; } 600000 { $value =5 }
rule : { $value } { $value := 12; } 600000 { $value =11 }
rule : { $value } { $value := 13; } 700000 { $value =12 }
