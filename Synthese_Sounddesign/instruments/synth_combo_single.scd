~synthPool = Set.new;
/*~makeSynthDef.(\lead, \fm, \basic, \nofx, \nofilter)

Pbindef(\test,
	\instrument, Pfunc {~makeSynthDef.(\lead, \fm, \basic, \nofx, \nofilter)},
).play*/

~makeSynthDef = { |adsrType, pitchOpType, oscillatorType, fxTypes,filterTypes|
	var synthDefName =
	adsrType.asString ++ "_" ++
	pitchOpType.asString ++ "_" ++
	oscillatorType.asString ++ "_" ++
	fxTypes.asString ++ "_" ++
	filterTypes.asString;

	if(~synthPool.includes(synthDefName).not){
		var envelope_function = ~adsrTypes[adsrType];
		var oscillator_function = ~oscillatorTypes[oscillatorType];
		var pitchOp_function = ~pitchOpTypes[pitchOpType];
		var fx_function = ~fxTypes[fxTypes];
		var filter_function = ~filterTypes[filterTypes];

		~synthPool.add(synthDefName);

		SynthDef.new(synthDefName,
			{
				arg gate = 1,
				freq = 440,
				controlbus,
				out,
				send_1 = ~ef_reverb,
				send_1_level = 0.6,
				pitchOp_mod_1,
				pitchOp_mod_1_macro_channel,
				pitchOp_mod_2,
				pitchOp_mod_2_macro_channel,
				oscillator_mod_1 = 0.25,
				oscillator_mod_1_macro_channel = 2,
				oscillator_mod_2 = 0.25,
				oscillator_mod_2_macro_channel = 0,
				fx_mod_1 = 0.2,
				fx_mod_1_macro_channel = 0,
				fx_mod_2 = 0.2,
				fx_mod_2_macro_channel = 0,
				filter_mod_1 = 0.2,
				filter_mod_1_macro_channel = 0,
				filter_mod_2 = 0.2,
				filter_mod_2_macro_channel = 0,
				envelope_mod = 0.25,
				envelope_mod_macro_channel = 3;

				var note = \note.kr(60,0);

				var macro_controls = Lag.kr(
					In.kr(
						controlbus,
						4),
					0.1);

				var macro_1 = macro_controls[0],
				macro_2 = macro_controls[1],
				macro_3 = macro_controls[2];

				var fader = macro_controls[3],
				vol = fader.lincurve(0,1,0,0.1,3),
				vol_correct = 1;

				var envelope, pitchOp_freq, oscillator, fx, filter, amp;


				// pitchOp_mod_1 = [pitchOp_mod_1, macro_1, macro_2, macro_3].at(pitchOp_mod_1_macro_channel)


				pitchOp_mod_1 = Select.kr(pitchOp_mod_1_macro_channel,
					[pitchOp_mod_1, macro_1, macro_2, macro_3]);
				pitchOp_mod_2 = Select.kr(pitchOp_mod_2_macro_channel,
					[pitchOp_mod_2, macro_1, macro_2, macro_3]);
				oscillator_mod_1 = Select.kr(oscillator_mod_1_macro_channel,
					[oscillator_mod_1, macro_1, macro_2, macro_3]);
				oscillator_mod_2 = Select.kr(oscillator_mod_2_macro_channel,
					[oscillator_mod_2, macro_1, macro_2, macro_3]);
				fx_mod_1 = Select.kr(fx_mod_1_macro_channel,
					[fx_mod_1, macro_1, macro_2, macro_3]);
				fx_mod_2 = Select.kr(fx_mod_2_macro_channel,
					[fx_mod_2, macro_1, macro_2, macro_3]);
				filter_mod_1 = Select.kr(filter_mod_1_macro_channel,
					[filter_mod_1, macro_1, macro_2, macro_3]);
				filter_mod_2 = Select.kr(filter_mod_2_macro_channel,
					[filter_mod_2, macro_1, macro_2, macro_3]);
				envelope_mod = Select.kr(envelope_mod_macro_channel,
					[envelope_mod, macro_1, macro_2, macro_3]);

				envelope = SynthDef.wrap(
					envelope_function,
					prependArgs: [gate, envelope_mod],
				);

				pitchOp_freq = SynthDef.wrap(
					pitchOp_function,
					prependArgs: [freq, gate, pitchOp_mod_1, pitchOp_mod_2],
				);

				oscillator = Splay.ar(
					SynthDef.wrap(
						oscillator_function,
						prependArgs: [pitchOp_freq, gate, oscillator_mod_1, oscillator_mod_2],
					)
				);

				fx = SynthDef.wrap(
					fx_function,
					prependArgs: [oscillator, gate, freq, fx_mod_1, fx_mod_2],
				);

				filter = SynthDef.wrap(
					fx_function,
					prependArgs: [oscillator, gate, freq, filter_mod_1, filter_mod_2],
				);

				amp = filter * vol * envelope;

				Out.ar(out, amp);
				Out.ar(send_1, amp * send_1_level);

		}).add;
	};
	synthDefName
};