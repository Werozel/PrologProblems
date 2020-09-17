tree_depth(empty, 0).
tree_depth(tree(L, _, R), N1) :- 
    tree_depth(L, NL), 
    tree_depth(R, NR),
    N1 is max(NL, NR) + 1.
