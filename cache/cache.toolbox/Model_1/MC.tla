---- MODULE MC ----
EXTENDS cache, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b
----

\* MV CONSTANT definitions Actors
const_161057337782133000 == 
{a, b}
----

\* CONSTANT definitions @modelParameterConstants:0ResourceCap
const_161057337782134000 == 
6
----

\* CONSTANT definitions @modelParameterConstants:1MaxConsumerReq
const_161057337782135000 == 
2
----

=============================================================================
\* Modification History
\* Created Wed Jan 13 22:29:37 CET 2021 by YerayCabello
