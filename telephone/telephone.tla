----------------------------- MODULE telephone -----------------------------
EXTENDS Sequences, TLC
(*--algorithm telephone
variables
  to_send = <<1, 2, 3>>,
  received = <<>>,
  in_transit = {};
begin
  while Len(received) /= 3 do
    \* send
    if to_send /= <<>> then
      in_transit := in_transit \union {Head(to_send)};
      to_send := Tail(to_send);
    end if;
    \* receive
    either
      with msg \in in_transit do
        received := Append(received, msg);
        in_transit := in_transit \ {msg}
      end with;
    or
      skip;
    end either;
  end while;
  assert received = <<1, 2, 3>>;
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-984a6255e785d12200f14342647d9782
VARIABLES to_send, received, in_transit, pc

vars == << to_send, received, in_transit, pc >>

Init == (* Global variables *)
        /\ to_send = <<1, 2, 3>>
        /\ received = <<>>
        /\ in_transit = {}
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF Len(received) /= 3
               THEN /\ IF to_send /= <<>>
                          THEN /\ in_transit' = (in_transit \union {Head(to_send)})
                               /\ to_send' = Tail(to_send)
                          ELSE /\ TRUE
                               /\ UNCHANGED << to_send, in_transit >>
                    /\ \/ /\ pc' = "Lbl_2"
                       \/ /\ TRUE
                          /\ pc' = "Lbl_1"
               ELSE /\ Assert(received = <<1, 2, 3>>, 
                              "Failure of assertion at line 25, column 3.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << to_send, in_transit >>
         /\ UNCHANGED received

Lbl_2 == /\ pc = "Lbl_2"
         /\ \E msg \in in_transit:
              /\ received' = Append(received, msg)
              /\ in_transit' = in_transit \ {msg}
         /\ pc' = "Lbl_1"
         /\ UNCHANGED to_send

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-563e27e34e4962e32f81e50cee50cb4d

=============================================================================
