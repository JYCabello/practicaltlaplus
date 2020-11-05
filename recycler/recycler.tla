------------------------------ MODULE recycler ------------------------------
EXTENDS Sequences, Integers, TLC, FiniteSets
(*--algorithm recycler
variables
    capacity \in [trash: 1..10, recycle: 1..10],
    bins = [trash |-> <<>>, recycle |-> <<>>],
    count = [trash |-> 0, recycle |-> 0],
    item = [type: {"trash", "recycle"}, size: 1..6],
    items \in item \X item \X item \X item;
    
macro add_item(type, current) begin
  bins[type] := Append(bins[type], current);
  capacity[type] := capacity[type] - current.size;
  count[type] := count[type] + 1;
end macro;

begin
    while items /= <<>> do
        with current = Head(items) do
            items := Tail(items);               
            if current.type = "recycle" /\ current.size < capacity.recycle then
                add_item("recycle", current);
            elsif current.size < capacity.trash then
                add_item("trash", current);
            end if;
        end with;
     end while;
     assert capacity.trash > -1 /\ capacity.recycle > -1;
     assert Len(bins.trash) = count.trash;
     assert Len(bins.recycle) = count.recycle;
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-f9489c3f47f950586084f5f167e55d36
VARIABLES capacity, bins, count, item, items, pc

vars == << capacity, bins, count, item, items, pc >>

Init == (* Global variables *)
        /\ capacity \in [trash: 1..10, recycle: 1..10]
        /\ bins = [trash |-> <<>>, recycle |-> <<>>]
        /\ count = [trash |-> 0, recycle |-> 0]
        /\ item = [type: {"trash", "recycle"}, size: 1..6]
        /\ items \in item \X item \X item \X item
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF items /= <<>>
               THEN /\ LET current == Head(items) IN
                         /\ items' = Tail(items)
                         /\ IF current.type = "recycle" /\ current.size < capacity.recycle
                               THEN /\ bins' = [bins EXCEPT !["recycle"] = Append(bins["recycle"], current)]
                                    /\ capacity' = [capacity EXCEPT !["recycle"] = capacity["recycle"] - current.size]
                                    /\ count' = [count EXCEPT !["recycle"] = count["recycle"] + 1]
                               ELSE /\ IF current.size < capacity.trash
                                          THEN /\ bins' = [bins EXCEPT !["trash"] = Append(bins["trash"], current)]
                                               /\ capacity' = [capacity EXCEPT !["trash"] = capacity["trash"] - current.size]
                                               /\ count' = [count EXCEPT !["trash"] = count["trash"] + 1]
                                          ELSE /\ TRUE
                                               /\ UNCHANGED << capacity, bins, 
                                                               count >>
                    /\ pc' = "Lbl_1"
               ELSE /\ Assert(capacity.trash > -1 /\ capacity.recycle > -1, 
                              "Failure of assertion at line 28, column 6.")
                    /\ Assert(Len(bins.trash) = count.trash, 
                              "Failure of assertion at line 29, column 6.")
                    /\ Assert(Len(bins.recycle) = count.recycle, 
                              "Failure of assertion at line 30, column 6.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << capacity, bins, count, items >>
         /\ item' = item

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-34b2168ae5374864c372f1832b2bcc47
=============================================================================
