%%% !!! THIS IS GENERATED FILE !!! Modify ttsconfig.p
﻿% for turbo-prolog
:- op('--', xfy, 500).
% for swi-prolog
:- op(500, xfy,'--').

version(0).
tts :- version(X), X > 99.
voice :- version(X), X < 99.

language('lv').
% fest_language('').

% IMPLEMENTED (X) or MISSING ( ) FEATURES:
% (X) new Version 1.5 format
% (X) route calculated prompts, left/right, u-turns, roundabouts, straight/follow
% (X) arrival
% (X) other prompts: attention (without Type implementation), location lost, off_route, exceed speed limit
% ( ) special grammar: onto_street / on_street / to_street
% (X) special grammar distinction for distance measure
% (N/A) special grammar: imperative/infinitive distincion for turns
% (X) distance measure: meters / feet / yard support
% (X) Street name announcement (suppress in prepare_roundabout)
% (X) Name announcement for destination / intermediate / GPX waypoint arrival
% (X) Time announcement for new and recalculated route (for recalculated suppress in appMode=car)
% ( ) word order checked


% ROUTE CALCULATED
string('route_is.ogg', 'Brauciens ir ').
string('route_calculate.ogg', 'Maršruts ir pārēķināts ').
string('distance.ogg', ', attālums ir ').

% LEFT/RIGHT
string('prepare.ogg', 'gatavoties pa ').
string('after.ogg', 'Pēc ').

string('left.ogg', 'griezties pa kreisi ').
string('left_sh.ogg', 'strauji pagriezties pa kreisi ').
string('left_sl.ogg', 'pagriezties pa kreisi ').
string('right.ogg', 'griezties pa labi ').
string('right_sh.ogg', 'strauji pagriezties pa labi ').
string('right_sl.ogg', 'pagriezties pa labi ').
string('left_keep.ogg', 'turēties pa kreisi ').
string('right_keep.ogg', 'turēties pa labi ').
% if needed, "left/right_bear.ogg" can be defined here also. "... (then) (bear_left/right)" is used in pre-announcements to indicate the direction of a successive turn AFTER the next turn.

% U-TURNS
string('prepare_make_uturn.ogg', 'Gatavojaties apgriezties pēc ').
string('make_uturn.ogg', ' apgriežaties ').
string('make_uturn_wp.ogg', 'Apgriežaties pie pirmās iespējas ').

% ROUNDABOUTS
string('prepare_roundabout.ogg', 'Sagatvojaties lokveida kustībai pēc ').
string('roundabout.ogg', ' iebrauciet lokveida krustojumā, un tad brauciet ').
string('then.ogg', 'tad ').
string('and.ogg', 'un ').
string('take.ogg', ' ').
string('exit.ogg', 'pagriezienā ').
string('exit2.ogg', 'izbrauciet ').
string('exit3.ogg', 'izbrauktuvē ').

string('1st.ogg', 'pirmajā ').
string('2nd.ogg', 'otrajā ').
string('3rd.ogg', 'trešajā ').
string('4th.ogg', 'ceturtajā ').
string('5th.ogg', 'piektajā ').
string('6th.ogg', 'sestajā ').
string('7th.ogg', 'septītajā ').
string('8th.ogg', 'astotajā ').
string('9th.ogg', 'devītajā ').
string('10th.ogg', 'desmitajā ').
string('11th.ogg', 'vienpadsmitajā ').
string('12th.ogg', 'divpadsmitajā ').
string('13th.ogg', 'trīspadsmitajā ').
string('14th.ogg', 'četrpadsmitajā ').
string('15th.ogg', 'piecpadsmitajā ').
string('16th.ogg', 'sešpadsmitajā ').
string('17th.ogg', 'septiņpadsmitajā ').

% STRAIGHT/FOLLOW
string('go_ahead.ogg', 'Dodaties taisni uz priekšu ').
string('follow.ogg', 'Brauciet pa ceļu ').

% ARRIVE
string('and_arrive_destination.ogg', 'un ierodaties galapunktā ').
string('reached_destination.ogg', 'jūs esiet nokļuvis galapunktā ').
string('and_arrive_intermediate.ogg', 'un nonākt pie jūsu pieturu ').
string('reached_intermediate.ogg', 'jūs esat sasniedzis savu, izmantojot punktu ').
string('and_arrive_waypoint.ogg', 'un nonākt pie jūsu pieturu GPX ').
string('reached_waypoint.ogg', 'jūs esat sasniedzis savu, izmantojot punktu GPX ').

