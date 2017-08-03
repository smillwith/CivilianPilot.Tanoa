//titleText ["Please wait...", "BLACK OUT", 0];

_handle = execVM "common.sqf"; 
waitUntil { scriptDone _handle };

//Global vars
["HelpersVisible", "0"] call dingus_fnc_setGlobalVar;

//Player variables
["MarkersVisible", "1"] call dingus_fnc_setVar;
["TaskLocations", "1"] call dingus_fnc_setVar;
["Boarding", "0"] call dingus_fnc_setVar;
["Boarded", "0"] call dingus_fnc_setVar;
["Transporting", "0"] call dingus_fnc_setVar;
["Arrived", "0"] call dingus_fnc_setVar;
["DestinationAirport", ""] call dingus_fnc_setVar;
["CurrentPassenger", nil] call dingus_fnc_setVar;
["CurrentCompanion", nil] call dingus_fnc_setVar;
["OnBoarding", "0"] call dingus_fnc_setVar;

//Disable in mp
if ([] call dingus_fnc_SinglePlayer) then {
  _handle2 = execVM "atc.sqf";
  waitUntil { scriptDone _handle2 };
  [] call dingus_fnc_atc_init;

  //TODO: Disable in MP
  execVM "atis.sqf";
};

//TODO: Server only?
if (isServer) then {
  execVM "ai.sqf";
  execVM "passengers.sqf";
}
//end

execVM "companion.sqf";
execVM "planeHelpers.sqf";

/*[] spawn {
  sleep 5;
  titleFadeOut 5;
};*/

//titleFadeOut 5;
