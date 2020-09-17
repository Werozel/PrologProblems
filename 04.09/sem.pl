parent(ann, nick).
parent(tom, nick).
parent(tom, john).
parent(nick, terry).
parent(nick, bob).
parent(terry, mary).
parent(terry, ron).
parent(john, phil).
parent(john, max).
parent(john, liz).
parent(max, jinny).

woman(ann).
woman(liz).
woman(jinny).

man(tom).
man(nick).
man(john).
man(terry).
man(bob).
man(phil).
man(max).
man(ron).

brother(X, Y) :- 
    parent(Z, X), 
    parent(Z, Y), 
    dif(X, Y), 
    man(X).

mother(X, Y) :-
    parent(X, Y),
    woman(X).

grandfather(X, Y) :-
    parent(X, Z),
    parent(Z, Y),
    man(X).


