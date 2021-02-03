------------------------------- MODULE my_max -------------------------------
EXTENDS Integers, Sequences, TLC
CONSTANTS IntSet, MaxSeqLen
ASSUME IntSet \subseteq Int
ASSUME MaxSeqLen > 0
PT == INSTANCE PT
  
Max(seq) ==
  seq[CHOOSE x \in DOMAIN seq: \A y \in DOMAIN seq: seq[x] >= seq[y]]
  
AllInputs == PT!SeqOf(IntSet, MaxSeqLen) \ {<<>>}

(*--fair algorithm max
variables seq \in AllInputs, i = 1, max;
begin
  assert Len(seq) >= 1;
  max := seq[1];
  while i <= Len(seq) do
    max := IF seq[i] > max THEN seq[i] ELSE max;
    i := 1 + i;
  end while;  
  assert max = Max(seq);
end algorithm *)
\* BEGIN TRANSLATION (chksum(pcal) = "2d3b4205" /\ chksum(tla) = "770f547f")
CONSTANT defaultInitValue
VARIABLES seq, i, max, pc

vars == << seq, i, max, pc >>

Init == (* Global variables *)
        /\ seq \in AllInputs
        /\ i = 1
        /\ max = defaultInitValue
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ Assert(Len(seq) >= 1, 
                   "Failure of assertion at line 16, column 3.")
         /\ max' = seq[1]
         /\ pc' = "Lbl_2"
         /\ UNCHANGED << seq, i >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ IF i <= Len(seq)
               THEN /\ max' = (IF seq[i] > max THEN seq[i] ELSE max)
                    /\ i' = 1 + i
                    /\ pc' = "Lbl_2"
               ELSE /\ Assert(max = Max(seq), 
                              "Failure of assertion at line 22, column 3.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << i, max >>
         /\ seq' = seq

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 

=============================================================================
