(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 0.3,
	useGlobalPitch: false,
	noteOffset: 12,
	quant: 0,
	vols: 0.5,
	baseTempo: 1/3,
	quant: 0,
	theta: 12, // 72
	wrapLo: 36,
	wrapHi: 120,
	branchInterval: 3,
);

// FILTERS

// ARGS
~newLsys.(
	name: \penrose_canon_mehr_pausen_ht, //besserer name waere arppeggios
	axiom: "F",
	rules: ($F: "-F+[X]G[-X+GX]G5-F5+", $G: "GX"), //5-F++F2-F
	gen: 3, // 1
	opts: opts
)
)