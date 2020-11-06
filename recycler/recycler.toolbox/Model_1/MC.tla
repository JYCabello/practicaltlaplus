---- MODULE MC ----
EXTENDS recycler, TLC

\* Constant expression definition @modelExpressionEval
const_expr_16046580808223000 == 
(1..2) \ (2..3)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_16046580808223000>>)
----

=============================================================================
