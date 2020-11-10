------------------------------ MODULE knapsack ------------------------------
EXTENDS TLC, Integers, Sequences
PT == INSTANCE PT
Capacity == 7
Items == {"a", "b", "c"}
ItemParams == [size: 2..4, value: 0..5]
ItemSets == [Items -> ItemParams]

KnapsackSize(sack, itemset) ==
  LET size_for(item) == itemset[item].size * sack[item]
  IN PT!ReduceSet(LAMBDA item, acc: size_for(item) + acc, Items, 0)
  
ValidKnapsacks(itemset) ==
  {sack \in [Items -> 0..4]: KnapsackSize(sack, itemset) <= Capacity}
  
KnapsackValue(sack, itemset) ==
  LET value_for(item) == itemset[item].value * sack[item]
  IN PT!ReduceSet(LAMBDA item, acc: value_for(item) + acc, Items, 0)
  
BestKnapsack(itemset) ==
  LET all == ValidKnapsacks(itemset)
  IN CHOOSE best \in all:
    \A worse \in all \ {best}:
    KnapsackValue(best, itemset) > KnapsackValue(worse, itemset)  
    
(*--algorithm debug
variables itemset \in ItemSets
begin
  assert BestKnapsack(itemset) \in ValidKnapsacks(itemset);
end algorithm; *)
\* BEGIN TRANSLATION - the hash of the PCal code: PCal-68945b317b4b1bf091b2752e15abcab9
VARIABLES itemset, pc

vars == << itemset, pc >>

Init == (* Global variables *)
        /\ itemset \in ItemSets
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ Assert(BestKnapsack(itemset) \in ValidKnapsacks(itemset), 
                   "Failure of assertion at line 29, column 3.")
         /\ pc' = "Done"
         /\ UNCHANGED itemset

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION - the hash of the generated TLA code (remove to silence divergence warnings): TLA-bd77f4bc4963f4773f4e894fd29c453a
=============================================================================
