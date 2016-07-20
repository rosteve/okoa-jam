% for turbo-prolog
:- op('--', xfy, 500).
% for swi-prolog
:- op(500, xfy,'--').

version(103).
tts :- version(X), X > 99.
voice :- version(X), X < 99.

language('da').
% fest_language('').

% IMPLEMENTED (X) or MISSING ( ) FEATURES, (N/A) if not needed in this language:
%
% (X) Basic navigation prompts: route (re)calculated (with distance and time support), turns, roundabouts, u-turns, straight/follow, arrival
% (X) Announce nearby point names (destination / intermediate / GPX waypoint / favorites / POI)
% (X) Attention prompts: SPEED_CAMERA; SPEED_LIMIT; BORDER_CONTROL; RAILWAY; TRAFFIC_CALMING; TOLL_BOOTH; STOP; PEDESTRIAN; MAXIMUM
% (X) Other prompts: gps lost, off route, back to route
% (X) Street name and prepositions (onto / on / to) and street destination (toward) support
% (X) Distance unit support (meters / feet / yard)
% (N/A) Special grammar: (please specify which)


%% STRINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ROUTE CALCULATED
string('route_is.ogg', 'Ruten er ').
string('route_calculate.ogg', 'Ruten genberegnes ').
string('distance.ogg', 'afstanden er ').

% LEFT/RIGHT
string('prepare.ogg', 'Forbered at ').
string('after.ogg', 'om ').

string('left.ogg', 'drej til venstre ').
string('left_sh.ogg', 'drej skarpt til venstre ').
string('left_sl.ogg', 'drej svagt til venstre ').
string('right.ogg', 'drej til højre ').
string('right_sh.ogg', 'drej skarpt til højre ').
string('right_sl.ogg', 'drej svagt til højre ').
string('left_keep.ogg', 'hold til venstre ').
string('right_keep.ogg', 'hold til højre ').
string('left_bear.ogg', 'til venstre ').   % in English the same as left_keep, may be different in other languages
string('right_bear.ogg', 'til højre ').    % in English the same as right_keep, may be different in other languages

% U-TURNS
string('make_uturn.ogg', 'Foretag en U vending ').
string('make_uturn_wp.ogg', 'Foretag en U vending når det bliver muligt').

% ROUNDABOUTS
string('prepare_roundabout.ogg', 'Forbered at køre ind i rundkørslen ').
string('roundabout.ogg', 'kør ind i rundkørslen, ').
string('then.ogg', 'og derefter ').
string('and.ogg', 'og ').
string('take.ogg', 'tag den ').
string('exit.ogg', 'afkørsel ').

string('1st.ogg', 'første ').
string('2nd.ogg', 'anden ').
string('3rd.ogg', 'tredje ').
string('4th.ogg', 'fjerde ').
string('5th.ogg', 'femte ').
string('6th.ogg', 'sjette ').
string('7th.ogg', 'syvende ').
string('8th.ogg', 'ottende' ).
string('9th.ogg', 'niende ').
string('10th.ogg', 'tiende ').
string('11th.ogg', 'ellevte ').
string('12th.ogg', 'tolvte ').
string('13th.ogg', 'trettende ').
string('14th.ogg', 'fjortende ').
string('15th.ogg', 'femtende ').
string('16th.ogg', 'sekstende ').
string('17th.ogg', 'syttende ').

% STRAIGHT/FOLLOW
string('go_ahead.ogg', 'Fortsæt ligeud ').
string('follow.ogg', 'Følg vejen ').

% ARRIVE
string('and_arrive_destination.ogg', 'og så ankommer du til destinationen ').
string('reached_destination.ogg','du har nået destinationen ').
string('and_arrive_intermediate.ogg', 'og så ankommer du til rutepunktet ').
string('reached_intermediate.ogg', 'du har nået rutepunktet ').

% NEARBY POINTS
string('and_arrive_waypoint.ogg', 'og så ankommer du til GPX rutepunktet ').
string('reached_waypoint.ogg', 'du har nået dit GPX rutepunkt ').
string('and_arrive_favorite.ogg', 'og så ankommer du til favoritpunktet ').
string('reached_favorite.ogg', 'du har nået dit favorit rutepunkt ').
string('and_arrive_poi.ogg', 'og så ankommer du til interessepunktet ').
string('reached_poi.ogg', 'du har nået interessepunktet ').

