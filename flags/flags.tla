------------------------------- MODULE flags -------------------------------
EXTENDS TLC
Flags == {"f1", "f2"}
(*--algorithm flags
variables
  flags = [f \in Flags |-> FALSE];
begin
    with f \in Flags do
        flags[f] := TRUE;
    end with;
    print flags
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-472e69f9ef3f8bb3c2304ebf00880783
VARIABLES flags, pc

vars == << flags, pc >>

Init == (* Global variables *)
        /\ flags = [f \in Flags |-> FALSE]
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ \E f \in Flags:
              flags' = [flags EXCEPT ![f] = TRUE]
         /\ PrintT(flags')
         /\ pc' = "Done"

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-b4abd3153b2182229ac49f0ccca86359

=============================================================================
