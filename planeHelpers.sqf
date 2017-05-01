/*
--------------------------------------------------------------------------
 Landing Aids
--------------------------------------------------------------------------
*/

dingus_fnc_enableLandingAids = {
  ["HelpersVisible", "1"] call dingus_fnc_setVar;
  ["Landing aids enabled."] call dingus_fnc_Alert;
};

dingus_fnc_disableLandingAids = {
  ["HelpersVisible", "0"] call dingus_fnc_setVar;
  ["Landing aids disabled."] call dingus_fnc_Alert;
};

dingus_fnc_PlayerVehicleChanged = {
  _veh = vehicle player;

  if (_veh == player) then {
    ["CurrentPlane", nil] call dingus_fnc_setVar;  
  } else {
    ["CurrentPlane", vehicle player] call dingus_fnc_setVar;
  };
};

player addAction [["Landing Aids On"] call dingus_fnc_formatActionLabel, {[] call dingus_fnc_enableLandingAids;}, [], 0.45, false, true, "", "([""HelpersVisible"", ""0""] call dingus_fnc_getVar) == ""0"""];
player addAction [["Landing Aids Off"] call dingus_fnc_formatActionLabel, {[] call dingus_fnc_disableLandingAids;}, [], 0.45, false, true, "", "([""HelpersVisible"", ""0""] call dingus_fnc_getVar) == ""1"""];

/*
--------------------------------------------------------------------------
 Refuel / Repair
--------------------------------------------------------------------------
*/

//Request Refuel
dingus_fnc_requestRefuel = {
  _truck = ["CurrentFuelTruck"] call dingus_fnc_getVar;
  if (!isNil "_truck") then {
    _wp = (group (driver _truck)) addWaypoint [position vehicle player, 4];
    ["Request acknowledged. Please stand by..."] call dingus_fnc_Alert;
  } else {
    systemChat "Can't set waypoint no truck."
  };
};

//In a vehicle, at a known airport, fuel level less than 40%
dingus_fnc_canRefuel = {
  _veh = vehicle player;
  _fuel = fuel _veh;
  _truck = ["CurrentFuelTruck"] call dingus_fnc_getVar;
  _ret = ((vehicle player != player) && (!isNil "_truck") && (_fuel <= 0.4));
  _ret;
};

//Request Repair
dingus_fnc_requestRepair = {
  _truck = ["CurrentRepairTruck"] call dingus_fnc_getVar;
  if (!isNil "_truck") then {
    _wp = (group (driver _truck)) addWaypoint [position vehicle player, 4];
    ["Request acknowledged. Please stand by..."] call dingus_fnc_Alert;
  } else {
    systemChat "Can't set waypoint no truck 2."
  };
};

//In a vehicle, with a valid truck, damage level any
dingus_fnc_canRepair = {
  _veh = vehicle player;
  _dam = damage _veh;
  _truck = ["CurrentRepairTruck", nil] call dingus_fnc_getVar;
  _ret = ((vehicle player != player) && (!isNil "_truck") && (_dam > 0.01));
  _ret;
};

player addAction [["Services: Refuel"] call dingus_fnc_formatActionLabel, {[] call dingus_fnc_requestRefuel;}, [], 45, false, true, "", "[] call dingus_fnc_canRefuel"];
player addAction [["Services: Repair"] call dingus_fnc_formatActionLabel, {[] call dingus_fnc_requestRepair;}, [], 45, false, true, "", "[] call dingus_fnc_canRepair"];