% ATTENTION
%string('exceed_limit.ogg', 'Hastighedsgrænsen er overskredet ').
string('exceed_limit.ogg', 'Hastighedsgrænse ').
string('attention.ogg', 'Advarsel, ').
string('speed_camera.ogg', 'fartkamera ').
string('border_control.ogg', 'grænsekontrol ').
string('railroad_crossing.ogg', 'jernbaneoverskæring ').
string('traffic_calming.ogg', 'trafikdæmpning ').
string('toll_booth.ogg', 'betalingsanlæg ').
string('stop.ogg', 'stopskilt ').
string('pedestrian_crosswalk.ogg', 'fodgængerovergang ').

% OTHER PROMPTS
string('location_lost.ogg', 'g p s signal mistet ').
string('location_recovered.ogg', 'g p s signal fundet ').
string('off_route.ogg', 'du er kørt væk fra ruten ').
string('back_on_route.ogg', 'du er vendt tilbage til ruten').

% STREET NAME PREPOSITIONS
string('onto.ogg', 'ind på ').
string('on.ogg', 'på ').
string('to.ogg', 'til ').
string('toward.ogg', 'imod ').

% DISTANCE UNIT SUPPORT
string('meters.ogg', 'meter ').
string('around_1_kilometer.ogg', 'omkring 1 kilometer ').
string('around.ogg', 'omkring ').
string('kilometers.ogg', 'kilometer ').

string('feet.ogg', 'fod ').
string('1_tenth_of_a_mile.ogg', 'en tiendedel af en mil ').
string('tenths_of_a_mile.ogg', 'tiendedele af en mil ').
string('around_1_mile.ogg', 'omkring 1 mil ').
string('miles.ogg', 'mil ').

string('yards.ogg', 'yards ').

% TIME SUPPORT
string('time.ogg', 'tiden er ').
string('1_hour.ogg', 'en time ').
string('hours.ogg', 'timer ').
string('less_a_minute.ogg', 'mindre end et minut ').
string('1_minute.ogg', 'et minut ').
string('minutes.ogg', 'minutter').


%% COMMAND BUILDING / WORD ORDER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
route_new_calc(Dist, Time) -- ['route_is.ogg', D, 'time.ogg', T] :- distance(Dist) -- D, time(Time) -- T.
route_recalc(_Dist, _Time) -- ['route_calculate.ogg'] :- appMode('car').
route_recalc(Dist, Time) -- ['route_calculate.ogg', 'distance.ogg', D, 'time.ogg', T] :- distance(Dist) -- D, time(Time) -- T.

turn('left', ['left.ogg']).
turn('left_sh', ['left_sh.ogg']).
turn('left_sl', ['left_sl.ogg']).
turn('right', ['right.ogg']).
turn('right_sh', ['right_sh.ogg']).
turn('right_sl', ['right_sl.ogg']).
turn('left_keep', ['left_keep.ogg']).
turn('right_keep', ['right_keep.ogg']).
% Note: turn('left_keep'/'right_keep',[]) is a turn type aiding lane selection, while bear_left()/bear_right() is triggered as brief "turn-after-next" preparation sounding always after a "..., then...". In some languages turn(l/r_keep) may not differ from bear_l/r:
bear_left(_Street) -- ['left_bear.ogg'].
bear_right(_Street) -- ['right_bear.ogg'].

% assemble_street_name(voice([Ref, Name, Dest], [_CurrentRef, _CurrentName, _CurrentDest]), _).
% assemble_street_name(voice(['', Name, _], _), Name). % not necessary
% Next 2 lines for Name taking precedence over Dest...
%assemble_street_name(voice([Ref, '', Dest], _), [C1, 'toward.ogg', Dest]) :- atom_concat(Ref, ' ', C1).
%assemble_street_name(voice([Ref, Name, _], _), Concat) :- atom_concat(Ref, ' ', C1), atom_concat(C1, Name, Concat).
% ...or next 3 lines for Dest taking precedence over Name
assemble_street_name(voice([Ref, Name, ''], _), Concat) :- atom_concat(Ref, ' ', C1), atom_concat(C1, Name, Concat).
assemble_street_name(voice(['', Name, Dest], _), [C1, 'toward.ogg', Dest]) :- atom_concat(Name, ' ', C1).
assemble_street_name(voice([Ref, _, Dest], _), [C1, 'toward.ogg', Dest]) :- atom_concat(Ref, ' ', C1).

