%%% !!! THIS IS GENERATED FILE !!! Modify ttsconfig.p
﻿% for turbo-prolog
:- op('--', xfy, 500).
% for swi-prolog
:- op(500, xfy,'--').

version(0).
tts :- version(X), X > 99.
voice :- version(X), X < 99.

language('zh').
% fest_language(' ').

% IMPLEMENTED (X) or MISSING ( ) FEATURES:
% (X) new Version 1.5 format
% (X) route calculated prompts, left/right, u-turns, roundabouts, straight/follow
% (X) arrival
% (X) other prompts: attention (without Type implementation), location lost, off_route, exceed speed limit
% ( ) special grammar: onto_street / on_street / to_street
% (N/A) special grammar: nominative/dativ for distance measure
% (N/A) special grammar: imperative/infinitive distincion for turns
% (X) distance measure: meters / feet / yard support
% (X) Street name announcement (suppress in prepare_roundabout)
% (X) Name announcement for destination / intermediate / GPX waypoint arrival
% (X) Time announcement for new and recalculated route (for recalculated suppress in appMode=car)
% ( ) word order checked


% ROUTE CALCULATED
string('route_is1.ogg', '行程').
string('route_is2.ogg', ' 遠').
string('route_calculate.ogg', '路线重新计算').
string('distance.ogg', ', 距离').

% LEFT/RIGHT
string('prepare.ogg', '請準備 ').
string('after.ogg', ' 後 ').

string('left.ogg', '左轉 ').
string('left_sh.ogg', '向左急轉 ').
string('left_sl.ogg', '稍向左轉 ').
string('right.ogg', '右轉 ').
string('right_sh.ogg', '向右急轉 ').
string('right_sl.ogg', '稍向右轉 ').
string('left_keep.ogg', '靠左 ').
string('right_keep.ogg', '靠右 ').
% if needed, "left/right_bear.ogg" can be defined here also. "... (then) (bear_left/right)" is used in pre-announcements to indicate the direction of a successive turn AFTER the next turn.

% U-TURNS
string('prepare_make_uturn.ogg', ' 後迴轉 ').
string('make_uturn1.ogg', ' 後請迴轉').
string('make_uturn2.ogg', '請迴轉 ').
string('make_uturn_wp.ogg', '可能的話, 請迴轉 ').

% ROUNDABOUTS
string('prepare_roundabout.ogg', ' 後進入圓環 ').
string('roundabout.ogg', ' 後進入圓環, 然後在 ').
string('then.ogg', ', 然後 ').
string('and.ogg', '和 ').
string('take.ogg', '在 ').
string('exit.ogg', ' 出口離開').

string('1st.ogg', '第一個 ').
string('2nd.ogg', '第二個 ').
string('3rd.ogg', '第三個 ').
string('4th.ogg', '第四個 ').
string('5th.ogg', '第五個 ').
string('6th.ogg', '第六個 ').
string('7th.ogg', '第七個 ').
string('8th.ogg', '第八個 ').
string('9th.ogg', '第九個 ').
string('10th.ogg', '第十個 ').
string('11th.ogg', '第十一個 ').
string('12th.ogg', '第十二個 ').
string('13th.ogg', '第十三個 ').
string('14th.ogg', '第十四個 ').
string('15th.ogg', '第十五個 ').
string('16th.ogg', '第十六個 ').
string('17th.ogg', '第十七個 ').

% STRAIGHT/FOLLOW
string('go_ahead.ogg', '直直往前開 ').
string('follow.ogg', '沿著馬路往前 ').

% ARRIVE
string('and_arrive_destination.ogg', '然後可達終點 ').
string('reached_destination.ogg','抵達終點 ').
string('and_arrive_intermediate.ogg', '並通過點到達 ').
string('reached_intermediate.ogg', '你已經達到你通過點 ').
string('and_arrive_waypoint.ogg', '並通過點到達  GPX').
string('reached_waypoint.ogg', '你已經達到你通過點  GPX').

% OTHER PROMPTS
string('attention.ogg', '注意, ').
string('location_lost.ogg', '接收不到 g p s 信號 ').
string('location_recovered.ogg', 'g p s 信號恢復 ').
string('off_route.ogg', '你已經偏離路線 ').
string('exceed_limit.ogg', '你超速 ').

% STREET NAME GRAMMAR
string('onto.ogg', '到 ').
%string('on.ogg', 'on ').
%string('to.ogg', 'to ').

% DISTANCE UNIT SUPPORT
string('meters.ogg', ' 公尺').
string('around_1_kilometer.ogg', '約 1 公里 ').
string('around.ogg', '約 ').
string('kilometers.ogg', ' 公里 ').

string('feet.ogg', '尺 ').
string('1_tenth_of_a_mile.ogg', '一英里的十分之一').
string('tenths_of_a_mile.ogg', '零点一英里').
string('around_1_mile.ogg', '大约一英里（1.6公里）').
string('miles.ogg', '英里').

string('yards.ogg', 'yards ').

% TIME SUPPORT
string('time.ogg', '所需时间').
string('1_hour.ogg', '一小时').
string('hours.ogg', '小时').
string('less_a_minute.ogg', '不到一分钟').
string('1_minute.ogg', '1分钟').
string('minutes.ogg', '分钟').


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

prepare_turn(Turn, Dist, Street) -- ['prepare.ogg', D, 'after.ogg',  M | Sgen] :- distance(Dist) -- D, turn(Turn, M), onto_street(Street, Sgen).
turn(Turn, Dist, Street) -- [D, 'after.ogg', M | Sgen] :- distance(Dist) -- D, turn(Turn, M), onto_street(Street, Sgen).
turn(Turn, Street) -- [M | Sgen] :- turn(Turn, M), onto_street(Street, Sgen).

