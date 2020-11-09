------------------------------ MODULE knapsack ------------------------------
EXTENDS TLC, Integers, Sequences
PT == INSTANCE PT
Capacity == 7
Items == {"a", "b", "c"}
ItemParams == [size: 2..4, value: 0..5]
ItemSets == [Items -> ItemParams]
=============================================================================
