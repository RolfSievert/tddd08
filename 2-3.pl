% An Abstract Machine
execute(S0, skip, S0).

% Assumes E is a Number to begin with
execute(S0, set(I, E), Sn) :-
	Sn = [I=E].

%execute(_S0, if(B, C, C), _Sn).

%execute(_S0, while(B, C), _Sn).

%execute(_S0, seq(C, C), _Sn).

