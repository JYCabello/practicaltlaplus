------------------------------ MODULE sandbox ------------------------------
EXTENDS TLC, Integers, Sequences, FiniteSets
PT == INSTANCE PT
(*--algorithm sandbox
define
Solve == CHOOSE <<x, y>> \in (-100..100) \X (-100..100):
                /\ 2*x + 2*y = -2
                /\ 3*x - 4*y = 11
SumUpTo(n) ==
  PT!ReduceSet(LAMBDA x, y: x + y, 0..n, 0)
  
DoubleFromTenToTwenty ==
    [x \in (10..20) |-> x * 2]

FuncA[x \in {"a", "b", "c"}] ==
    "FuncA received " \o x

FuncB[x \in {"c", "d", "e"}] ==
    "FuncB received " \o x

FuncAB == FuncB @@ FuncA
end define;


begin
assert 9 = 8 <=> 9 = 8;
assert 9 = 9 <=> 9 = 9;
print Solve;
print SumUpTo(11);
print "abc" \o "def";
with item \in DOMAIN FuncAB do
    print FuncAB[item];
end with;
end algorithm;  *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-ec4b5a19fef19bfe988494a18135f761
VARIABLE pc

(* define statement *)
Solve == CHOOSE <<x, y>> \in (-100..100) \X (-100..100):
                /\ 2*x + 2*y = -2
                /\ 3*x - 4*y = 11
SumUpTo(n) ==
  PT!ReduceSet(LAMBDA x, y: x + y, 0..n, 0)

DoubleFromTenToTwenty ==
    [x \in (10..20) |-> x * 2]

FuncA[x \in {"a", "b", "c"}] ==
    "FuncA received " \o x

FuncB[x \in {"c", "d", "e"}] ==
    "FuncB received " \o x

FuncAB == FuncB @@ FuncA


vars == << pc >>

Init == /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ Assert(9 = 8 <=> 9 = 8, 
                   "Failure of assertion at line 26, column 1.")
         /\ Assert(9 = 9 <=> 9 = 9, 
                   "Failure of assertion at line 27, column 1.")
         /\ PrintT(Solve)
         /\ PrintT(SumUpTo(11))
         /\ PrintT("abc" \o "def")
         /\ \E item \in DOMAIN FuncAB:
              PrintT(FuncAB[item])
         /\ pc' = "Done"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-63428c0155e7b2ca706a26fb04a9c75d
=============================================================================
