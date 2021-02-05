------------------------------ MODULE padleft ------------------------------
EXTENDS Integers, Sequences, TLC

PT == INSTANCE PT

Characters == {"a", "b", "c"}
PadChar == " "

LeftPad(c, n, str) ==
  LET
    outputLength == PT!Max(Len(str), n)
    paddingLength == CHOOSE x \in 0..n: Len(str) + x = outputLength
    \* This returns <<>> if paddingLength = 0
    padding == [x \in 1..paddingLength |-> c]
  IN
    padding \o str 

(*--fair algorithm leftpad
variables
  finalLength \in 0..6,
  inputString \in PT!SeqOf(Characters, 6),
  output;        

begin
Initializing:
  output := inputString;
Processing:
  while Len(output) < finalLength do
    output := <<PadChar>> \o output;
  end while;
Assertions:
  assert output = LeftPad(PadChar, finalLength, inputString);
end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "40420e2c" /\ chksum(tla) = "e947188b")
CONSTANT defaultInitValue
VARIABLES finalLength, inputString, output, pc

vars == << finalLength, inputString, output, pc >>

Init == (* Global variables *)
        /\ finalLength \in 0..6
        /\ inputString \in PT!SeqOf(Characters, 6)
        /\ output = defaultInitValue
        /\ pc = "Initializing"

Initializing == /\ pc = "Initializing"
                /\ output' = inputString
                /\ pc' = "Processing"
                /\ UNCHANGED << finalLength, inputString >>

Processing == /\ pc = "Processing"
              /\ IF Len(output) < finalLength
                    THEN /\ output' = <<PadChar>> \o output
                         /\ pc' = "Processing"
                    ELSE /\ pc' = "Assertions"
                         /\ UNCHANGED output
              /\ UNCHANGED << finalLength, inputString >>

Assertions == /\ pc = "Assertions"
              /\ Assert(output = LeftPad(PadChar, finalLength, inputString), 
                        "Failure of assertion at line 32, column 3.")
              /\ pc' = "Done"
              /\ UNCHANGED << finalLength, inputString, output >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Initializing \/ Processing \/ Assertions
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION 


=============================================================================
