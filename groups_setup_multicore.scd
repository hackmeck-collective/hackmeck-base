"initializing groups".postln;

~makeGroups = {
//	~source_group = Group.new;
	~source_group = ParGroup.new;
	~effect_group = Group.after(~source_group);
	~bus_group = Group.after(~source_group);
	~summing_group = Group.after(~effect_group);
	~master_group = Group.tail;
	~routing[\sourceGroup] = ~source_group.nodeID;
};

ServerTree.add({ ~makeGroups.value });