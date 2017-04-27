dingus_fnc_enableLandingAids = {
  missionNamespace setVariable ["HelpersVisible", "1"];
  ["Landing aids enabled."] call dingus_fnc_Alert;
};

dingus_fnc_disableLandingAids = {
  missionNamespace setVariable ["HelpersVisible", "0"];
  ["Landing aids disabled."] call dingus_fnc_Alert;
};

player addAction ["Landing Aids On", {[] call dingus_fnc_enableLandingAids;}, [], 1.5, false, true, "", "missionNamespace getVariable [""HelpersVisible"", ""0""] == ""0"""];
player addAction ["Landing Aids Off", {[] call dingus_fnc_disableLandingAids;}, [], 1.5, false, true, "", "missionNamespace getVariable [""HelpersVisible"", ""0""] == ""1"""];
