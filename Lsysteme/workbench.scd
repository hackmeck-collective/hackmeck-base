// wenn opts noch keine liste hat sollte ein neues lsys das immer aktualisieren
// modus zwischen ersetzen und anhaengen bauen wenn neues lsys kommt
l.tempo = 3
~newLsys.(
	axiom: "-F",//"F-F-F-F-F",
	rules: ( $F: "F[FGF]-FG+F[--FF]+F-F" ),
	gen: 2.0,
	useLastV: true
)
// baueme umdrehen
~newLsys.(
	axiom: "F",
	rules: ($F: "F-F++F-F"),
	gen: 3.0,
	useLastV: false
)

~newLsysMode = \add; // \add \replace nil
Pbindef(\opts,\part, Pseq(~lsys.list, inf));

// $P fuer lsys repetition
~newLsys.(
	axiom: "++F",
	rules: ( $F: "F+F[FGGF--F]" ),
	gen: 3.0,
	useLastV: true
)

~ctl.wrapLo = 48!10;
~ctl.wrapHi = 72!10;

~lsys.list.clear
Pbindef(\opts).clear
Pbindef(\opts,
	\part, Pseq(~lsys.list,inf),//Pn(Pseq(~lsys.list), inf, \partRepeat),
	\baseTempo, 1/4,
	\durCalc, \waitAll
);

Pbindef(\opts, \part, Pseq(~lsys.list[7..], inf))
Pbindef(\opts, \part, Pseq(~lsys.list, inf))

Pbindef(\opts, \baseTempo, Pseq([1/12, 1/9, 1/6], inf))
Pbindef(\opts, \baseTempo, 1/2);

Pbindef(\opts, \durCalc, \noWait); // spielt nur den Stamm zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, \waitAll); // spielt alles zu ende bevor ein neues anfaengt
Pbindef(\opts, \durCalc, Pseq([\waitAll, \noWait], inf));

Pbindef(\opts, \baseTempo, 1/2);

l.tempo = 0.5
Pbind(\server, ~benniServer).play(quant:1, clock: l)

Pdef(\partPlayer).stop
Pbindef(\ctl, \legato, 70);
(
Pdef(\partPlayer).play(l, quant:1)
)

~lsys.list.last.startTimes.size

~ctl.noteOffset = -7
~ctl.branchInterval = 7;

~ctl.noteOffset = 7
~ctl.branchInterval = -7;

~ctl.legatoArr = [1.1, 0.8, 1.4, 0.1] ++ (0.1!10)
~ctl.legatoArr = 1.1!10
~ctl.vols = 1!10
~ctl.vols = [1, 1, 1] ++ (1!10)
~ctl.theta = 60
Tdef(\drawLines).play(l);
Tdef(\drawLines).stop;
Pbindef(\ctl, \theta, 70);


Pbindef(\ctl, \server, ~benniServer, \setType, \note);

Pbindef(\ctl, \branchInterval, Pfunc { |ev| -2 * ev.scale.size })
Pbindef(\ctl, \stepInterval, -1)


Pbindef(\ctl, \scale, Scale.major)
Pbindef(\ctl, \wrapHi, 108)
Pbindef(\ctl, \noteOffset, 7)

~objSpace[\lsys] = (
	axiom: "F-G",
	rules: ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ),
	gen:2
)

~objSpace[\lsys] = (
	axiom: "F-G",
	rules: ( $F: "FG[FF-GGGFF++++F]F", $G: "GGF" ),
	gen: 1,
	useLastV: true
)

// wenn man useLast benutzt sollte das axiom nur F sein?!?!?!?!
~objSpace[\lsys] = (
	axiom: "F",
	rules: ( $F: "F-FFF[-F+F]+F"),
	gen:2,
	useLastV: false
)

~objSpace[\lsys] = (
	axiom: "---F",
	rules: ( $F: "FFF-F[-F+F]+F"),
	gen:2,
	useLastV: true
)

~objSpace_philipp = OSCObjectSpace(~addrBook, oscPath:'/data');
~objSpace_philipp[\data]
~objSpace_philipp.addDependant({|objectSpace, what, key, val|
	Pbindef(\ctl,
		\scale, Scale.new(~objSpace_philipp[\data]),
		\branchInterval, Pfunc { |ev| ev.scale.size }
	);

});
Pbindef(\ctl, \group, ~objSpace_benni[\sourceGroup])

Pbindef(\ctl, \setInstrument, [\simple_modes_synth_1, \sine_OD_1, \simple_modes_synth_1] ++ (\fm_1 ! 7))

~objSpace_benni = OSCObjectSpace(~addrBook, oscPath:'/params');
~objSpace_benni[\sourceGroup]

~gui.toProcessing.sendMsg('/reset')

~gui.toProcessing.sendMsg('/lerpFactor', 0.1)
~gui.toProcessing.sendMsg('/linesMax', 350)
~presetSpace = OSCObjectSpace(~addrBook, oscPath:'/presets').acceptEvents_(true);