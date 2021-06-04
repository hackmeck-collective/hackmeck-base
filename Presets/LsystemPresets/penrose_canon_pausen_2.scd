(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
	quant: 0,
	vols: 0.5,
	baseTempo: 1/6,
	quant: 0,
	theta: 12, // 72
	wrapLo: 36,
	wrapHi: 120,
	branchInterval: 3,
);

// FILTERS

Pdef(\penrose_canon_pausen_2_filter,
	Pbind(\vol, Pfunc {|ev|
		if((ev.charNow == $F) || (ev.charNow == $X)){ev.vol * 1}{0}
	},
	)
);

// ARGS
~newLsys.(
	name: \penrose_canon_pausen_2, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[-X+GX]G[F]m5-F5+", $m: "-F+[-X+GX]G[F]m5-F5+", $G: "GX"), // "-F+[-X+GX]G[F]5-F5+-F+" "-F+[-X+3-X3+X]G[F]5-F5+-F+"
	gen: 3, // 1
	opts: opts
)
)