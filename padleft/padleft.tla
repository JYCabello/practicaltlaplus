------------------------------ MODULE padleft ------------------------------
EXTENDS Integers, Sequences, TLC

PT == INSTANCE PT

Max(a, b) == IF a > b THEN a ELSE b

Leftpad(c, n, str) ==
  LET
    outputLength == PT!Max(Len(str), n)
    paddingLength == CHOOSE x \in 0..n: Len(str) + x = outputLength
    \* This returns <<>> if paddingLength = 0
    padding == [x \in 1..paddingLength |-> c]
  IN
    padding \o str 

(*--algorithm leftpad
begin
  print(Leftpad(" ", 2, <<"a", "a", "a">>));
  print(Leftpad(" ", 4, <<"a", "a", "a">>));
  print(Leftpad(" ", 6, <<"a", "a", "a">>));
skip;
end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "172a4c02" /\ chksum(tla) = "bab91400")
VARIABLE pc

vars == << pc >>

Init == /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ PrintT((Leftpad(" ", 2, <<"a", "a", "a">>)))
         /\ PrintT((Leftpad(" ", 4, <<"a", "a", "a">>)))
         /\ PrintT((Leftpad(" ", 6, <<"a", "a", "a">>)))
         /\ TRUE
         /\ pc' = "Done"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION 


=============================================================================
