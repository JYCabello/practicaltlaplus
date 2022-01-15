---- MODULE MC ----
EXTENDS mapreduce, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
w1, w2, w3
----

\* MV CONSTANT definitions Workers
const_164228476362350000 == 
{w1, w2, w3}
----

\* CONSTANT definitions @modelParameterConstants:0ItemCount
const_164228476362351000 == 
4
----

\* CONSTANT definitions @modelParameterConstants:1ItemRange
const_164228476362352000 == 
0..2
----

=============================================================================
\* Modification History
\* Created Sat Jan 15 23:12:43 CET 2022 by yeray
