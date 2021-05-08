(
~instrumentPresetsDictionary['metalPerc'] = [
	// \noEnv, \pluck, \lead, \pad, \sync

	\adsrType, \pluck,
	\sendGate, false,
	\envelope_mod, 0.3,
	\envCurve, -2,

	// \noPitchOp, \vibrato, \slide, \unisonoDetune, \fm, \vibratoSync, \slideVibrato, \rectArpSync, \rectArp

	\pitchOpType, \slide,
	\pitchOp_1_interval, 7,
	\pitchOp_1_amount, 0.05,

	\pitchOpType_2, \vibrato,
	\pitchOp_2_interval, 0.3,
	\pitchOp_2_amount, 0.1,

	// \noOscillator, \basic, \fm, \formant, \filteredNoise, \modal, \pulsar, \ping, \grainCloudGuitar

	\oscillatorType, \fm,
	\oscillator_mod_1, 2,
	\oscillator_mod_2, 1.7,
	\oscillator_1_level, 1,
	\oscillator_1_transpose, 0,

	\oscillatorType_2, \fm,
	\oscillator_2_mod_1, 1,
	\oscillator_2_mod_2, 1.3,
	\oscillator_2_level, 0.5,
	\oscillator_1_transpose, 12,

	// \noDrum, \bodyTimbreTransientTail, \fmTransientTail, \noiseFmTransientTail, \amTransientTail

	\drumType, \fmTransientTail,
	\timbre_ratio, 0.3,
	\body_sweep_ratio, 1,
	\timbre_sweep_ratio, 0.5,
	\body_time, 0.5,
	\timbre_time, 0.3,
	\transient_time, 0.01,
	\tail_time, 0.75,
	\body_vol, 1,
	\timbre_vol, 0,
	\transient_vol, 1,
	\tail_vol, 0,
	\time_factor, 0.5,
	\punch_factor, 2,
	\drum_1_level, 0.5,

	\drumType_2, \noDrum,
	\timbre_ratio_2, 0.45,
	\body_sweep_ratio_2, 1,
	\timbre_sweep_ratio_2, 0.25,
	\body_time_2, 0.5,
	\timbre_time_2, 0.5,
	\transient_time_2, 0.15,
	\tail_time_2, 0.75,
	\body_vol_2, 1,
	\timbre_vol_2, 0.25,
	\transient_vol_2, 1,
	\tail_vol_2, 0.65,
	\time_factor_2, 0.01,
	\punch_factor_2, 2,
	\drum_2_level, 0,

	// \noFx,
	// \overdriveSoft, \overdriveMid, \overdriveHard,
	// \shelvedOverdriveSoft, \shelvedOverdriveMid, \shelvedOverdriveHard,
	// \sampleRateReduction, \fold, \wrap, \rectifier,
	// \tremoloRect, \tremoloSine, \tremoloRamp,

	\fxType, \combfilterScaled,
	\fx_1_input_gain, 0.5,
	\fx_mod_1, 0,
	\fx_mod_2, 0.2,

	\fxType_2, \noFx,
	\fx_2_mod_1, 0.25,
	\fx_2_mod_2, 0.25,

	// \noFilter, \lpf_moog, \lpf_24, \lpf_12, \hpf_24, \hpf_12, \bpf, \notch, \lo_shelf, \hi_shelf,


	\filterIn_preFxLevel, 0,
	\filterIn_FxLevel, 1,

	\filterType, \noFilter,
	\filter_1_mod_1, 1,
	\filter_1_mod_2, 0.25,

	\filterType_2, \noFilter,
	\filter_2_mod_1, 1,
	\filter_2_mod_2, 0.25,

	\vca_filterLevel, 1,
	\vca_preFilterLevel, 0,
	\vca_preFxLevel, 0,

	\vol, 1,
	\amp, 0.7,

	\out, ~melody_bus,
	\send_1, ~ef_reverb,
	\send_1_level, 0.25,
	\send_2, ~simpleDelay_8d,
	\send_2_level, 0,

	// \noMod, \adsrEnv, \syncEnv, \sineSyncLFO, \sineLFO, \rampSyncLFO, \rampLFO, \sawSyncLFO, \saweLFO, \triSyncLFO, \triLFO, \rectSyncLFO, \rectLFO, \sampleAndHold

	\mod1Type, \sampleAndHold,
	\mod1Target, "oscillator_mod_2",
	\mod1Amount, 0.01,
	\mod1Rate, 0.25,
	\mod1attack, 1,
	\mod1decay, 1,
	\mod1sustain, 0.5,
	\mod1release, 1,
	\mod1EnvCurve, 2,
	\mod1syncEnvRatio, 0,
	\mod1ControlbusChannel, 0,

	\mod2Type, \adsrEnv,
	\mod2Target, "oscillator_2_mod_1",
	\mod2Amount, 0.2,
	\mod2Rate, 0.25,
	\mod2attack, 0,
	\mod2decay, 1,
	\mod2sustain, 0.5,
	\mod2release, 1,
	\mod2EnvCurve, -2,
	\mod2syncEnvRatio, 0,
	\mod2ControlbusChannel, 1,

	\mod3Type, \sampleAndHold,
	\mod3Target, "fx_mod_1",
	\mod3Amount, 0.01,
	\mod3Rate, 0.25,
	\mod3attack, 1,
	\mod3decay, 1,
	\mod3sustain, 0.5,
	\mod3release, 1,
	\mod3EnvCurve, 2,
	\mod3syncEnvRatio, 0,
	\mod3ControlbusChannel, 2,

	\mod4Type, \adsrEnv,
	\mod4Target, "oscillator_mod_1",
	\mod4Amount, 0.25,
	\mod4Rate, 0.25,
	\mod4attack, 0,
	\mod4decay, 0.25,
	\mod4sustain, 0,
	\mod4release, 0.25,
	\mod4EnvCurve, 2,
	\mod4syncEnvRatio, 0,
	\mod4ControlbusChannel, 3,

	\external1Target, "",
	\external1Amount, 1,
	\external2Target, "",
	\external2Amount, 1,
	\external3Target, "",
	\external3Amount, 1,
	\external4Target, "",
	\external4Amount, 1,
	\external1Target2, "",
	\external1Amount2, 1,
	\external2Target2, "",
	\external2Amount2, 1,
	\external3Target2, "",
	\external3Amount2, 1,
	\external4Target2, "",
	\external4Amount2, 1,

	\pattern1Target, "",
	\pattern1Amount, 1,
	\pattern2Target, "",
	\pattern2Amount, 1,
	\pattern3Target, "",
	\pattern3Amount, 1,
	\pattern4Target, "",
	\pattern4Amount, 1,

];
~callInstrumentPreset.('metalPerc');
)