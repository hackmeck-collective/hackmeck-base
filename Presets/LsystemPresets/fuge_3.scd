(
// OPTIONS
var opts = (
	instr: \simpleSine,
	legatoArr: 1,
	useGlobalPitch: false,
	noteOffset: 0,
	branchInterval: 0,
	quant: 0,
	vols: 0.8,
	baseTempo: 1/12,
	quant: 0,
	theta: 60// 72
);

// FILTERS

// ARGS
~newLsys.(
	name: \fuge_3,
	axiom: "7+[[r+s3+q3-rs4+q]9+q3-rs4+q3+r+s]3-s4+q4-r+s3+q3-r",//"7+[9+q3-rs4+q3+r+s3+q3-rs4+q3+r+s][r+s3+q3-rs4+q3+r+s3+q3-rs4+q]3-s4+q4-r+s3+q3-r7+s4+q4-r+s3+q3-r",
	rules: ($q: "a+a-a+a2a+a2-a+a-a2-4a", $r: "2Ga5+4a-a+a-a-a-a-a-a", $s: "a+a-a+2a+2a+3a2-a-a-a-a", $a: "bG+b-", $b: "a-a+"),
	gen: 1, // 1
	opts: opts
)
)


