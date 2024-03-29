// tutorial: Sieves and Psieve patterns von miSCellanous ((c) 2009-2020 Daniel Mayer)

~hh = ( Pdef(\hh1) <> Pbind(\dur, 1/4) <> Pbindef(\root)  ).play(~linkClock, quant: 4);


Pbindef(\sieveSD, \dur, PSVunion_i([3, 5, 7]) / 8)  // 3 gegen 5 gegen 7
~sd = ( Pdef(\blip) <> Pbindef(\sieveSD) <> Pbindef(\pat_332_downUp) ).play(~linkClock, quant: 4);
~sd.stop
Pbindef(\sieveSD, \dur, PSVunion_i([Pseq([3,1],inf), Pseq([4,2],inf)]) / 8)  // 3 gegen 4
Pbindef(\sieveSD, \dur, PSVunion_i([3, 5, 7]) / 7)  // 3 gegen 5 gegen 7

Pbindef(\sieveSD, \dur, PSVunion_i([3, Pseq([4,3],inf)]) / 8) // 3 gegen 7 (7 aufgeteilt in [4, 3])
Pbindef(\sieveSD, \dur, PSVunion_i([Pseq([4,6],inf), Pseq([5,6],inf)]) / 8) // 10 gegen 11 (aufgeteilt)
~sd.stop


// bd dazu
(
~hh = ( Pdef(\hh1) <> Pbind(\dur, 1/4) <> Pbindef(\root)  ).play(~linkClock, quant: 4);
~sd = ( Pdef(\sd2) <> Pbindef(\sieveSD, \dur,PSVunion_i([Pseq([3, 2],inf)]) / 4) <> Pbindef(\fifth) ).play(~linkClock, quant: 4);
~bd = ( Pdef(\bdThump) <> Pbindef(\sieveBD, \dur, PSVunion_i([Pseq([6, 2],inf), 9]) / 2)  <> Pbindef(\root)  ).play(~linkClock, quant: 4);
)

// ein paar random variationen und wobbly HH
(
~hh.stop;
~hh = ( Pdef(\bongo_muted) <> Pbindef(\sieveHH, \dur,PSVunion_i([Prand([Pseq([3,4,2]),9],inf), Prand([Pseq([4,2],inf), 6],inf)]) / 12) <> Pbindef(\root)  ).play(~linkClock, quant: 4);
~sd = ( Pdef(\sd3) <> Pbindef(\sieveSD, \dur,PSVunion_i([Prand([Pseq([5,4,3]),12],inf), Prand([Pseq([2, 4]), 6],inf)]) / 4) <> Pbindef(\fifth) ).play(~linkClock, quant: 4);
~bd = ( Pdef(\bdThump) <> Pbindef(\sieveBD, \dur, PSVunion_i([Pseq([6, 2],inf), 9]) / 4)  <> Pbindef(\root)  ).play(~linkClock, quant: 4);
)