% OTHER PROMPTS
string('attention.ogg', 'uzmanība, ').
string('location_lost.ogg', 'pazudis g p s signāls ').
string('off_route.ogg', 'jūs esat novirzījušies no maršruta ').
string('exceed_limit.ogg', 'Jums ir ātruma pārsniegšanu ').

% STREET NAME GRAMMAR
string('onto.ogg', 'uz ').
%string('on.ogg', 'on ').
%string('to.ogg', 'to ').

% DISTANCE UNIT SUPPORT
string('meters_1.ogg', 'meteriem ').
string('meters_2.ogg', 'meteri ').
string('around_1_kilometer_1.ogg', 'aptuveni viena kilometera ').
string('around_1_kilometer_2.ogg', 'aptuveni 1 kilometrs ').
string('around.ogg', 'aptuveni ').
string('kilometers_1.ogg', 'kilometriem ').
string('kilometers_2.ogg', 'kilometri ').

string('feet_1.ogg', 'pēdas ').
string('feet_2.ogg', 'pēdas ').
string('1_tenth_of_a_mile_1.ogg', 'desmitā jūdze ').
string('1_tenth_of_a_mile_2.ogg', 'desmitā jūdze ').
string('tenths_of_a_mile_1.ogg', 'desmitdaļas jūdze ').
string('tenths_of_a_mile_2.ogg', 'desmitdaļas jūdze ').
string('around_1_mile_1.ogg', 'apmēram vienu jūdzi ').
string('around_1_mile_2.ogg', 'apmēram vienu jūdzi ').
string('miles_1.ogg', 'jūdzes ').
string('miles_2.ogg', 'jūdzes ').

string('yards_1.ogg', 'yards ').
string('yards_2.ogg', 'yards ').

% TIME SUPPORT
string('time.ogg', ', laiks ').
string('1_hour.ogg', 'vienu stundu ').
string('hours.ogg', 'laiks ').
string('less_a_minute.ogg', 'mazāk nekā vienu minūti ').
string('1_minute.ogg', 'viena minūtes ').
string('minutes.ogg', 'minūtes ').


%% COMMAND BUILDING / WORD ORDER
turn('left', ['left.ogg']).
turn('left_sh', ['left_sh.ogg']).
turn('left_sl', ['left_sl.ogg']).
turn('right', ['right.ogg']).
turn('right_sh', ['right_sh.ogg']).
turn('right_sl', ['right_sl.ogg']).
turn('left_keep', ['left_keep.ogg']).
turn('right_keep', ['right_keep.ogg']).
bear_left(_Street) -- ['left_keep.ogg'].
bear_right(_Street) -- ['right_keep.ogg'].

onto_street('', []).
onto_street(Street, ['onto.ogg', Street]) :- tts.
onto_street(_Street, []) :- not(tts).
%on_street('', []).
%on_street(Street, ['on.ogg', Street]) :- tts.
%on_street(_Street, []) :- not(tts).
%to_street('', []).
%to_street(Street, ['to.ogg', Street]) :- tts.
%to_street(_Street, []) :- not(tts).

prepare_turn(Turn, Dist, Street) -- ['after.ogg', D, 'prepare.ogg', M | Sgen] :- distance(Dist, 1) -- D, turn(Turn, M), onto_street(Street, Sgen).
turn(Turn, Dist, Street) -- ['after.ogg', D, M | Sgen] :- distance(Dist, 1) -- D, turn(Turn, M), onto_street(Street, Sgen).
turn(Turn, Street) -- [M | Sgen] :- turn(Turn, M), onto_street(Street, Sgen).

prepare_make_ut(Dist, Street) -- ['prepare_make_uturn.ogg', D | Sgen] :- distance(Dist, 1) -- D, onto_street(Street, Sgen).
make_ut(Dist, Street) --  ['after.ogg', D, 'make_uturn.ogg' | Sgen] :- distance(Dist, 1) -- D, onto_street(Street, Sgen).
make_ut(Street) -- ['make_uturn.ogg' | Sgen] :- onto_street(Street, Sgen).
make_ut_wp -- ['make_uturn_wp.ogg'].

