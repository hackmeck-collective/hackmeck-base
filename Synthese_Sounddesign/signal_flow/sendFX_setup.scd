"initializing send effects".postln;
//
// ~cyclicBufferRecordPointer ?? {~cyclicBufferRecordPointer = Bus.audio(Server.default, 1)};

~grainDelay_1 ?? {~grainDelay_1 = Bus.audio(Server.default, 2)};
~grainDelayBuffer_1 ?? {~grainDelayBuffer_1 = Buffer.alloc(Server.default, Server.default.sampleRate * 5, 1)};
~grainDelayBufferPosition_1 ?? {~grainDelayBufferPosition_1 = Bus.audio(Server.default, 1)};

~granulator_1 ?? {~granulator_1 = Bus.audio(Server.default, 2)};
~granulatorBuffer_1 ?? {~granulatorBuffer_1 = Buffer.alloc(Server.default, Server.default.sampleRate * 5, 1)};
~granulatorBufferPosition_1 ?? {~granulatorBufferPosition_1 = Bus.audio(Server.default, 1)};

~beatRepeat_1 ?? {~beatRepeat_1 = Bus.audio(Server.default, 2)};
~beatRepeatBuffer_1 ?? {~beatRepeatBuffer_1 = Buffer.alloc(Server.default, Server.default.sampleRate * 5, 2)};
~beatRepeatBufferPosition_1 ?? {~beatRepeatBufferPosition_1 = Bus.audio(Server.default, 1)};

~infiniteHoldReverb ?? {~infiniteHoldReverb = Bus.audio(s,2)};

~ef_reverb ?? {~ef_reverb = Bus.audio(s,2)};
~simpleDelay ?? {~simpleDelay = Bus.audio(s,2)};

s.sync;

/*SynthDef.new(\cyclicBufferRecordPointer, {
arg out, buf=0;
var sig;

sig = Phasor.ar(0, BufRateScale.kr(buf), 0, BufFrames.kr(buf));
Out.ar(~cyclicBufferRecordPointer, sig);
}).add;*/

SynthDef.new(\grainDelayBufferRecord_1, {
	arg inBus = ~grainDelay_1,
	buf = ~grainDelayBuffer_1,
	bufPos = ~grainDelayBufferPosition_1,
	recording = 1;

	var ringBufDur = BufFrames.ir(buf);
	var recordPointer = Phasor.ar(rate: recording, end: ringBufDur);
	var input = InFeedback.ar(inBus, 2);

	BufWr.ar(input.sum, buf, recordPointer);
	Out.ar(bufPos, recordPointer);
}).add;

SynthDef.new(\granulatorBufferRecord_1, {
	arg inBus = ~granulator_1,
	buf = ~granulator_1Buffer_1,
	bufPos = ~granulator_1BufferPosition_1,
	recording = 1;

	var ringBufDur = BufFrames.ir(buf);
	var recordPointer = Phasor.ar(rate: recording, end: ringBufDur);
	var input = InFeedback.ar(inBus, 2);

	BufWr.ar(input.sum, buf, recordPointer);
	Out.ar(bufPos, recordPointer);
}).add;

SynthDef.new(\beatRepeatBufferRecord_1, {
	arg inBus = ~beatRepeat_1,
	buf = ~beatRepeatBuffer_1,
	bufPos = ~beatRepeatBufferPosition_1,
	recording = 1;

	var ringBufDur = BufFrames.ir(buf);
	var recordPointer = Phasor.ar(rate: recording, end: ringBufDur);
	var input = InFeedback.ar(inBus, 2);

	BufWr.ar(input, buf, recordPointer);
	Out.ar(bufPos, recordPointer);
}).add;

SynthDef(\ef_reverb, {
	arg inBus = ~ef_reverb,
	revtime = 2.5,
	predelay = 0.025,
	hpf = 60,
	lpf = 4000,
	spread = 1,
	vol = 1.5,
	beatDurNow = ~linkClock.tempo,
	sidechain_amount = (-24).dbamp;

	var sidechain_trigger_4 = \sidechain_trigger_4_verb.tr(0),
	sidechain_trigger_8 = \sidechain_trigger_8_verb.tr(0);

	var duck_4 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -2),sidechain_trigger_4, timeScale: beatDurNow),
	duck_8 = EnvGen.ar(Env([1,sidechain_amount,1],[0.01, 0.99], -1),sidechain_trigger_8, timeScale: (beatDurNow/2));

	var wet, temp, sig;

	temp = InFeedback.ar(inBus, 2);

	wet=0;

	temp=DelayN.ar(temp, 0.25, predelay);

	8.do {
		temp=AllpassN.ar(temp, 0.05, {Rand(0.001,0.05)}!4,revtime);
		temp=LPF.ar(temp,lpf);
		wet=wet+temp;
	};

	sig = wet * vol;

	sig = HPF.ar(Splay.ar(sig * duck_4 * duck_8, spread), hpf);

	Out.ar(~effect_bus, sig);

}).add;

