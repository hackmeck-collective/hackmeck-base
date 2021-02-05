~lsys = (); // dict for everything regarding the lsys
~lsys.list = List.new;
~lsys.argsList = List.new;
~lsys.isReading = false;
~addrBook = AddrBook.new;
~addrBook.addMe;//(Peer(\vincent, NetAddr("192.168.178.28",57120)));
~hail = Hail.new(~addrBook);
//~registrar = Registrant(~addrBook); // execute this only on the central machine
~objSpace = OSCObjectSpace(~addrBook, oscPath:'/lsysArgs').acceptEvents_(true);
~newObjUnhang = Condition.new;

~objSpace.addDependant({|objectSpace, what, key, val|
	if(key == \lsysRes){

	"Received new Lsys Result % \n".postf(val);
		if(~objSpace[\lsysRes].notNil){
			"reading stream ...".postln;
			if(~lsys.isReading){
				"CURRENTLY READING LSYS, NOT READING NEW STREAM".postln;
			}{
				~lsys.isReading = true;
				~lsys.newPattern = ~objSpace[\lsysRes].copy;
				~lsys.newPattern.stream = List.new;
				{
					~objSpace[\lsysRes].streamSize.do { |ix|
						~lsys.newPattern.stream.add(
							Object.readArchive(PathName.tmp +/+ "LSYSTEM_STREAM_" ++ ix)
						);
						0.001.wait;
					};
					~lsys.list.add(~lsys.newPattern);
					~lsys.argsList.add(~objSpace[\lsys]);
					~lsys.isReading = false;
					~newObjUnhang.unhang;
					"finished reading lsys stream".postln;
				}.fork;
			}
		}
	}
});