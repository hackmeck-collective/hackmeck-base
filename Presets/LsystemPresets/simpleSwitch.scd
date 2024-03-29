(
// OPTIONS
var opts = (
	noteOffset: 0,
	instr: \metalPerc,
	useGlobalPitch: false,
	baseTempo: 1/8,
	quant: 0,
	theta: 36,
	baseColor: 30,
	lineScale: 10
);

// FILTERS

Pdef(\simpleSwitch_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
		\envelope_mod, Pfunc {|ev|
			if(ev.charNow == $F){0.5}{0.25}
		},
		\pitchOp_1_interval, Pfunc {|ev|
			if(ev.charNow == $F){12}{7}
		},
		\pitchOp_1_amount, Pfunc {|ev|
			if(ev.charNow == $F){0.1}{0.05}
		},
	)
);

// ARGS
~newLsys.(
	name: 'simpleSwitch',
	axiom: "F",
	rules:  ($F: "F-G-f2+f", $f: "F-G-f2+f"),
	gen: 2,
	opts: opts
)
)