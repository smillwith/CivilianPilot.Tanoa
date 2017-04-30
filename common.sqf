dingus_fnc_Alert = {
  params ["_msg"];
  hint _msg;
};

dingus_fnc_getVar = {
  params ["_key", "_defaultValue"];
  if (!isNil "_defaultValue") then {
    missionNamespace getVariable [_key, _defaultValue];
  } else {
    missionNamespace getVariable _key;
  };
};

dingus_fnc_setVar = {
  params ["_k", "_v"];
  if (isNil "_k") then { _k = 'nil'; };
  if (isNil "_v") then { _v = 'nil'; };
  //systemChat format ["Setting key: %1", _k];
  //systemChat format ["Setting value: %1", _v];
  missionNamespace setVariable [_k, _v];
};


dingus_fnc_formatActionLabel = {
  params ["_text"];

  _label = "[CP] " + _text;
  _label;
};


//true;

