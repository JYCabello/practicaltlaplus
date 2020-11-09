---- MODULE MC ----
EXTENDS recycler, TLC

\* INIT definition @modelBehaviorNoSpec:0
init_160469317134714000 ==
FALSE/\people = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_160469317134715000 ==
FALSE/\people' = people
----
=============================================================================
\* Modification History
\* Created Fri Nov 06 21:06:11 CET 2020 by yeray
