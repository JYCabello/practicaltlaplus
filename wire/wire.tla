-------------------------------- MODULE wire --------------------------------
EXTENDS Integers

(*--algorithm wire

variables
    people = {"alice", "bob"},
    acc = [p \in people |-> 5],
    sender = "alice",
    receiver = "bob",
    amount = 3;

define
    NoOverdrafts == \A p \in people: acc[p] >= 0
end define;

begin
    Withdraw:
        acc[sender] := acc[sender] - amount;
    Deposit:
        acc[receiver] := acc[receiver] - amount;

end algorithm;*)

=============================================================================
