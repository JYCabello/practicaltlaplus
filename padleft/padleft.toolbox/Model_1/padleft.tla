------------------------------ MODULE padleft ------------------------------
EXTENDS Integers, Sequences, TLC

PT == INSTANCE PT

Characters == {"a", "b", "c"}
MaxLength == 5

LeftPad(c, n, str) ==
  IF n < 0 THEN str ELSE
  LET
    outputLength == PT!Max(Len(str), n)
    paddingLength == CHOOSE x \in 0..n: Len(str) + x = outputLength
    \* This returns <<>> if paddingLength = 0
    padding == [x \in 1..paddingLength |-> c]
  IN
    padding \o str 

(*--fair algorithm leftpad
variables
  finalLength \in -1..MaxLength,
  inputString \in PT!SeqOf(Characters, MaxLength),
  padChar \in Characters,
  output;        

begin
InitialSetup:
  output := inputString;
Iteration:
  while Len(output) < finalLength do
    output := <<padChar>> \o output;
  end while;
Assertion:
  assert output = LeftPad(padChar, finalLength, inputString);
end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "3e225c5c" /\ chksum(tla) = "8b43172")
CONSTANT defaultInitValue
VARIABLES finalLength, inputString, padChar, output, pc

vars == << finalLength, inputString, padChar, output, pc >>

Init == (* Global variables *)
        /\ finalLength \in -1..MaxLength
        /\ inputString \in PT!SeqOf(Characters, MaxLength)
        /\ padChar \in Characters
        /\ output = defaultInitValue
        /\ pc = "InitialSetup"

InitialSetup == /\ pc = "InitialSetup"
                /\ output' = inputString
                /\ pc' = "Iteration"
                /\ UNCHANGED << finalLength, inputString, padChar >>

Iteration == /\ pc = "Iteration"
             /\ IF Len(output) < finalLength
                   THEN /\ output' = <<padChar>> \o output
                        /\ pc' = "Iteration"
                   ELSE /\ pc' = "Assertion"
                        /\ UNCHANGED output
             /\ UNCHANGED << finalLength, inputString, padChar >>

Assertion == /\ pc = "Assertion"
             /\ Assert(output = LeftPad(padChar, finalLength, inputString), 
                       "Failure of assertion at line 34, column 3.")
             /\ pc' = "Done"
             /\ UNCHANGED << finalLength, inputString, padChar, output >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == InitialSetup \/ Iteration \/ Assertion
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 


=============================================================================
