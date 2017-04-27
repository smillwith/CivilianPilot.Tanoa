dingus_fnc_OnPassengersLoaded = {

  _airportMarkers = ["m_airport_tanoa", "m_airport_tuvanaka", "m_airport_baja", "m_airport_st_george", "m_airport_la_rochelle"];
  _airportNames = ["Tanoa Airport", "Tuvanaka Airbase", "Baja Airstrip", "Saint-George Airstrip", "La Rochelle Aerodrome"];
  _idx = floor random count _airportMarkers;
  _marker = _airportMarkers select _idx;
  _name = _airportNames select _idx;
  _loc = getMarkerPos _marker;

  //Get a new task index?
  _taskIndex = 0;
  _taskName = format ["task%1", _taskIndex];
  _taskTitle = "Arrive at " + _name;
  _taskDescription = "Transport your passengers to " + _name + ".";

  //Other style
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


  //Create the 'Arrived' trigger
  

}