prepare_roundabout(Dist, _Exit, _Street) -- ['prepare_roundabout.ogg', D] :- distance(Dist, 1) -- D.
roundabout(Dist, _Angle, Exit, Street) -- ['after.ogg', D, 'roundabout.ogg', E, 'exit.ogg' | Sgen] :- distance(Dist, 1) -- D, nth(Exit, E), onto_street(Street, Sgen).
roundabout(_Angle, Exit, Street) -- ['exit2.ogg', E, 'exit3.ogg' | Sgen] :- nth(Exit, E), onto_street(Street, Sgen).

go_ahead -- ['go_ahead.ogg'].
go_ahead(Dist, Street) -- ['follow.ogg', D | Sgen]:- distance(Dist, 2) -- D, onto_street(Street, Sgen).

then -- ['then.ogg'].
name(D, [D]) :- tts.
name(_D, []) :- not(tts).
and_arrive_destination(D) -- ['and_arrive_destination.ogg', Ds, 'reached.ogg'] :- name(D, Ds).
reached_destination(D) -- ['reached_destination.ogg', Ds, 'reached.ogg'] :- name(D, Ds).
and_arrive_intermediate(D) -- ['and_arrive_intermediate.ogg', Ds, 'reached.ogg'] :- name(D, Ds).
reached_intermediate(D) -- ['reached_intermediate.ogg', Ds, 'reached.ogg'] :- name(D, Ds).
and_arrive_waypoint(D) -- ['and_arrive_waypoint.ogg', Ds, 'reached.ogg'] :- name(D, Ds).
reached_waypoint(D) -- ['reached_waypoint.ogg', Ds, 'reached.ogg'] :- name(D, Ds).

route_new_calc(Dist, Time) -- ['route_is.ogg', D, 'time.ogg', T] :- distance(Dist, 2) -- D, time(Time) -- T.
route_recalc(_Dist, _Time) -- ['route_calculate.ogg'] :- appMode('car').
route_recalc(Dist, Time) -- ['route_calculate.ogg', 'distance.ogg', D, 'time.ogg', T] :- distance(Dist, 2) -- D, time(Time) -- T.

location_lost -- ['location_lost.ogg'].
off_route(Dist) -- ['off_route.ogg', D] :- distance(Dist, 2) -- D.
attention(_Type) -- ['attention.ogg'].
speed_alarm -- ['exceed_limit.ogg'].


%% 
nth(1, '1st.ogg').
nth(2, '2nd.ogg').
nth(3, '3rd.ogg').
nth(4, '4th.ogg').
nth(5, '5th.ogg').
nth(6, '6th.ogg').
nth(7, '7th.ogg').
nth(8, '8th.ogg').
nth(9, '9th.ogg').
nth(10, '10th.ogg').
nth(11, '11th.ogg').
nth(12, '12th.ogg').
nth(13, '13th.ogg').
nth(14, '14th.ogg').
nth(15, '15th.ogg').
nth(16, '16th.ogg').
nth(17, '17th.ogg').


%% resolve command main method
%% if you are familar with Prolog you can input specific to the whole mechanism,
%% by adding exception cases.
flatten(X, Y) :- flatten(X, [], Y), !.
flatten([], Acc, Acc).
flatten([X|Y], Acc, Res):- flatten(Y, Acc, R), flatten(X, R, Res).
flatten(X, Acc, [X|Acc]) :- version(J), J < 100, !.
flatten(X, Acc, [Y|Acc]) :- string(X, Y), !.
flatten(X, Acc, [X|Acc]).

resolve(X, Y) :- resolve_impl(X,Z), flatten(Z, Y).
resolve_impl([],[]).
resolve_impl([X|Rest], List) :- resolve_impl(Rest, Tail), ((X -- L) -> append(L, Tail, List); List = Tail).


% handling alternatives
[X|_Y] -- T :- (X -- T),!.
[_X|Y] -- T :- (Y -- T).


