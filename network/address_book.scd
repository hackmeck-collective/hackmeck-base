(
"initialize adressbook".postln;
~addrBook ?? ~addrBook = AddrBook.new;
~addrBook.addMe;
~hail = Hail.new(~addrBook);

"initialize OSC Object Spaces".postln;
~osc_data_params = OSCObjectSpace(~addrBook, oscPath: '/params').acceptEvents_(true);

~instrumentPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/instrumentPresets').acceptEvents_(true);
~drumPresetsDictionary = OSCObjectSpace(~addrBook, oscPath: '/drumPresets').acceptEvents_(true);
~pitchesRootDissonance = OSCObjectSpace(~addrBook, oscPath: '/pitches').acceptEvents_(true);
~routing = OSCObjectSpace(~addrBook, oscPath: '/routing').acceptEvents_(true);
~cueData = OSCDataSpace(~addrBook, '/cueData');
~cueData[\fillLength] = 1;

"make SynthDescRelay".postln;
~synthDescRel = SynthDescRelay(~addrBook);

"addressbook loaded";
);

