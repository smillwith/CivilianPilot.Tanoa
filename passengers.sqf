dingus_fnc_OnPassengersLoaded = {

  _airportMarkers = ["m_airport_tanoa", "m_airport_tuvanaka", "m_airport_baja", "m_airport_st_george", "m_airport_la_rochelle"];
  _airportNames = ["Tanoa Airport", "Tuvanaka Airbase", "Baja Airstrip", "Saint-George Airstrip", "La Rochelle Aerodrome"];
  _idx = floor random count _airportMarkers;
  _marker = _airportMarkers select _idx;
  _name = _airportNames select _idx;
  _loc = getMarkerPos _marker;

  //Clear the 'boarding' flag
  missionNamespace setVariable ["Boarding", "0"];
  missionNamespace setVariable ["Boarded", "1"];

  //TODO: Get a new task index?
  _tasks = [player] call BIS_fnc_tasksUnit;
  _taskIndex = 0;
  if (count _tasks > 0) then {
    _taskIndex = ((count _tasks) + 1);
  };
  _taskName = format ["task%1", _taskIndex];
  _taskTitle = "Arrive at " + _name;
  _taskDescription = "Transport your passengers to " + _name + ".";

  //taskCreate - Other style
  //0: BOOL or OBJECT or GROUP or SIDE or ARRAY - Task owner(s)
  //1: STRING or ARRAY - Task name or array in the format [task name, parent task name]
  //2: ARRAY or STRING - Task description in the format ["description", "title", "marker"] or CfgTaskDescriptions class
  //3: OBJECT or ARRAY or STRING - Task destination
  //4: BOOL or NUMBER or STRING - Task state (or true to set as current)
  //5: NUMBER - Task priority (when automatically selecting a new current task, higher priority is selected first)
  //6: BOOL - Show notification (default: true)
  //7: STRING - Task type as defined in the CfgTaskTypes
  //8: BOOL - Should the task being shared (default: false), if set to true, the assigned players are being counted
  [
    player,
    _taskName,
    [_taskDescription, _taskTitle, "_marker"],
    _marker,
    true,
    1,
    true,
    "move",
    false
  ] call BIS_fnc_taskCreate;
};

dingus_fnc_PassengersBoarding = {
  params ["_unit"];
  _vehicle = missionNamespace getVariable ["CurrentPlane", plane0];
  
  missionNamespace setVariable ["Boarding", "1"];

  //originally, this was done via waypoints. now we want to use commands, etc
  //{ _x moveInCargo _vehicle; } forEach units group _unit;
  {
    _x assignAsCargo _vehicle;
  } forEach units group _unit;
  
  units group _unit orderGetIn true;

  //TODO: Wait??

  [] call dingus_fnc_OnPassengersLoaded;
};

dingus_fnc_PassengersUnloading = {
  params ["_unit"];

  missionNamespace setVariable ["Boarded", "0"];
  missionNamespace setVariable ["Boarding", "0"];
  missionNamespace setVariable ["Arrived", "0"];

  //TODO: Flight's over. Get out. Then...Send them away to a grave or something?
  _unit action ["Eject", vehicle _unit];
};

dingus_fnc_PassengersArrived = {
  missionNamespace setVariable ["Arrived", "1"];
};

dingus_fnc_AddPassengerBoardingAction = {
  params ["_leader"];

  _leader addAction ["Hello, I'm your pilot. Climb aboard!", {[_this select 0] call dingus_fnc_PassengersBoarding;}, [], 1.5, false, true, "", "vehicle player == player && missionNamespace getVariable [""Boarded"", ""0""] == ""0"""];
};

dingus_fnc_AddPassengerUnloadAction = {
  params ["_leader"];

  _leader addAction ["OK! Here we are. Safe and sound.", {[] call dingus_fnc_PassengersUnloading;}, [], 1.5, false, true, "", "vehicle player != player && missionNamespace getVariable [""Arrived"", ""1""] == ""1"""];
};