turn_street('', []).
turn_street(voice(['','',''],_), []).
turn_street(voice(['', '', D], _), ['toward.ogg', D]) :- tts.
turn_street(Street, ['on.ogg', SName]) :- tts, Street = voice([R, S, _],[R, S, _]), assemble_street_name(Street, SName).
turn_street(Street, ['on.ogg', SName]) :- tts, Street = voice([R, '', _],[R, _, _]), assemble_street_name(Street, SName).
turn_street(Street, ['onto.ogg', SName]) :- tts, not(Street = voice([R, S, _],[R, S, _])), assemble_street_name(Street, SName).
turn_street(_Street, []) :- not(tts).

follow_street('', []).
follow_street(voice(['','',''],_), []).
follow_street(voice(['', '', D], _), ['to.ogg', D]) :- tts.
follow_street(Street, ['on.ogg', SName]) :- tts, Street = voice([R, S, _],[R, S, _]), assemble_street_name(Street, SName).
follow_street(Street, ['on.ogg', SName]) :- tts, Street = voice([R, '', _],[R, _, _]), assemble_street_name(Street, SName).
follow_street(Street, ['to.ogg', SName]) :- tts, not(Street = voice([R, S, _],[R, S, _])), assemble_street_name(Street, SName).
follow_street(_Street, []) :- not(tts).

prepare_turn(Turn, Dist, Street) -- ['prepare.ogg', M, 'after.ogg', D | Sgen] :- distance(Dist) -- D, turn(Turn, M), turn_street(Street, Sgen).
turn(Turn, Dist, Street) -- ['after.ogg', D, M | Sgen] :- distance(Dist) -- D, turn(Turn, M), turn_street(Street, Sgen).
turn(Turn, Street) -- [M | Sgen] :- turn(Turn, M), turn_street(Street, Sgen).

prepare_make_ut(Dist, Street) -- ['prepare.ogg', 'make_uturn.ogg', 'after.ogg', D | Sgen] :- distance(Dist) -- D, turn_street(Street, Sgen).
make_ut(Dist, Street) -- ['after.ogg', D, 'make_uturn.ogg' | Sgen] :- distance(Dist) -- D, turn_street(Street, Sgen).
make_ut(Street) -- ['make_uturn.ogg' | Sgen] :- turn_street(Street, Sgen).
make_ut_wp -- ['make_uturn_wp.ogg'].

prepare_roundabout(Dist, _Exit, _Street) -- ['prepare_roundabout.ogg', 'after.ogg', D] :- distance(Dist) -- D.
roundabout(Dist, _Angle, Exit, Street) -- ['after.ogg', D, 'roundabout.ogg', 'and.ogg', 'take.ogg', E, 'exit.ogg' | Sgen] :- distance(Dist) -- D, nth(Exit, E), turn_street(Street, Sgen).
roundabout(_Angle, Exit, Street) -- ['take.ogg', E, 'exit.ogg' | Sgen] :- nth(Exit, E), turn_street(Street, Sgen).

go_ahead -- ['go_ahead.ogg'].
go_ahead(Dist, Street) -- ['follow.ogg', D | Sgen] :- distance(Dist) -- D, follow_street(Street, Sgen).

then -- ['then.ogg'].
name(D, [D]) :- tts.
name(_D, []) :- not(tts).

and_arrive_destination(D) -- ['and_arrive_destination.ogg'|Ds] :- name(D, Ds).
reached_destination(D) -- ['reached_destination.ogg'|Ds] :- name(D, Ds).
and_arrive_intermediate(D) -- ['and_arrive_intermediate.ogg'|Ds] :- name(D, Ds).
reached_intermediate(D) -- ['reached_intermediate.ogg'|Ds] :- name(D, Ds).
and_arrive_waypoint(D) -- ['and_arrive_waypoint.ogg'|Ds] :- name(D, Ds).

