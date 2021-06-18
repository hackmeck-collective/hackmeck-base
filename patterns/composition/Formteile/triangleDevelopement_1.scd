Pdef(\triangleDevelopement_1,
	Pspawner({|sp|
		var player1, player2, player3;
		[ 1, 2.125, 3.25, 4.375, 5.5, 6.625, 7.625, 8.875, 10.0].differentiate.do { |waitTime|
			sp.par(Pdef(\fraktal_12));
			sp.wait(waitTime)
		};
		([11.125, 12.25, 13.375, 14.5, 15.625, 16.75, 17.75, 19.0] - 10).differentiate.do { |waitTime|
			sp.par(Pdef(\fraktal_13));
			sp.wait(waitTime)
		};
		sp.wait(1);
		sp.par(Pdef(\fraktal_14));
		sp.wait(2);

		"fraktal_15".postln;
		sp.seq(Psync(Pdef(\fraktal_15), 5, 100));
		"fraktal_16".postln;
		sp.seq(Psync(Pdef(\fraktal_16), 0, 100));
		"fraktal_17".postln;
		~lsys[\presets].simpleSwitch_dev4.vols = [1, 1, 1, 1, 1, 1];
		sp.par(
			Pbind(\dur, Rest(0.1), \x, Pfunc { |in|
				~lsys[\presets].simpleSwitch_dev4.vols[0] = in;
				~lsys[\presets].simpleSwitch_dev4.vols[1] = in;
				0 } <> Pseg([1,0],[16],3)
			)
		);
		sp.seq(Ppar([
			Pdef(\fraktal_17),
			Psync(Pdef(\simpleSwitch_dev4),4,16)
		]));
	})
)