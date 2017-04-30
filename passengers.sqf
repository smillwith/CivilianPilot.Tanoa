dingus_fnc_PassengersBoarding = {
  params ["_unit", "_code"];

  if (isNil "_code") then {
    _code = ["CurrentAirport", ""] call dingus_fnc_getVar;;
  };

  _vehicle = ["CurrentPlane"] call dingus_fnc_getVar;

  if (!isNil "_vehicle") then {
    ["Boarding", "1"] call dingus_fnc_setVar;

    {
      _x assignAsCargo _vehicle;
    } forEach units group _unit;

    units group _unit orderGetIn true;

    //TODO: This should be deferred and called from a trigger. we need to know how many passengers are expected and then when the count reaches that level trigger it

    //Signal that loading is complete
    [_code] call dingus_fnc_OnPassengersLoaded;

    ["CurrentPassenger", _unit] call dingus_fnc_setVar;
  };
};

//TODO: We should actually call this from a trigger
dingus_fnc_OnPassengersLoaded = {
  params ["_currentCode"];
  _airportMarkers = ["m_airport_tanoa", "m_airport_tuvanaka", "m_airport_baja", "m_airport_stgeorge", "m_airport_larochelle"];
  _airportCodes = ["tanoa", "tuvanaka", "baja", "stgeorge", "larochelle"];
  _airportNames = ["Tanoa Airport", "Tuvanaka Airbase", "Baja Airstrip", "Saint-George Airstrip", "La Rochelle Aerodrome"];

  _found = false;
  _name = "";
  _marker = "";
  _loc = [0,0,0];
  _count = 0;
  _code = "";

  //Prevent destination from being the same as the current airport
  while { !_found && _count < 100 } do {
    _idx = floor random count _airportMarkers;
    _marker = _airportMarkers select _idx;
    _name = _airportNames select _idx;
    _code = _airportCodes select _idx;
    _loc = getMarkerPos _marker;
    
    //Validate that the code isn't the same as the currently selected or supplied airport code
    //systemChat format ["Does %1 == %2", _code, _currentCode];
    if (_code != _currentCode) then {
      //Found a unique one
      _found = true;
    };
    _count = _count + 1;
  };

  //Clear the 'boarding' flag and stuff
  ["Boarding", "0"] call dingus_fnc_setVar;
  ["Boarded", "1"] call dingus_fnc_setVar;
  ["DestinationAirport", _code] call dingus_fnc_setVar;

  //Get a new task index
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

  //This always fails so we don't store task in vars
  //["CurrentTask", format ["%1", _taskName]] call dingus_fnc_setVar;
};

dingus_fnc_DepartedLocation = {
  params ["_code"];

  //When we leave an airport, we clear the name and other vitals
  ["CurrentAirport", ""] call dingus_fnc_setVar;
  ["CurrentFuelTruck", ""] call dingus_fnc_setVar;
  ["CurrentRepairTruck", ""] call dingus_fnc_setVar;

  //Re-spawn the passenger group for this location
  [_code] call  dingus_fnc_createPassengerGroup;;
};


dingus_fnc_PlaneFlying = {
  ["Transporting", "1"] call dingus_fnc_setVar;
};

dingus_fnc_PlaneLanded = {
  ["Transporting", "0"] call dingus_fnc_setVar;
};

dingus_fnc_ArrivedAtLocation = {
  params ["_code", "_fuelTruck", "_repairTruck"];
  
  ["CurrentAirport", _code] call dingus_fnc_setVar;
  ["CurrentFuelTruck", _fuelTruck] call dingus_fnc_setVar;
  ["CurrentRepairTruck", _repairTruck] call dingus_fnc_setVar;

  //When we land at an airport
  //TODO: Make sure we're at the correct airport and they are still alive!
  _destinationAirport = ["DestinationAirport", ""] call dingus_fnc_getVar;
  if (_code == _destinationAirport) then {
    [] call dingus_fnc_PassengersArrived;
  };
};

dingus_fnc_PassengersArrived = {
  ["Arrived", "1"] call dingus_fnc_setVar;

  //At some point we should set the task as complete
  //_currentTask = ["CurrentTask", ""] call dingus_fnc_getVar;
  _allTasks = [player] call BIS_fnc_tasksUnit;
  _currentTask = _allTasks select (count _allTasks - 1);
  [_currentTask, "SUCCEEDED", true] call BIS_fnc_taskSetState;
};