reached_waypoint(D) -- ['reached_waypoint.ogg'|Ds] :- name(D, Ds).
and_arrive_favorite(D) -- ['and_arrive_favorite.ogg'|Ds] :- name(D, Ds).
reached_favorite(D) -- ['reached_favorite.ogg'|Ds] :- name(D, Ds).
and_arrive_poi(D) -- ['and_arrive_poi.ogg'|Ds] :- name(D, Ds).
reached_poi(D) -- ['reached_poi.ogg'|Ds] :- name(D, Ds).

location_lost -- ['location_lost.ogg'].
location_recovered -- ['location_recovered.ogg'].
off_route(Dist) -- ['off_route.ogg', D] :- distance(Dist) -- D.
back_on_route -- ['back_on_route.ogg'].

% TRAFFIC WARNINGS
speed_alarm(MaxSpeed, _Speed) -- ['exceed_limit.ogg', I] :- num_atom(MaxSpeed, I).
attention(Type) -- ['attention.ogg', W] :- warning(Type, W).
warning('SPEED_CAMERA', 'speed_camera.ogg').
warning('SPEED_LIMIT', '').
warning('BORDER_CONTROL', 'border_control.ogg').
warning('RAILWAY', 'railroad_crossing.ogg').
warning('TRAFFIC_CALMING', 'traffic_calming.ogg').
warning('TOLL_BOOTH', 'toll_booth.ogg').
warning('STOP', 'stop.ogg').
warning('PEDESTRIAN', 'pedestrian_crosswalk.ogg').
warning('MAXIMUM', '').
warning(Type, '') :- not(Type = 'SPEED_CAMERA'; Type = 'SPEED_LIMIT'; Type = 'BORDER_CONTROL'; Type = 'RAILWAY'; Type = 'TRAFFIC_CALMING'; Type = 'TOLL_BOOTH'; Type = 'STOP'; Type = 'PEDESTRIAN'; Type = 'MAXIMUM').


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
time(Sec) -- [H] :- tts, S is round(Sec/60.0), hours(S, H), St is S mod 60, St = 0.
time(Sec) -- [H, '1_minute.ogg'] :- tts, S is round(Sec/60.0), hours(S, H), St is S mod 60, St = 1, pnumber(St, Ogg).
time(Sec) -- [H, Ogg, 'minutes.ogg'] :- tts, S is round(Sec/60.0), hours(S, H), St is S mod 60, pnumber(St, Ogg).
time(Sec) -- [Ogg, 'minutes.ogg'] :- not(tts), Sec < 300, St is Sec/60, pnumber(St, Ogg).
time(Sec) -- [H, Ogg, 'minutes.ogg'] :- not(tts), S is round(Sec/300.0) * 5, St is S mod 60, St > 0, hours(S, H), pnumber(St, Ogg).
time(Sec) -- [H] :- not(tts), S is round(Sec/300.0) * 5, hours(S, H), St is S mod 60.


%%% distance measure
distance(Dist) -- D :- measure('km-m'), distance_km(Dist) -- D.
distance(Dist) -- D :- measure('mi-f'), distance_mi_f(Dist) -- D.
distance(Dist) -- D :- measure('mi-y'), distance_mi_y(Dist) -- D.

%%% distance measure km/m
distance_km(Dist) -- [ X, 'meters.ogg'] :- Dist < 100, D is round(Dist/10.0)*10, dist(D, X).
distance_km(Dist) -- [ X, 'meters.ogg'] :- Dist < 1000, D is round(2*Dist/100.0)*50, dist(D, X).
distance_km(Dist) -- ['around_1_kilometer.ogg'] :- Dist < 1500.
distance_km(Dist) -- ['around.ogg', X, 'kilometers.ogg'] :- Dist < 10000, D is round(Dist/1000.0), dist(D, X).
distance_km(Dist) -- [ X, 'kilometers.ogg'] :- D is round(Dist/1000.0), dist(D, X).

