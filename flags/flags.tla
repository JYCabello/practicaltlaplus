------------------------------- MODULE flags -------------------------------
EXTENDS TLC, Integers, Sequences, FiniteSets
Flags == {"f1", "f2"}
(*--algorithm flags
variables
  flags \in {config \in [Flags -> BOOLEAN]: \E f \in Flags: config[f]};
begin
    with f \in Flags do
        flags[f] := TRUE;
    end with;
    print flags
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-ade1e31a5a07d33d67ca193fa875661e
VARIABLES flags, pc

vars == << flags, pc >>

Init == (* Global variables *)
        /\ flags \in {config \in [Flags -> BOOLEAN]: \E f \in Flags: config[f]}
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

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-cb3b89f8099a3dd65bdcb6886a599a72

=============================================================================
