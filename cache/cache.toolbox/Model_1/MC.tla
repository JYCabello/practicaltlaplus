---- MODULE MC ----
EXTENDS cache, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
a, b
----

\* MV CONSTANT definitions Actors
const_16120373745032000 == 
{a, b}
----

\* CONSTANT definitions @modelParameterConstants:0ResourceCap
const_16120373745033000 == 
6
----

\* CONSTANT definitions @modelParameterConstants:1MaxConsumerReq
const_16120373745034000 == 
2
----

=============================================================================
\* Modification History
\* Created Sat Jan 30 21:09:34 CET 2021 by YerayCabello