pnumber(X, Y) :- tts, !, num_atom(X, Y).
pnumber(X, Ogg) :- num_atom(X, A), atom_concat(A, '.ogg', Ogg).
% time measure
hours(S, []) :- S < 60.
hours(S, ['1_hour.ogg']) :- S < 120, H is S div 60, pnumber(H, Ogg).
hours(S, [Ogg, 'hours.ogg']) :- H is S div 60, pnumber(H, Ogg).
time(Sec) -- ['less_a_minute.ogg'] :- Sec < 30.
time(Sec) -- [H, '1_minute.ogg'] :- tts, S is round(Sec/60.0), hours(S, H), St is S mod 60, St = 1, pnumber(St, Ogg).
time(Sec) -- [H, Ogg, 'minutes.ogg'] :- tts, S is round(Sec/60.0), hours(S, H), St is S mod 60, pnumber(St, Ogg).
time(Sec) -- [Ogg, 'minutes.ogg'] :- not(tts), Sec < 300, St is Sec/60, pnumber(St, Ogg).
time(Sec) -- [H, Ogg, 'minutes.ogg'] :- not(tts), S is round(Sec/300.0) * 5, hours(S, H), St is S mod 60, pnumber(St, Ogg).


%%% distance measure
distance(Dist, Y) -- D :- measure('km-m'), distance_km(Dist, Y) -- D.
distance(Dist, Y) -- D :- measure('mi-f'), distance_mi_f(Dist, Y) -- D.
distance(Dist, Y) -- D :- measure('mi-y'), distance_mi_y(Dist, Y) -- D.

%%% distance measure km/m
distance_km(Dist, 1) -- [ X, 'meters_1.ogg']                  :- Dist < 100,   D is round(Dist/10.0)*10,           dist(D, X).
distance_km(Dist, 2) -- [ X, 'meters_2.ogg']                  :- Dist < 100,   D is round(Dist/10.0)*10,           dist(D, X).
distance_km(Dist, 1) -- [ X, 'meters_1.ogg']                  :- Dist < 1000,  D is round(2*Dist/100.0)*50,        dist(D, X).
distance_km(Dist, 2) -- [ X, 'meters_2.ogg']                  :- Dist < 1000,  D is round(2*Dist/100.0)*50,        dist(D, X).
distance_km(Dist, 1) -- ['around_1_kilometer_1.ogg']          :- Dist < 1500.
distance_km(Dist, 2) -- ['around_1_kilometer_2.ogg']          :- Dist < 1500.
distance_km(Dist, 1) -- ['around.ogg', X, 'kilometers_1.ogg'] :- Dist < 10000, D is round(Dist/1000.0),            dist(D, X).
distance_km(Dist, 2) -- ['around.ogg', X, 'kilometers_2.ogg'] :- Dist < 10000, D is round(Dist/1000.0),            dist(D, X).
distance_km(Dist, 1) -- [ X, 'kilometers_1.ogg']              :-               D is round(Dist/1000.0),            dist(D, X).
distance_km(Dist, 2) -- [ X, 'kilometers_2.ogg']              :-               D is round(Dist/1000.0),            dist(D, X).