SynthDef(\infiniteHoldReverb, {
	arg inBus = ~infiniteHoldReverb,
	reverbSend = 0.25,
	decaytime = 2,
	filterType = 0,
	controlbusFilterFreq = ~dummybus,
	filterFreq = 18000,
	controlbusFilterRes = ~dummybus,
	resonance = 3,
	controlbusFeedback = ~dummybus,
	feedback_amount = 1,
	controlbusVolume = ~dummybus,
	vol = 1;

	var input, local, feedback, delay;


	feedback_amount = feedback_amount * Lag.kr(In.kr( controlbusFeedback ), 0.1);
	filterFreq = Lag.kr(
		In.kr( controlbusFilterFreq ).lincurve(0,1,20,filterFreq,3),
		0.1).clip(30,10000);
	resonance = Lag.kr(In.kr( controlbusFilterRes ), 0.1).lincurve(0,1,1,resonance,3);
	vol = Lag.kr(In.kr( controlbusVolume ), 0.1).lincurve(0,1,0,vol,3);

	resonance;

	input = In.ar(inBus, 2);

	local = (LocalIn.ar(2) * feedback_amount) + input;

	15.do{local = AllpassN.ar(local, 0.06, Rand(0.001,0.06), decaytime) };

	LocalOut.ar(local * feedback_amount);

	local = Select.ar(filterType ,[
		RLPF.ar(local, filterFreq, resonance),
		BPF.ar(local, filterFreq, resonance),
		RHPF.ar(local, filterFreq, resonance),
	]);

	Out.ar(~effect_bus, local * vol);
	Out.ar(~ef_reverb, local * vol * reverbSend);

}).add;

SynthDef(\simpleDelay, {
	arg inBus = ~simpleDelay,
	beatDurNow = ~linkClock.tempo,
	relativeDelayTime = 0.75,
	filterType = 3,
	filterFreq = 500,
	resonance = 1.5,
	feedback_amount = 0.5,
	reverbSend = 0.25,
	maxDelayTime = 4;

	var input, inputDelay, feedback, delay;

	input = In.ar(inBus, 2);

	inputDelay = DelayL.ar(input, delaytime: ControlRate.ir.reciprocal);

	feedback = LocalIn.ar(2) * feedback_amount;

	delay = Select.ar(filterType ,[
		RLPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
		BPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
		RHPF.ar(DelayL.ar((inputDelay + feedback), maxDelayTime, (beatDurNow * relativeDelayTime) - ControlRate.ir.reciprocal), filterFreq, resonance),
	]);

	LocalOut.ar(delay);

	Out.ar(~effect_bus, delay);
	Out.ar(~ef_reverb, delay * reverbSend);

}).add;

SynthDef.new(\grainDelay_1, {
	arg amp = 0.5,
	out = ~effect_bus,
	buf = ~grainDelayBuffer_1,
	// buf2 = (~grainDelayBuffer_1.bufnum + 1),
	ptrBus = ~grainDelayBufferPosition_1,
	feedbackBus = ~grainDelay_1,
	atk = 1, rel = 1, gate = 1,
	sync = 1,
	dens = 40,
	baseDur = 0.05, durRand = 0.05,
	rate = 1, rateRand = 0.05,
	pan = 0.5, panRand = 0.5,
	grainEnv = (-1),
	ptrSampleDelay = 20000, ptrRandomSamples = 5000, minPtrDelay = 1000,
	feedback = 0.25;

	var sig, sig2,combined, env, densCtrl, durCtrl, rateCtrl, panCtrl,
	ptrRand, totalDelay, maxGrainDur, ptr;

	env = EnvGen.kr(Env.asr(atk,1,rel),gate, doneAction: 2);
	densCtrl = Select.ar(sync, [Dust.ar(dens), Impulse.ar(dens)]);
	durCtrl = baseDur + LFNoise1.ar(100).bipolar(durRand);
	rateCtrl = rate + LFNoise1.ar(100).bipolar(rateRand);
	panCtrl = pan + LFNoise1.kr(100).bipolar(panRand);

	ptrRand = LFNoise1.ar(100).bipolar(ptrRandomSamples);
	totalDelay = max(ptrSampleDelay - ptrRand, minPtrDelay);

	ptr = In.ar(ptrBus);
	ptr = ptr - ptrSampleDelay;
	ptr = ptr / BufFrames.kr(buf);
	ptr = ptr % 1;

	maxGrainDur = (totalDelay / rateCtrl) / SampleRate.ir;
	durCtrl = min(durCtrl, maxGrainDur);

	sig = GrainBuf.ar(
		2,
		densCtrl,
		durCtrl,
		buf,
		rateCtrl,
		ptr,
		2,
		panCtrl,
		grainEnv
	);

	combined = sig * env * amp;
	Out.ar(out, combined);
	Out.ar(feedbackBus, combined * feedback);
	Out.ar(~ef_reverb, combined * 0.25);
}).add;

