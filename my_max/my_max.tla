------------------------------- MODULE my_max -------------------------------
EXTENDS Sequences, Integers

Max(seq) ==
  LET set == {seq[i]: i \in DOMAIN seq}
  IN CHOOSE x \in set: \A y \in set: y <= x
  
Max2(seq) ==
  seq[CHOOSE x \in DOMAIN seq:
          \A y \in DOMAIN seq:
            seq[x] >= seq[y]
  ]

=============================================================================