dingus_fnc_PassengersUnloading = {
  ["Boarded", "0"] call dingus_fnc_setVar;
  ["Boarding", "0"] call dingus_fnc_setVar;
  ["Arrived", "0"] call dingus_fnc_setVar;

  //TODO: get the passengers(s) in a better way
  _passenger = ["CurrentPassenger"] call dingus_fnc_getVar;

  if (!isNil "_passenger") then {
    //Flight's over. Get out. Then...Send them away to a grave or something?
    //{
      //They always get back in
      //doGetOut _x;

    //} forEach units group _passenger;
    (group _passenger) leaveVehicle (vehicle _passenger);

    //Send them to a known marker at the current airport
    _code = ["CurrentAirport", ""] call dingus_fnc_getVar;
    _marker = _code + "_arrivals";
    _wp = (group _passenger) addWaypoint [getMarkerPos _marker, 0];
  };

  ["CurrentPassenger", nil] call dingus_fnc_setVar;
};

dingus_fnc_createPassengerGroup = {
  params ["_code"];
 
  _models = ["C_man_1", "C_man_p_beggar_F"];
  _marker = _code + "_departures";
  _markerRunway =  "m_airport_" + _code;
  _group = createGroup [civilian, true];

  //Set formation
  _group setFormation "COLUMN";
  _group setBehaviour "CARELESS";

  //Create leader
  _leader = _group createUnit [_models select floor random count _models, (getMarkerPos _marker), [], 0.5, "FORM"];
  _leader lookAt (getMarkerPos _markerRunway);

  //Apply a loadout to this guy
  [_leader] call dingus_fnc_ApplyPassengerLoadout;

  //Spawn a second or third
  _rnd = floor random 10;

  if (_rnd mod 2 == 0) then {
    _two = _group createUnit [_models select floor random count _models, _group, [], 0.5, "FORM"];
    [_two] call dingus_fnc_ApplyPassengerLoadout;
  };

  //Add action to leader
  [_leader, _code] call dingus_fnc_AddPassengerBoardingAction;
};

dingus_fnc_ApplyPassengerLoadout = {
  params ["_unit"];

  removeAllWeapons _unit;
  removeAllItems _unit;
  removeAllAssignedItems _unit;
  removeUniform _unit;
  removeVest _unit;
  removeBackpack _unit;
  //removeHeadgear _unit;
  //removeGoggles _unit;

  _uniforms = ["U_NikosAgedBody", "U_Marshal", "U_C_Journalist", "U_C_Man_casual_1_F", "U_C_Poloshirt_salmon"];

  //Get random uni
  _uniform = _uniforms select floor random count _uniforms;

  //Uniform
  _unit forceAddUniform _uniform;
  
  _unit linkItem "ItemMap";
  _unit linkItem "ItemCompass";
  _unit linkItem "ItemWatch";
};

/* Action Helpers */

dingus_fnc_PassengersCanBoard = {
  (vehicle player == player && ((["Boarded", "0"] call dingus_fnc_getVar) == "0"));
};

dingus_fnc_AddPassengerBoardingAction = {
  params ["_leader", "_code"];

  //don't format this label
  _label = "Hello, I'm Dave, your pilot. Climb aboard!";

  switch (_code) do {
    case "tanoa": {
      _leader addAction [_label, {
        [_this select 0, "tanoa"] call dingus_fnc_PassengersBoarding;
      }, [], 45, true, true, "", "[] call dingus_fnc_PassengersCanBoard"];
    };
    case "tuvanaka": {
      _leader addAction [_label, {
        [_this select 0, "tuvanaka"] call dingus_fnc_PassengersBoarding;
      }, [], 45, true, true, "", "[] call dingus_fnc_PassengersCanBoard"];
    };
    case "larochelle": {
      _leader addAction [_label, {
        [_this select 0, "larochelle"] call dingus_fnc_PassengersBoarding;
      }, [], 45, true, true, "", "[] call dingus_fnc_PassengersCanBoard"];
    };
    case "stgeorge": {
      _leader addAction [_label, {
        [_this select 0, "stgeorge"] call dingus_fnc_PassengersBoarding;
      }, [], 45, true, true, "", "[] call dingus_fnc_PassengersCanBoard"];
    };
    case "baja": {
      _leader addAction [_label, {
        [_this select 0, "baja"] call dingus_fnc_PassengersBoarding;
      }, [], 45, true, true, "", "[] call dingus_fnc_PassengersCanBoard"];
    };
  };
};

dingus_fnc_PassengersCanUnload = {
  _inVehicle = (vehicle player != player);
  _arrived = ((["Arrived", "0"] call dingus_fnc_getVar) == "1");
  _atDestination = ((["CurrentAirport", ""] call dingus_fnc_getVar) == (["DestinationAirport", ""] call dingus_fnc_getVar));
  _inVehicle && _arrived && _atDestination;
};

dingus_fnc_AddPassengerUnloadAction = {
  params ["_leader"];

  _label = "OK! Here we are. Safe and sound.";
  _label = [_label] call dingus_fnc_formatActionLabel;

  _leader addAction [_label, {
    [] call dingus_fnc_PassengersUnloading;
  }, [], 45, false, true, "", "[] call dingus_fnc_PassengersCanUnload"];
};