"starting send effects".postln;

s.sync;

~startSendFX = {
	~sendFX = ();
	/*~sendFX.cyclicBufferRecordPointer = Synth.new(\cyclicBufferRecordPointer,
	[\buf, ~grainDelayBuffer, \out, ~cyclicBufferRecordPointer],
	target: ~pointer_group);*/

	~sendFX.grainDelayBufferRecord_1 = Synth.new(\grainDelayBufferRecord_1,
		[\inBus, ~grainDelay_1,
			\buf, ~grainDelayBuffer_1,
			\bufPos, ~grainDelayBufferPosition_1,
			\recording, 1],
		target: ~bufferRec_group);

	~sendFX.granulatorBufferRecord_1 = Synth.new(\granulatorBufferRecord_1,
		[\inBus, ~granulator_1,
			\buf, ~granulatorBuffer_1,
			\bufPos, ~granulatorBufferPosition_1,
			\recording, 1],
		target: ~bufferRec_group);

	~sendFX.beatRepeatBufferRecord_1 = Synth.new(\beatRepeatBufferRecord_1,
		[\inBus, ~beatRepeat_1,
			\buf, ~beatRepeatBuffer_1,
			\bufPos, ~beatRepeatBufferPosition_1,
			\recording, 1],
		target: ~bufferRec_group);

	~sendFX.grainDelay_1 = Synth.new(\grainDelay_1,
		[\amp, 1, \atk, 0.1, \rel, 1, \gate, 1, \sync, 1,
			\dens, 70, \baseDur, 0.05, \durRand, 0.02, \rate, 2,
			\rateRand, 0.025, \pan, 0.5, \panRand, 0.5, \grainEnv, (-1),
			\out, ~effect_bus,
			\buf, ~grainDelayBuffer_1,
			\ptrBus, ~grainDelayBufferPosition_1,
			\feedbackBus, ~grainDelay_1,
			\ptrSampleDelay, s.sampleRate*0.05,
			\ptrRandomSamples, s.sampleRate*0.03,
			\minPtrDelay, 100,
			\feedback, 0.01
		],
		target: ~effect_group);

	~sendFX.ef_reverb = Synth.new(\ef_reverb,
		args:[\inBus, ~ef_reverb,
			\revtime, 2.5,
			\predelay, 0.025,
			\hpf, 60,
			\lpf, 4000,
			\spread, 1,
			\vol, 1.5,
			\beatDurNow, ~linkClock.tempo,
			\sidechain_amount, (-24).dbamp],
		target: ~effect_group);

	~sendFX.infiniteHoldReverb = Synth.new(\infiniteHoldReverb,
		args:[\inBus, ~infiniteHoldReverb,
			\filterType, 0,
			\reverbSend, 0.25,
			\decaytime, 2,
			\controlbusFilterFreq, ~dummybus,
			\filterFreq, 18000,
			\controlbusFilterRes, ~dummybus,
			\resonance, 2,
			\controlbusFeedback, ~dummybus,
			\feedback_amount, 1,
			\controlbusVolume, ~dummybus,
			\vol, 1],
		target: ~effect_group);

	~sendFX.simpleDelay = Synth.new(\simpleDelay,
		args:[\inBus, ~simpleDelay,
			\beatDurNow, ~linkClock.tempo,
			\relativeDelayTime, 0.75,
			\filterType, 3,
			\filterFreq, 500,
			\resonance, 1.5,
			\feedback_amount, 0.5,
			\reverbSend, 0.25,
			\maxDelayTime, 4],
		target: ~effect_group);
};

ServerTree.add({ ~startSendFX.value });