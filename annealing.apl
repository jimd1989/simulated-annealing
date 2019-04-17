⍝ Workspace for Simulated Annealing example. For more information, please read https://dalrym.pl/writing/20180429-simulated-annealing.html

yellow blue red ivory green←⍳5
norwegian ukranian englishman spaniard japanese←⍳5
water tea milk oj coffee←⍳5
kool chesterfield oldgold luckystrike parliament←⍳5
fox horse snail dog zebra←⍳5

color person drink cigarette pet←⍳5

P←⍋⍤1⊢5 5⍴25?25

match←{P xs x n ys y←⍵ ⋄ (P[xs;]⍳x)=n+(P[ys;]⍳y)}

c1←{match ⍵ color red on person englishman}
c2←{match ⍵ person spaniard on pet dog}
c3←{match ⍵ color green on drink coffee}
c4←{match ⍵ person ukranian on drink tea}
c5←{match ⍵ color green rightof color ivory}
c6←{match ⍵ cigarette oldgold on pet snail}
c7←{match ⍵ cigarette kool on color yellow}
c8←{milk=3⌷drink⌷⍵}
c9←{1=⍵[person;]⍳norwegian}
c10←{(match ⍵ cigarette chesterfield leftof pet fox) ∨ (match ⍵ cigarette chesterfield rightof pet fox)}
c11←{(match ⍵ cigarette kool leftof pet horse) ∨ (match ⍵ cigarette kool rightof pet horse)}
c12←{match ⍵ cigarette luckystrike on drink oj}
c13←{match ⍵ person japanese on cigarette parliament}
c14←{(match ⍵ color blue leftof person norwegian) ∨ (match ⍵ color blue rightof person norwegian)}

cost←{14 - +/(c1 ⍵)(c2 ⍵)(c3 ⍵)(c4 ⍵)(c5 ⍵)(c6 ⍵)(c7 ⍵)(c8 ⍵)(c9 ⍵)(c10 ⍵)(c11 ⍵)(c12 ⍵)(c13 ⍵)(c14 ⍵)}

swap←{x y z←⍵{⍵,⍺[⊃⍵]}2↑(≢⍵)?≢⍵⋄z@y⊢⍵[y]@x⊢⍵}

change←{swap@(?≢⍵)⊢⍵}

annealing w;P;t;c;i;NP;nt;nc;d
(P t c i)←w
⎕←t c i
:If c=0
    P
:Else
    NP←change P
    nt←t-(t≠0.2)×0.05×0=500|i
    nc←cost NP
    d←nc-c
    :If d≤0
        annealing NP nt nc(i+1)
    :Else
        :If ((?1000)÷1000)<*-d÷t
            annealing NP nt nc(i+1)
        :Else
            annealing P nt c(i+1)
        :EndIf
    :EndIf
:EndIf

annealing P 1.0 (cost P) 1
