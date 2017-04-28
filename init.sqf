execVM "common.sqf";
execVM "passengers.sqf";
execVM "planeHelpers.sqf"


//Initialize defaults
missionNamespace setVariable ["HelpersVisible", "0"];
missionNamespace setVariable ["Boarding", "0"];
missionNamespace setVariable ["Boarded", "0"];
missionNamespace setVariable ["Arrived", "0"];

missionNamespace setVariable ["CurrentPlane", plane0];