prepare_make_ut(Dist, Street) -- ['prepare.ogg', D, 'prepare_make_uturn.ogg' | Sgen] :- distance(Dist) -- D, onto_street(Street, Sgen).
make_ut(Dist, Street) --  [D, 'make_uturn1.ogg' | Sgen] :- distance(Dist) -- D, onto_street(Street, Sgen).
make_ut(Street) -- ['make_uturn2.ogg' | Sgen] :- onto_street(Street, Sgen).
make_ut_wp -- ['make_uturn_wp.ogg'].

prepare_roundabout(Dist, _Exit, _Street) -- ['prepare.ogg', D, 'prepare_roundabout.ogg'] :- distance(Dist) -- D.
roundabout(Dist, _Angle, Exit, Street) -- [D, 'roundabout.ogg', E, 'exit.ogg' | Sgen] :- distance(Dist) -- D, nth(Exit, E), onto_street(Street, Sgen).
roundabout(_Angle, Exit, Street) -- ['take.ogg', E, 'exit.ogg' | Sgen] :- nth(Exit, E), onto_street(Street, Sgen).

go_ahead(Dist, Street) -- ['follow.ogg', D | Sgen] :- distance(Dist) -- D, onto_street(Street, Sgen).

then -- ['then.ogg'].
name(D, [D]) :- tts.
name(_D, []) :- not(tts).
and_arrive_destination(D) -- ['and_arrive_destination.ogg'|Ds] :- name(D, Ds).
reached_destination(D) -- ['reached_destination.ogg'|Ds] :- name(D, Ds).
and_arrive_intermediate(D) -- ['and_arrive_intermediate.ogg'|Ds] :- name(D, Ds).
reached_intermediate(D) -- ['reached_intermediate.ogg'|Ds] :- name(D, Ds).
and_arrive_waypoint(D) -- ['and_arrive_waypoint.ogg'|Ds] :- name(D, Ds).
reached_waypoint(D) -- ['reached_waypoint.ogg'|Ds] :- name(D, Ds).

route_new_calc(Dist, Time) -- ['route_is1.ogg', D, 'route_is2.ogg', 'time.ogg', T] :- distance(Dist) -- D, time(Time) -- T.
route_recalc(_Dist, _Time) -- ['route_calculate.ogg'] :- appMode('car').
route_recalc(Dist, Time) -- ['route_calculate.ogg', 'distance.ogg', D, 'time.ogg', T] :- distance(Dist) -- D, time(Time) -- T.

location_lost -- ['location_lost.ogg'].
location_recovered -- ['location_recovered.ogg'].
off_route(Dist) -- ['off_route.ogg', D] :- distance(Dist) -- D.
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


%% command main method
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
resolve_impl([X|Rest], List) :- resolve_impl(Rest, Tail), ('--'(X, L) -> append(L, Tail, List); List = Tail).


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
distance(Dist) -- D :- measure('km-m'), distance_km(Dist) -- D.
distance(Dist) -- D :- measure('mi-f'), distance_mi_f(Dist) -- D.
distance(Dist) -- D :- measure('mi-y'), distance_mi_y(Dist) -- D.

%%% distance measure km/m
distance_km(Dist) -- [ X, 'meters.ogg']                  :- Dist < 100,   D is round(Dist/10.0)*10,           dist(D, X).
distance_km(Dist) -- [ X, 'meters.ogg']                  :- Dist < 1000,  D is round(2*Dist/100.0)*50,        dist(D, X).
distance_km(Dist) -- ['around_1_kilometer.ogg']          :- Dist < 1500.
distance_km(Dist) -- ['around.ogg', X, 'kilometers.ogg'] :- Dist < 10000, D is round(Dist/1000.0),            dist(D, X).
distance_km(Dist) -- [ X, 'kilometers.ogg']              :-               D is round(Dist/1000.0),            dist(D, X).

%%% distance measure mi/f
distance_mi_f(Dist) -- [ X, 'feet.ogg']                  :- Dist < 160,   D is round(2*Dist/100.0/0.3048)*50, dist(D, X).
distance_mi_f(Dist) -- ['1_tenth_of_a_mile.ogg']         :- Dist < 241.
distance_mi_f(Dist) -- [ X, 'tenths_of_a_mile.ogg']      :- Dist < 1529,  D is round(Dist/161.0),             dist(D, X).
distance_mi_f(Dist) -- ['around_1_mile.ogg']             :- Dist < 2414.
distance_mi_f(Dist) -- ['around.ogg', X, 'miles.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_f(Dist) -- [ X, 'miles.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).

%%% distance measure mi/y
distance_mi_y(Dist) -- [ X, 'yards.ogg']                 :- Dist < 241,   D is round(Dist/10.0/0.9144)*10,    dist(D, X).
distance_mi_y(Dist) -- [ X, 'yards.ogg']                 :- Dist < 1300,  D is round(2*Dist/100.0/0.9144)*50, dist(D, X).
distance_mi_y(Dist) -- ['around_1_mile.ogg']             :- Dist < 2414.
distance_mi_y(Dist) -- ['around.ogg', X, 'miles.ogg']    :- Dist < 16093, D is round(Dist/1609.0),            dist(D, X).
distance_mi_y(Dist) -- [ X, 'miles.ogg']                 :-               D is round(Dist/1609.0),            dist(D, X).


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
