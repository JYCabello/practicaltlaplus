------------------------------ MODULE recycler ------------------------------
EXTENDS Sequences, Integers, TLC, FiniteSets
(*--algorithm recycler
variables
    capacity = [trash |-> 10, recycle |-> 10],
    bins = [trash |-> {}, recycle |-> {}],
    count = [trash |-> 0, recycle |-> 0],
    items = <<
        [type |-> "recycle", size |-> 5],
        [type |-> "trash", size |-> 5],
        [type |-> "recycle", size |-> 4],
        [type |-> "recycle", size |-> 3]
    >>;
    
macro add_item(type, current) begin
  bins[type] := bins[type] \union {current};
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
     assert Cardinality(bins.trash) = count.trash;
     assert Cardinality(bins.recycle) = count.recycle;
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-eeed8025f325d4141908304435d19e5b
VARIABLES capacity, bins, count, items, pc

vars == << capacity, bins, count, items, pc >>

Init == (* Global variables *)
        /\ capacity = [trash |-> 10, recycle |-> 10]
        /\ bins = [trash |-> {}, recycle |-> {}]
        /\ count = [trash |-> 0, recycle |-> 0]
        /\ items =         <<
                       [type |-> "recycle", size |-> 5],
                       [type |-> "trash", size |-> 5],
                       [type |-> "recycle", size |-> 4],
                       [type |-> "recycle", size |-> 3]
                   >>
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF items /= <<>>
               THEN /\ LET current == Head(items) IN
                         /\ items' = Tail(items)
                         /\ IF current.type = "recycle" /\ current.size < capacity.recycle
                               THEN /\ bins' = [bins EXCEPT !["recycle"] = bins["recycle"] \union {current}]
                                    /\ capacity' = [capacity EXCEPT !["recycle"] = capacity["recycle"] - current.size]
                                    /\ count' = [count EXCEPT !["recycle"] = count["recycle"] + 1]
                               ELSE /\ IF current.size < capacity.trash
                                          THEN /\ bins' = [bins EXCEPT !["trash"] = bins["trash"] \union {current}]
                                               /\ capacity' = [capacity EXCEPT !["trash"] = capacity["trash"] - current.size]
                                               /\ count' = [count EXCEPT !["trash"] = count["trash"] + 1]
                                          ELSE /\ TRUE
                                               /\ UNCHANGED << capacity, bins, 
                                                               count >>
                    /\ pc' = "Lbl_1"
               ELSE /\ Assert(capacity.trash > -1 /\ capacity.recycle > -1, 
                              "Failure of assertion at line 32, column 6.")
                    /\ Assert(Cardinality(bins.trash) = count.trash, 
                              "Failure of assertion at line 33, column 6.")
                    /\ Assert(Cardinality(bins.recycle) = count.recycle, 
                              "Failure of assertion at line 34, column 6.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << capacity, bins, count, items >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-5820c1532f52c3b613e0b3fb5f11a8b5
=============================================================================
