---- MODULE MC ----
EXTENDS my_max, TLC

\* Constant expression definition @modelExpressionEval
const_expr_161221288465632000 == 
Max2(<<1,2,4,52,2>>)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_161221288465632000>>)
----

=============================================================================
\* Modification History
\* Created Mon Feb 01 21:54:44 CET 2021 by YerayCabello
