(
~drumTypes = (
	bodyTimbreTransientTail: {arg freq = 440,
		gate = 1,
		timbre_ratio = 0.2,
		body_sweep_ratio = 0.5,
		timbre_sweep_ratio = 0.5,
		body_time = 0.5,
		timbre_time = 0.5,
		transient_time = 0.1,
		tail_time = 0.7,
		body_vol = 1,
		timbre_vol = 1,
		transient_vol = 1,
		tail_vol = 1,
		time_factor = 1;

		var body_envelope, timbre_envelope, transient_envelope, tail_envelope,
		timbre_freq, body_sweep, timbre_sweep,
		body, timbre, transient, tail, volume_compensation,
		mix;

		timbre_ratio = timbre_ratio.lincurve(0,1,0,48,0).midiratio;
		body_sweep_ratio = body_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		timbre_sweep_ratio = timbre_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		body_time = body_time.lincurve(0,1,0,2,3);
		timbre_time = timbre_time.lincurve(0,1,0,1,3);
		transient_time = transient_time.lincurve(0,1,0.005,0.25,3);
		tail_time = tail_time.lincurve(0,1,0,1,3);
		body_vol = body_vol.lincurve(0,1,0,1,3);
		timbre_vol = timbre_vol.lincurve(0,1,0,1,3);
		transient_vol = transient_vol.lincurve(0,1,0,1,3);
		tail_vol = tail_vol.lincurve(0,1,0,1,3);
		time_factor = time_factor.lincurve(0,1,0.25,2,3);

		body_time = body_time * time_factor;
		timbre_time = timbre_time * time_factor;
		transient_time = transient_time * time_factor;
		tail_time = tail_time * time_factor;

		body_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: body_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		timbre_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: timbre_time,
				curve: -5
			),
			gate: gate);

		transient_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: transient_time,
				curve: -3
			),
			gate: gate);

		tail_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: tail_time,
				curve: -6
			),
			gate: gate,
			doneAction:2);

		timbre_freq = freq * timbre_ratio;
		body_sweep = freq * transient_envelope;
		timbre_sweep = timbre_freq * transient_envelope;

		body = SinOsc.ar(freq + body_sweep, 0, body_envelope * body_vol);
		timbre = SinOsc.ar(timbre_freq + timbre_sweep, 0, timbre_envelope * timbre_vol);
		transient = ClipNoise.ar(transient_vol * transient_envelope);
		tail = BHiPass.ar(ClipNoise.ar(tail_vol * tail_envelope),freq,2);

		volume_compensation = 1 / (body_vol + timbre_vol + transient_vol +	tail_vol);
		mix = (body + timbre + transient + tail) * volume_compensation;
	},

	fmTransientTail: {arg freq = 440,
		gate = 1,
		modulator_ratio = 0.2,
		carrier_sweep_ratio = 0.5,
		modulator_sweep_ratio = 0.5,
		carrier_time = 0.5,
		modulator_time = 0.5,
		transient_time = 0.1,
		tail_time = 0.7,
		carrier_vol = 1,
		modulator_vol = 1,
		transient_vol = 1,
		tail_vol = 1,
		time_factor = 1;

		var carrier_envelope, modulator_envelope, transient_envelope, tail_envelope,
		modulator_freq, carrier_sweep, modulator_sweep,
		carrier, modulator, transient, tail, volume_compensation,
		mix;

		modulator_ratio = modulator_ratio.lincurve(0,1,-24,24,0).midiratio;
		carrier_sweep_ratio = carrier_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		modulator_sweep_ratio = modulator_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		carrier_time = carrier_time.lincurve(0,1,0,2,3);
		modulator_time = modulator_time.lincurve(0,1,0,1,3);
		transient_time = transient_time.lincurve(0,1,0.005,0.25,3);
		tail_time = tail_time.lincurve(0,1,0,1,3);
		carrier_vol = carrier_vol.lincurve(0,1,0,1,3);
		modulator_vol = modulator_vol.lincurve(0,1,0,1,3);
		transient_vol = transient_vol.lincurve(0,1,0,1,3);
		tail_vol = tail_vol.lincurve(0,1,0,1,3);
		time_factor = time_factor.lincurve(0,1,0.25,2,3);

		carrier_time = carrier_time * time_factor;
		modulator_time = modulator_time * time_factor;
		transient_time = transient_time * time_factor;
		tail_time = tail_time * time_factor;

		carrier_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: carrier_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		modulator_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: modulator_time,
				curve: -5
			),
			gate: gate);

		transient_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: transient_time,
				curve: -3
			),
			gate: gate);

		tail_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: tail_time,
				curve: -6
			),
			gate: gate,
			doneAction:2);

		modulator_freq = freq * modulator_ratio;
		modulator_sweep = modulator_freq * transient_envelope;
		carrier_sweep = freq * transient_envelope;

		modulator = SinOsc.ar(modulator_freq + modulator_sweep, 0, modulator_envelope * modulator_vol * freq);
		carrier = SinOsc.ar((freq + carrier_sweep) + modulator, 0, carrier_envelope * carrier_vol);
		transient = ClipNoise.ar(transient_vol * transient_envelope);
		tail = BHiPass.ar(ClipNoise.ar(tail_vol * tail_envelope),freq,2);

		volume_compensation = 1 / (carrier_vol + transient_vol +	tail_vol);
		mix = (carrier + transient + tail) * volume_compensation;
	},

	noiseFmTransientTail: {arg freq = 440,
		gate = 1,
		modulator_ratio = 0.2,
		carrier_sweep_ratio = 0.5,
		modulator_sweep_ratio = 0.5,
		carrier_time = 0.5,
		modulator_time = 0.5,
		transient_time = 0.1,
		tail_time = 0.7,
		carrier_vol = 1,
		modulator_vol = 1,
		transient_vol = 1,
		tail_vol = 1,
		time_factor = 1;

		var carrier_envelope, modulator_envelope, transient_envelope, tail_envelope,
		modulator_freq, carrier_sweep, modulator_sweep,
		carrier, modulator, transient, tail, volume_compensation,
		mix;

		modulator_ratio = modulator_ratio.lincurve(0,1,-24,24,0).midiratio;
		carrier_sweep_ratio = carrier_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		modulator_sweep_ratio = modulator_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		carrier_time = carrier_time.lincurve(0,1,0,2,3);
		modulator_time = modulator_time.lincurve(0,1,0,1,3);
		transient_time = transient_time.lincurve(0,1,0.005,0.25,3);
		tail_time = tail_time.lincurve(0,1,0,1,3);
		carrier_vol = carrier_vol.lincurve(0,1,0,1,3);
		modulator_vol = modulator_vol.lincurve(0,1,0,1,3);
		transient_vol = transient_vol.lincurve(0,1,0,1,3);
		tail_vol = tail_vol.lincurve(0,1,0,1,3);
		time_factor = time_factor.lincurve(0,1,0.25,2,3);

		carrier_time = carrier_time * time_factor;
		modulator_time = modulator_time * time_factor;
		transient_time = transient_time * time_factor;
		tail_time = tail_time * time_factor;

		carrier_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: carrier_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		modulator_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: modulator_time,
				curve: -5
			),
			gate: gate);

		transient_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: transient_time,
				curve: -3
			),
			gate: gate);

		tail_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: tail_time,
				curve: -6
			),
			gate: gate,
			doneAction:2);

		modulator_freq = freq * modulator_ratio;
		modulator_sweep = modulator_freq * transient_envelope;
		carrier_sweep = freq * transient_envelope;

		modulator = WhiteNoise.ar(modulator_envelope * modulator_vol * freq);
		carrier = SinOsc.ar((freq + carrier_sweep) + modulator, 0, carrier_envelope * carrier_vol);
		transient = ClipNoise.ar(transient_vol * transient_envelope);
		tail = BHiPass.ar(ClipNoise.ar(tail_vol * tail_envelope),freq,2);

		volume_compensation = 1 / (carrier_vol + transient_vol +	tail_vol);
		mix = (carrier + transient + tail) * volume_compensation;
	},

		amTransientTail: {arg freq = 440,
		gate = 1,
		modulator_ratio = 0.2,
		carrier_sweep_ratio = 0.5,
		modulator_sweep_ratio = 0.5,
		carrier_time = 0.5,
		modulator_time = 0.5,
		transient_time = 0.1,
		tail_time = 0.7,
		carrier_vol = 1,
		modulator_vol = 1,
		transient_vol = 1,
		tail_vol = 1,
		time_factor = 1;

		var carrier_envelope, modulator_envelope, transient_envelope, tail_envelope,
		modulator_freq, carrier_sweep, modulator_sweep,
		carrier, modulator, transient, tail, volume_compensation,
		mix;

		modulator_ratio = modulator_ratio.lincurve(0,1,-24,24,0).midiratio;
		carrier_sweep_ratio = carrier_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		modulator_sweep_ratio = modulator_sweep_ratio.lincurve(0,1,0,48,0).midiratio;
		carrier_time = carrier_time.lincurve(0,1,0,2,3);
		modulator_time = modulator_time.lincurve(0,1,0,1,3);
		transient_time = transient_time.lincurve(0,1,0.005,0.25,3);
		tail_time = tail_time.lincurve(0,1,0,1,3);
		carrier_vol = carrier_vol.lincurve(0,1,0,1,3);
		modulator_vol = modulator_vol.lincurve(0,1,0,1,3);
		transient_vol = transient_vol.lincurve(0,1,0,1,3);
		tail_vol = tail_vol.lincurve(0,1,0,1,3);
		time_factor = time_factor.lincurve(0,1,0.25,2,3);

		carrier_time = carrier_time * time_factor;
		modulator_time = modulator_time * time_factor;
		transient_time = transient_time * time_factor;
		tail_time = tail_time * time_factor;

		carrier_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: carrier_time,
				curve: -4
			),
			gate: gate,
			doneAction:2);

		modulator_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: modulator_time,
				curve: -5
			),
			gate: gate);

		transient_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: transient_time,
				curve: -3
			),
			gate: gate);

		tail_envelope = EnvGen.kr(
			Env.perc(
				attackTime: 0.001,
				releaseTime: tail_time,
				curve: -6
			),
			gate: gate,
			doneAction:2);

		modulator_freq = freq * modulator_ratio;
		modulator_sweep = modulator_freq * transient_envelope;
		carrier_sweep = freq * transient_envelope;

		modulator = SinOsc.ar(modulator_freq + modulator_sweep, 0, modulator_envelope * modulator_vol);
		carrier = SinOsc.ar(freq + carrier_sweep, 0, carrier_envelope * carrier_vol * modulator);
		transient = ClipNoise.ar(transient_vol * transient_envelope);
		tail = BHiPass.ar(ClipNoise.ar(tail_vol * tail_envelope),freq,2);

		volume_compensation = 1 / (carrier_vol + transient_vol + tail_vol);
		mix = (carrier + transient + tail) * volume_compensation;
	},


);
);

"drums: ".post;
~drumTypes.keys.postln;

0.midiratio