(
var path = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "calc/hindemithTrees.archiv";
"loading archive ...".postln;
~trees = Object.readBinaryArchive(path);
"search_functions.scd".loadRelative;
"piano_gui.scd".loadRelative;
"finished loading".postln;

)



// result might be same as input at the moment
~searchTree.(chord: [1, 4, 9, 12], rootNote: 3, dissDegree: 2, offset: 7);
//chord ist der Ausgangsakkord
//rootNote und DissDegree sind die Parameter für die neue Liste
//offset ist der Radius der Suche nach einem passenden Accord
~searchTreeRadius.(chord: [1,4,10,12], rootNote: 7, dissDegree: 1, offset: 4)
// der radius offset entspricht der distance von search nearest
~searchTreeNearest.(chord: [1,4,10,12], rootNote: 7, dissDegree: 1)

// query the tree
~trees[\numNotes, 5, \rootNote, 0, \dissDegrees, 3].nearest([ 0, 4, 10, 14, 26.0 ])[0].location;
~trees[\numNotes, 3, \rootNote, 8, \dissDegrees, 3].asArray;
~trees[\numNotes, 4, \rootNote, \noRootNote]; // selten



[ [ 0, 4, 10, 14, 26 ], 0, 3, 5 ]
nearest chord distance 0.0
numNotes: 5

~chordNow = [0,3,7,14]; //für piano_gui

(
var res = ~searchTree.(chord: ~chordNow, rootNote: 2, dissDegree: 1, offset: 2);
res !? {
	~chordNow = res.choose.postln;
	~startPiano.showKeys(~chordNow)
}
)

~chordNow = [0, 4, 7, 11];
(
var res = ~searchTreeNearest.(chord: ~chordNow, rootNote: 4, dissDegree: 3);
res !? {
	~chordNow = res.postln;
	~startPiano.showKeys(~chordNow)
}
)

//~trees[\numNotes, 4, \rootNote, 0, \dissDegrees, 1].nearest([ 0, 7, 12,18])//[0].location;
