(
// OPTIONS
var opts = (
	instr: \digiDist_lead,
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

Pdef(\penrose_canon_pausen_1_filter,
	Pbind(
		\vol, Pfunc {|ev|
			if(ev.charNow == $F){ev.vol * 1.2}{ev.vol * 1}
		},
	)
);


// ARGS
~newLsys.(
	name: \penrose_canon_pausen_1, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[-X+GX]G[f]G5-f5+", $f: "-F+[-X+GX]G[f]G5-f5+", $G: "GX"), // "-F+[-X+GX]G[F]5-F5+-F+" "-F+[-X+3-X3+X]G[F]5-F5+-F+"
	gen: 3, // 1
	opts: opts
)
)