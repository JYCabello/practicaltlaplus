------------------------------ MODULE traffic ------------------------------
(*--algorithm traffic
variables
  at_light = TRUE,
  light = "red";
    
define
  NextColor(c) == CASE c = "red" -> "green"
                    [] c = "green" -> "red"
end define;

fair process light = "light"
begin
  Cycle:
    while at_light do
      light := NextColor(light);
    end while;
end process;

fair+ process car = "car"
begin
  Drive:
    when light = "green";
    at_light := FALSE;
end process;
end algorithm;*)
\* BEGIN TRANSLATION (chksum(pcal) = "14a57083" /\ chksum(tla) = "dc51c126")
\* Process light at line 12 col 6 changed to light_
VARIABLES at_light, light, pc

(* define statement *)
NextColor(c) == CASE c = "red" -> "green"
                  [] c = "green" -> "red"


vars == << at_light, light, pc >>

ProcSet == {"light"} \cup {"car"}

Init == (* Global variables *)
        /\ at_light = TRUE
        /\ light = "red"
        /\ pc = [self \in ProcSet |-> CASE self = "light" -> "Cycle"
                                        [] self = "car" -> "Drive"]

Cycle == /\ pc["light"] = "Cycle"
         /\ IF at_light
               THEN /\ light' = NextColor(light)
                    /\ pc' = [pc EXCEPT !["light"] = "Cycle"]
               ELSE /\ pc' = [pc EXCEPT !["light"] = "Done"]
                    /\ light' = light
         /\ UNCHANGED at_light

light_ == Cycle

Drive == /\ pc["car"] = "Drive"
         /\ light = "green"
         /\ at_light' = FALSE
         /\ pc' = [pc EXCEPT !["car"] = "Done"]
         /\ light' = light

car == Drive

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == light_ \/ car
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(light_)
        /\ SF_vars(car)

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 

=============================================================================
\* Modification History
\* Last modified Sat Jan 30 22:40:20 CET 2021 by YerayCabello
\* Created Sat Jan 30 21:32:27 CET 2021 by YerayCabello