%%% distance measure mi/f
distance_mi_f(Dist) -- [ X, 'feet.ogg'] :- Dist < 160, D is round(2*Dist/100.0/0.3048)*50, dist(D, X).
distance_mi_f(Dist) -- ['1_tenth_of_a_mile.ogg'] :- Dist < 241.
distance_mi_f(Dist) -- [ X, 'tenths_of_a_mile.ogg'] :- Dist < 1529, D is round(Dist/161.0), dist(D, X).
distance_mi_f(Dist) -- ['around_1_mile.ogg'] :- Dist < 2414.
distance_mi_f(Dist) -- ['around.ogg', X, 'miles.ogg'] :- Dist < 16093, D is round(Dist/1609.0), dist(D, X).
distance_mi_f(Dist) -- [ X, 'miles.ogg'] :- D is round(Dist/1609.0), dist(D, X).

%%% distance measure mi/y
distance_mi_y(Dist) -- [ X, 'yards.ogg'] :- Dist < 241, D is round(Dist/10.0/0.9144)*10, dist(D, X).
distance_mi_y(Dist) -- [ X, 'yards.ogg'] :- Dist < 1300, D is round(2*Dist/100.0/0.9144)*50, dist(D, X).
distance_mi_y(Dist) -- ['around_1_mile.ogg'] :- Dist < 2414.
distance_mi_y(Dist) -- ['around.ogg', X, 'miles.ogg'] :- Dist < 16093, D is round(Dist/1609.0), dist(D, X).
distance_mi_y(Dist) -- [ X, 'miles.ogg'] :- D is round(Dist/1609.0), dist(D, X).


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
dist(20, ['20.ogg']) :-!.
dist(D, [L,'and.ogg'|'20.ogg']) :- D < 30, Ts is D - 20, !, dist(Ts, L).
dist(30, ['30.ogg']) :-!.
dist(D, [L,'and.ogg'|'30.ogg']) :- D < 40, Ts is D - 30, !, dist(Ts, L).
dist(40, ['40.ogg']) :-!.
dist(D, [L,'and.ogg'|'40.ogg']) :- D < 50, Ts is D - 40, !, dist(Ts, L).
dist(50, ['50.ogg']) :-!.
dist(D, [L,'and.ogg'|'50.ogg']) :- D < 60, Ts is D - 50, !, dist(Ts, L).
dist(60, ['60.ogg']) :-!.
dist(D, [L,'and.ogg'|'60.ogg']) :- D < 70, Ts is D - 60, !, dist(Ts, L).
dist(70, ['70.ogg']) :-!.
dist(D, [L,'and.ogg'|'70.ogg']) :- D < 80, Ts is D - 70, !, dist(Ts, L).
dist(80, ['80.ogg']) :-!.
dist(D, [L,'and.ogg'|'80.ogg']) :- D < 90, Ts is D - 80, !, dist(Ts, L).
dist(90, ['90.ogg']) :-!.
dist(D, [L,'and.ogg'|'90.ogg']) :- D < 100, Ts is D - 90, !, dist(Ts, L).
dist(D, ['100.ogg'|L]) :- D < 200, Ts is D - 100, !, dist(Ts, L).
dist(D, ['200.ogg'|L]) :- D < 300, Ts is D - 200, !, dist(Ts, L).
dist(D, ['300.ogg'|L]) :- D < 400, Ts is D - 300, !, dist(Ts, L).
dist(D, ['400.ogg'|L]) :- D < 500, Ts is D - 400, !, dist(Ts, L).
dist(D, ['500.ogg'|L]) :- D < 600, Ts is D - 500, !, dist(Ts, L).
dist(D, ['600.ogg'|L]) :- D < 700, Ts is D - 600, !, dist(Ts, L).
dist(D, ['700.ogg'|L]) :- D < 800, Ts is D - 700, !, dist(Ts, L).
dist(D, ['800.ogg'|L]) :- D < 900, Ts is D - 800, !, dist(Ts, L).
dist(D, ['900.ogg'|L]) :- D < 1000, Ts is D - 900, !, dist(Ts, L).
dist(D, ['1000.ogg'|L]):- Ts is D - 1000, !, dist(Ts, L).
