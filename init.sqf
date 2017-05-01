_handle = execVM "common.sqf"; 
waitUntil { scriptDone _handle };

["HelpersVisible", "0"] call dingus_fnc_setVar;
["MarkersVisible", "1"] call dingus_fnc_setVar;
["TaskLocations", "1"] call dingus_fnc_setVar;

["Boarding", "0"] call dingus_fnc_setVar;
["Boarded", "0"] call dingus_fnc_setVar;
["Transporting", "0"] call dingus_fnc_setVar;
["Arrived", "0"] call dingus_fnc_setVar;

//asdf
//["CurrentAirport", "tanoa"] call dingus_fnc_setVar;
//["CurrentFuelTruck", tanoa_fuel] call dingus_fnc_setVar;
//["CurrentRepairTruck", tanoa_repair] call dingus_fnc_setVar;

["DestinationAirport", ""] call dingus_fnc_setVar;

//This is just for testing mainly
["CurrentPlane", plane1a] call dingus_fnc_setVar;

//["CurrentTask", ""] call dingus_fnc_setVar;
//["CurrentPassengerGroup", ""] call dingus_fnc_setVar;
["CurrentPassenger", nil] call dingus_fnc_setVar;


execVM "passengers.sqf";
execVM "planeHelpers.sqf"

