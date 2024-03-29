"make_lsys.scd".loadRelative;
"pdefCreator.scd".loadRelative;

~newLsys = { |name, axiom, rules, gen, opts = (Dictionary.new)|
	var lsys = RedLSystem(axiom, rules), lsysPattern;
	var expandToArrays = [\legatoArr, \wrapLo, \wrapHi, \vols, \instr, \mute];
	gen.do { lsys.next };
	lsys.postln;
	//~lsys[\lastString] = lsys.postln;
	lsysPattern = ~makeStream.(lsys);
	//~lsys[\newPattern] = lsysPattern;
	/*~lsys[\presets][name] = ~lsys[\presets][name] ?? {~lsys[\defaultPreset].copy};
	~lsys[\presets][name].put(\maxPatDur, lsysPattern.lastTimes.maxItem);
	~lsys[\presets][name].put(\numBranches, lsysPattern.maxKey);
	~lsys[\presets][name].put(\rootPitchDrift, lsysPattern.stream[0].pitches.last);
	~lsys[\presets][name].putAll(opts);
	expandToArrays.do { |key|
		if(~lsys[\presets][name][key].isArray.not){
			~lsys[\presets][name].put(key, ~lsys[\presets][name][key] ! lsysPattern.maxKey)
		}
	};*/
	~lsys[name] = ~lsys[name] ?? {~lsys[\defaultPreset].copy};
	~lsys[name].put(\maxPatDur, lsysPattern.lastTimes.maxItem);
	~lsys[name].put(\numBranches, lsysPattern.maxKey);
	~lsys[name].put(\rootPitchDrift, lsysPattern.stream[0].pitches.last);
	~lsys[name].putAll(opts);
	expandToArrays.do { |key|
		if(~lsys[name][key].isArray.not){
			~lsys[name].put(key, ~lsys[name][key] ! lsysPattern.maxKey)
		}
	};
	~makePdef.(name, lsysPattern);
};