%%% distance measure mi/f
distance_mi_f(Dist, 1) -- [ X, 'feet_1.ogg']                  :- Dist < 160,   D is round(2*Dist/100.0/0.3048)*50, dist(D, X).
distance_mi_f(Dist, 2) -- [ X, 'feet_2.ogg']                  :- Dist < 160,   D is round(2*Dist/100.0/0.3048)*50, dist(D, X).
distance_mi_f(Dist, 1) -- ['1_tenth_of_a_mile_1.ogg']         :- Dist < 241.
distance_mi_f(Dist, 2) -- ['1_tenth_of_a_mile_2.ogg']         :- Dist < 241.
distance_mi_f(Dist, 1) -- [ X, 'tenths_of_a_mile_1.ogg']      :- Dist < 1529,  D is round(Dist/161.0),             dist(D, X).
distance_mi_f(Dist, 2) -- [ X, 'tenths_of_a_mile_2.ogg']      :- Dist < 1529,  D is round(Dist/161.0),             dist(D, X).
distance_mi_f(Dist, 1) -- ['around_1_mile_1.ogg']             :- Dist < 2414.
distance_mi_f(Dist, 2) -- ['around_1_mile_2.ogg']             :- Dist < 2414.
distance_mi_f(Dist, 1) -- ['around.ogg', X, 'miles_1.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_f(Dist, 2) -- ['around.ogg', X, 'miles_2.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_f(Dist, 1) -- [ X, 'miles_1.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).
distance_mi_f(Dist, 2) -- [ X, 'miles_2.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).

%%% distance measure mi/y
distance_mi_y(Dist, 1) -- [ X, 'yards_1.ogg']                 :- Dist < 241,   D is round(Dist/10.0/0.9144)*10,    dist(D, X).
distance_mi_y(Dist, 2) -- [ X, 'yards_2.ogg']                 :- Dist < 241,   D is round(Dist/10.0/0.9144)*10,    dist(D, X).
distance_mi_y(Dist, 1) -- [ X, 'yards_1.ogg']                 :- Dist < 1300,  D is round(2*Dist/100.0/0.9144)*50, dist(D, X).
distance_mi_y(Dist, 2) -- [ X, 'yards_2.ogg']                 :- Dist < 1300,  D is round(2*Dist/100.0/0.9144)*50, dist(D, X).
distance_mi_y(Dist, 1) -- ['around_1_mile_1.ogg']             :- Dist < 2414.
distance_mi_y(Dist, 2) -- ['around_1_mile_2.ogg']             :- Dist < 2414.
distance_mi_y(Dist, 1) -- ['around.ogg', X, 'miles_1.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_y(Dist, 2) -- ['around.ogg', X, 'miles_2.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_y(Dist, 1) -- [ X, 'miles_1.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).
distance_mi_y(Dist, 2) -- [ X, 'miles_2.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).


interval(St, St, End, _Step) :- St =< End.
interval(T, St, End, Step) :- interval(Init, St, End, Step), T is Init + Step, (T =< End -> true; !, fail).

interval(X, St, End) :- interval(X, St, End, 1).

string(Ogg, A) :- voice_generation, interval(X, 1, 19), atom_number(A, X), atom_concat(A, '.ogg', Ogg).
string(Ogg, A) :- voice_generation, interval(X, 20, 95, 5), atom_number(A, X), atom_concat(A, '.ogg', Ogg).
string(Ogg, A) :- voice_generation, interval(X, 100, 900, 50), atom_number(A, X), atom_concat(A, '.ogg', Ogg).
string(Ogg, A) :- voice_generation, interval(X, 1000, 9000, 1000), atom_number(A, X), atom_concat(A, '.ogg', Ogg).

dist(X, Y) :- tts, !, num_atom(X, Y).

dist(0, []) :- !.
dist(X, [Ogg]) :- X < 20, !, pnumber(X, Ogg).
dist(X, [Ogg]) :- X < 1000, 0 is X mod 50, !, num_atom(X, A), atom_concat(A, '.ogg', Ogg).
dist(D, ['20.ogg'|L]) :-  D < 30, Ts is D - 20, !, dist(Ts, L).
dist(D, ['30.ogg'|L]) :-  D < 40, Ts is D - 30, !, dist(Ts, L).
dist(D, ['40.ogg'|L]) :-  D < 50, Ts is D - 40, !, dist(Ts, L).
dist(D, ['50.ogg'|L]) :-  D < 60, Ts is D - 50, !, dist(Ts, L).
dist(D, ['60.ogg'|L]) :-  D < 70, Ts is D - 60, !, dist(Ts, L).
dist(D, ['70.ogg'|L]) :-  D < 80, Ts is D - 70, !, dist(Ts, L).
dist(D, ['80.ogg'|L]) :-  D < 90, Ts is D - 80, !, dist(Ts, L).
dist(D, ['90.ogg'|L]) :-  D < 100, Ts is D - 90, !, dist(Ts, L).
dist(D, ['100.ogg'|L]) :-  D < 200, Ts is D - 100, !, dist(Ts, L).
dist(D, ['200.ogg'|L]) :-  D < 300, Ts is D - 200, !, dist(Ts, L).
dist(D, ['300.ogg'|L]) :-  D < 400, Ts is D - 300, !, dist(Ts, L).
dist(D, ['400.ogg'|L]) :-  D < 500, Ts is D - 400, !, dist(Ts, L).
dist(D, ['500.ogg'|L]) :-  D < 600, Ts is D - 500, !, dist(Ts, L).
dist(D, ['600.ogg'|L]) :-  D < 700, Ts is D - 600, !, dist(Ts, L).
dist(D, ['700.ogg'|L]) :-  D < 800, Ts is D - 700, !, dist(Ts, L).
dist(D, ['800.ogg'|L]) :-  D < 900, Ts is D - 800, !, dist(Ts, L).
dist(D, ['900.ogg'|L]) :-  D < 1000, Ts is D - 900, !, dist(Ts, L).
dist(D, ['1000.ogg'|L]):- Ts is D - 1000, !, dist(Ts, L).
