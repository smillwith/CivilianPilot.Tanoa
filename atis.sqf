/*
So:
Record the whole thing. Export to MP3 master
Trying the two chains - export to MP3_56 then export to ogg

_airportCodes = ["tanoa", "tuvanaka", "baja", "stgeorge", "larochelle"];

Requirements:
 - atc.sqf
*/

dingus_fnc_atis_altis = {
  _adjustmentFactor = 2;
  [_adjustmentFactor, "altis", ["0", "4"], ["2", "2"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_abdera = {
  _adjustmentFactor = 4;
  [_adjustmentFactor, "abdera", ["0", "5"], ["2", "3"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_almyra = {
  _adjustmentFactor = 6;
  [_adjustmentFactor, "almyra", ["0", "0"], ["1", "8"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_aac = {
  _adjustmentFactor = 8;
  [_adjustmentFactor, "aac", ["0", "4"], ["2", "2"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_molos = {
  _adjustmentFactor = 10;
  [_adjustmentFactor, "molos", ["2", "2"], ["0", "4"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_selakano = {
  _adjustmentFactor = 12;
  [_adjustmentFactor, "selakano", ["0", "1"], ["1", "9"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_tanoa = {
  _adjustmentFactor = 3;
  [_adjustmentFactor, "tanoa", ["1", "7"], ["3", "5"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_larochelle = {
  _adjustmentFactor = 6;
  [_adjustmentFactor, "larochelle", ["2", "9"], ["1", "1"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_stgeorge = {
  _adjustmentFactor = 9;
  [_adjustmentFactor, "stgeorge", ["3", "1"], ["1", "3"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_tuvanaka = {
  _adjustmentFactor = 1;
  [_adjustmentFactor, "tuvanaka", ["0", "5"], ["2", "3"]] call dingus_fnc_atis_wrapper;
};

dingus_fnc_atis_baja = {
  _adjustmentFactor = 7;
  [_adjustmentFactor, "baja", ["0", "7"], ["2", "5"]] call dingus_fnc_atis_wrapper;
};

player addAction [["Tune to Altis Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_altis}; }, [], 15, false, true, "", "[""altis""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to AAC Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_aac}; }, [], 16, false, true, "", "[""aac""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Almyra Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_almyra}; }, [], 15, false, true, "", "[""almyra""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Abdera Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_abdera}; }, [], 16, false, true, "", "[""abdera""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Molos Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_molos}; }, [], 15, false, true, "", "[""molos""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Selakano Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_selakano}; }, [], 16, false, true, "", "[""selakano""] call dingus_fnc_canTuneAtis"];

player addAction [["Tune to Tanoa Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_tanoa}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Baja Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_baja}; }, [], 15, false, true, "", "[""baja""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to La Rochelle Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_larochelle}; }, [], 15, false, true, "", "[""larochelle""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Saint-George Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_stgeorge}; }, [], 15, false, true, "", "[""stgeorge""] call dingus_fnc_canTuneAtis"];
player addAction [["Tune to Tuvanaka Approach ATIS"] call dingus_fnc_formatActionLabel, { [] spawn {[] call dingus_fnc_atis_tuvanaka}; }, [], 15, false, true, "", "[""tuvanaka""] call dingus_fnc_canTuneAtis"];

dingus_fnc_atis_SayAirport = {
  params ["_airport"];

  switch (_airport) do {
    case "abdera": { [] call dingus_fnc_atis_say_abdera; };
    case "altis": { [] call dingus_fnc_atis_say_altis; };
    case "almyra": { [] call dingus_fnc_atis_say_almyra; };
    case "aac": { [] call dingus_fnc_atis_say_aac; };
    case "molos": { [] call dingus_fnc_atis_say_molos; };
    case "selakano": { [] call dingus_fnc_atis_say_selakano; };
    case "tanoa": { [] call dingus_fnc_atis_say_tanoa; };
    case "tuvanaka": { [] call dingus_fnc_atis_say_tuvanaka; };
    case "baja": { [] call dingus_fnc_atis_say_baja; };
    case "stgeorge";
    case "saintgeorge";
    case "saint_george": { [] call dingus_fnc_atis_say_saint_george; };
    case "larochelle";
    case "la_rochelle": { [] call dingus_fnc_atis_say_la_rochelle; };
    // default { systemChat format ["Bad airport code: %1.", _airport] };
  };
};

allVersions = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "gulf", "hotel", "india", "juliet", "kilo", "lima", "mike", "november", "oscar", "papa", "quebec", "romeo", "sierra", "tango", "uniform", "victor", "whiskey", "xray", "yankee", "zulu"];

dingus_fnc_atis_wrapper = {
  params ["_adjustmentFactor", "_name", "_runway", "_runway2"];
  _index = (floor daytime) + _adjustmentFactor;
  if (_index >= count allVersions) then {
    _index = _index - count allVersions;
  };
  _version = allVersions select _index;
  //systemChat format ["%1 / %2", _name, _version];
  [_version, _name, _runway, _runway2] spawn {params["_version", "_name", "_runway", "_runway2"]; [_name, _runway, _runway2, _version] call dingus_fnc_DyanmicATIS};
};

dingus_fnc_canTuneAtis = {
  params ["_code"];
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _ret = (_atAirport) && (vehicle player != player);
  _ret;
};

//[] spawn {["altis", ["0", "4", "R"], ["2", "2", "R"], "bravo"] call dingus_fnc_DyanmicATIS};
//[] spawn {["selakano", [0, 1], [1, 9], "delta"] call dingus_fnc_DyanmicATIS};
dingus_fnc_DyanmicATIS = {
  params ["_airport", "_runway", "_runway2", "_version"];

  // here's the template we want to use...
  //This is [airport] arrival information [version].
  [] call dingus_fnc_atis_say_this_is;
  [_airport] call dingus_fnc_atis_SayAirport;
  [] call dingus_fnc_atis_say_arrival;
  [] call dingus_fnc_atis_say_information;
  [_version] call dingus_fnc_atis_SayPhoenetic;

  sleep 0.5;
  // Main landing runway [runway].
  [] call dingus_fnc_atis_say_main_landing_runway;
  [_runway] call dingus_fnc_atis_SayRunway;

  sleep 0.2;

  //Departures (same)
  [] call dingus_fnc_atis_say_departures;
  [_runway] call dingus_fnc_atis_SayRunway;

  sleep 0.5;

  // Winds: Zero-Zero degrees, Zero-One knots.
  [] call dingus_fnc_atis_say_winds;

  [] call dingus_fnc_atis_SayWinds;

  sleep 0.5;

  // Clouds: Scattered: Five Five Zero meters. Broken: Eight Zero Zero meters.
  ["conditions"] call dingus_fnc_atis_SayPhoenetic;

  if (overcast < 0.25) then {
    //FEW
    [] call dingus_fnc_atis_say_few;
  };

  if (overcast >= 0.25 && overcast < 0.5) then {
    //Scattered
    [] call dingus_fnc_atis_say_scattered;
  };

  if (overcast >= 0.5 && overcast < 0.75) then {
    //Broken
    [] call dingus_fnc_atis_say_broken;
  };

  if (overcast >= 0.75) then {
    //Overcast
    [] call dingus_fnc_atis_say_overcast;
  };

  sleep 0.2;

  //Ceiling
  [] call dingus_fnc_atis_say_one;
  [] call dingus_fnc_atis_say_kilometer;

  if (rain > 0.1) then {
    sleep 0.2;
    [] call dingus_fnc_atis_say_cumulonimbus_detected;
  };

  // Visibility: Zero One.
  [] call dingus_fnc_atis_say_visibility;

  if (rain > 0.1) then {
    [] call dingus_fnc_atis_say_zero;
    [] call dingus_fnc_atis_say_two;
  } else {
    if (fog > 0.1) then {
      [] call dingus_fnc_atis_say_zero;
      [] call dingus_fnc_atis_say_one;
    } else {
      [] call dingus_fnc_atis_say_zero;
      [] call dingus_fnc_atis_say_eight;
    };
  };
  [] call dingus_fnc_atis_say_kilometers;
  
  sleep 0.5;


  // Forecast: No significant change / Rain Expected / Winds expected
  //

  // Comms Rules: Contact Approach and Arrival callsign only.
  //

  sleep 0.5;

  // End of information [version].
  [] call dingus_fnc_atis_say_end;
  [] call dingus_fnc_atis_say_of;
  [] call dingus_fnc_atis_say_information;

  [_version] call dingus_fnc_atis_SayPhoenetic;
};

dingus_fnc_atis_SayRunway = {
  params ["_runway"];

  { [_x] call dingus_fnc_atis_say_singleDigit } forEach _runway;
};

dingus_fnc_atis_say_singleDigit = {
  params ["_digit"];

  switch (_digit) do {
    case "0": { [] call dingus_fnc_atis_say_zero; };
    case "1": { [] call dingus_fnc_atis_say_one; };
    case "2": { [] call dingus_fnc_atis_say_two; };
    case "3": { [] call dingus_fnc_atis_say_three; };
    case "4": { [] call dingus_fnc_atis_say_four; };
    case "5": { [] call dingus_fnc_atis_say_five; };
    case "6": { [] call dingus_fnc_atis_say_six; };
    case "7": { [] call dingus_fnc_atis_say_seven; };
    case "8": { [] call dingus_fnc_atis_say_eight; };
    case "9": { [] call dingus_fnc_atis_say_niner; };
    case "r": { [] call dingus_fnc_atis_say_right; };
    case "l": { [] call dingus_fnc_atis_say_left; };
  };
};

dingus_fnc_atis_SayNumber = {
  params ["_number"];

  // systemChat format ["%1", _number];

  _str = format ["%1", floor(_number)];

  if (_str == "niner") then {
    _str = "nine";
  };

  _ary = toArray _str;

  // Zero pad
  if (count _ary == 1) then {
    _ary = [48, 48] + _ary;
  };

  // Zero pad
  if (count _ary == 2) then {
    _ary = [48] + _ary;
  };

  { [_x] call dingus_fnc_SayCharacter; } forEach _ary;
};

dingus_fnc_SayCharacter = {
  params ["_char"];

  // systemChat format ['saying %1', _char];

  switch (_char) do {
    case 48: { [] call dingus_fnc_atis_say_zero; };
    case 49: { [] call dingus_fnc_atis_say_one; };
    case 50: { [] call dingus_fnc_atis_say_two; };
    case 51: { [] call dingus_fnc_atis_say_three; };
    case 52: { [] call dingus_fnc_atis_say_four; };
    case 53: { [] call dingus_fnc_atis_say_five; };
    case 54: { [] call dingus_fnc_atis_say_six; };
    case 55: { [] call dingus_fnc_atis_say_seven; };
    case 56: { [] call dingus_fnc_atis_say_eight; };
    case 57: { [] call dingus_fnc_atis_say_niner; };

    case 76: { [] call dingus_fnc_atis_say_left; };
    case 82: { [] call dingus_fnc_atis_say_right; };
    default { systemChat format ["Bad ascii code: %1.", _char] };
  };
};

// Winds: Zero-Zero degrees, Zero-One knots.
dingus_fnc_atis_SayWinds = {
  _windDir = windDir;
  _gusts = gusts;
  _windStr = windStr;

  //I don't know why I have to adjust these values
  _strengthActual = _windStr * 10;
  _gustsActual = _gusts * 100;
  _directionActual = floor (_windDir);

  //systemChat format ["%1, %2, %3", _strengthActual, _gustsActual, _directionActual];

  [_directionActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_degrees;

  sleep 0.2;

  [_strengthActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_knots;

  sleep 0.2;

  [] call dingus_fnc_atis_say_gusts;
  [_gustsActual] call dingus_fnc_atis_SayNumber;
  [] call dingus_fnc_atis_say_knots;  
};

// Generated

dingus_fnc_atis_SayPhoenetic = {
  params ["_pho"];

  switch (_pho) do {
    case "no": { [] call dingus_fnc_atis_say_no; };
    case "and": { [] call dingus_fnc_atis_say_and; };
    case "to": { [] call dingus_fnc_atis_say_to; };
    case "for": { [] call dingus_fnc_atis_say_for; };
    case "on": { [] call dingus_fnc_atis_say_on; };
    case "only": { [] call dingus_fnc_atis_say_only; };
    case "runway": { [] call dingus_fnc_atis_say_runway; };
    case "kilometer": { [] call dingus_fnc_atis_say_kilometer; };
    case "kilometers": { [] call dingus_fnc_atis_say_kilometers; };
    case "meter": { [] call dingus_fnc_atis_say_meter; };
    case "meters": { [] call dingus_fnc_atis_say_meters; };
    case "knot": { [] call dingus_fnc_atis_say_knot; };
    case "knots": { [] call dingus_fnc_atis_say_knots; };
    case "degree": { [] call dingus_fnc_atis_say_degree; };
    case "degrees": { [] call dingus_fnc_atis_say_degrees; };
    case "flight_level": { [] call dingus_fnc_atis_say_flight_level; };
    case "descend": { [] call dingus_fnc_atis_say_descend; };
    case "ascend": { [] call dingus_fnc_atis_say_ascend; };
    case "approach": { [] call dingus_fnc_atis_say_approach; };
    case "ground": { [] call dingus_fnc_atis_say_ground; };
    case "tower": { [] call dingus_fnc_atis_say_tower; };
    case "taxi": { [] call dingus_fnc_atis_say_taxi; };
    case "taxi_and_hold_short": { [] call dingus_fnc_atis_say_taxi_and_hold_short; };
    case "hold_short": { [] call dingus_fnc_atis_say_hold_short; };
    case "request": { [] call dingus_fnc_atis_say_request; };
    case "traffic": { [] call dingus_fnc_atis_say_traffic; };
    case "visual": { [] call dingus_fnc_atis_say_visual; };
    case "visibility": { [] call dingus_fnc_atis_say_visibility; };
    case "cleared": { [] call dingus_fnc_atis_say_cleared; };
    case "takeoff": { [] call dingus_fnc_atis_say_takeoff; };
    case "landing": { [] call dingus_fnc_atis_say_landing; };
    case "callsign": { [] call dingus_fnc_atis_say_callsign; };
    case "conditions": { [] call dingus_fnc_atis_say_conditions; };
    case "broken": { [] call dingus_fnc_atis_say_broken; };
    case "scattered": { [] call dingus_fnc_atis_say_scattered; };
    case "cumulonimbus_detected": { [] call dingus_fnc_atis_say_cumulonimbus_detected; };
    case "direct": { [] call dingus_fnc_atis_say_direct; };
    case "immediate": { [] call dingus_fnc_atis_say_immediate; };
    case "departure": { [] call dingus_fnc_atis_say_departure; };
    case "immediate_departure": { [] call dingus_fnc_atis_say_immediate_departure; };
    case "turn": { [] call dingus_fnc_atis_say_turn; };
    case "turn_to": { [] call dingus_fnc_atis_say_turn_to; };
    case "this_is": { [] call dingus_fnc_atis_say_this_is; };
    case "information": { [] call dingus_fnc_atis_say_information; };
    case "main_landing_runway": { [] call dingus_fnc_atis_say_main_landing_runway; };
    case "altis": { [] call dingus_fnc_atis_say_altis; };
    case "abdera": { [] call dingus_fnc_atis_say_abdera; };
    case "almyra": { [] call dingus_fnc_atis_say_almyra; };
    case "aac": { [] call dingus_fnc_atis_say_aac; };
    case "molos": { [] call dingus_fnc_atis_say_molos; };
    case "selakano": { [] call dingus_fnc_atis_say_selakano; };
    case "tanoa": { [] call dingus_fnc_atis_say_tanoa; };
    case "la_rochelle": { [] call dingus_fnc_atis_say_la_rochelle; };
    case "baja": { [] call dingus_fnc_atis_say_baja; };
    case "saint_george": { [] call dingus_fnc_atis_say_saint_george; };
    case "tuvanaka": { [] call dingus_fnc_atis_say_tuvanaka; };
    case "zero": { [] call dingus_fnc_atis_say_zero; };
    case "one": { [] call dingus_fnc_atis_say_one; };
    case "two": { [] call dingus_fnc_atis_say_two; };
    case "three": { [] call dingus_fnc_atis_say_three; };
    case "four": { [] call dingus_fnc_atis_say_four; };
    case "five": { [] call dingus_fnc_atis_say_five; };
    case "six": { [] call dingus_fnc_atis_say_six; };
    case "seven": { [] call dingus_fnc_atis_say_seven; };
    case "eight": { [] call dingus_fnc_atis_say_eight; };
    case "niner": { [] call dingus_fnc_atis_say_niner; };
    case "alpha": { [] call dingus_fnc_atis_say_alpha; };
    case "bravo": { [] call dingus_fnc_atis_say_bravo; };
    case "charlie": { [] call dingus_fnc_atis_say_charlie; };
    case "delta": { [] call dingus_fnc_atis_say_delta; };
    case "echo": { [] call dingus_fnc_atis_say_echo; };
    case "foxtrot": { [] call dingus_fnc_atis_say_foxtrot; };
    case "gulf": { [] call dingus_fnc_atis_say_gulf; };
    case "hotel": { [] call dingus_fnc_atis_say_hotel; };
    case "india": { [] call dingus_fnc_atis_say_india; };
    case "juliet": { [] call dingus_fnc_atis_say_juliet; };
    case "kilo": { [] call dingus_fnc_atis_say_kilo; };
    case "lima": { [] call dingus_fnc_atis_say_lima; };
    case "mike": { [] call dingus_fnc_atis_say_mike; };
    case "november": { [] call dingus_fnc_atis_say_november; };
    case "oscar": { [] call dingus_fnc_atis_say_oscar; };
    case "papa": { [] call dingus_fnc_atis_say_papa; };
    case "quebec": { [] call dingus_fnc_atis_say_quebec; };
    case "romeo": { [] call dingus_fnc_atis_say_romeo; };
    case "sierra": { [] call dingus_fnc_atis_say_sierra; };
    case "tango": { [] call dingus_fnc_atis_say_tango; };
    case "uniform": { [] call dingus_fnc_atis_say_uniform; };
    case "victor": { [] call dingus_fnc_atis_say_victor; };
    case "whiskey": { [] call dingus_fnc_atis_say_whiskey; };
    case "xray": { [] call dingus_fnc_atis_say_x_ray; };
    case "yankee": { [] call dingus_fnc_atis_say_yankee; };
    case "zulu": { [] call dingus_fnc_atis_say_zulu; };
    case "heavy": { [] call dingus_fnc_atis_say_heavy; };
    case "rain": { [] call dingus_fnc_atis_say_rain; };
    case "caesar": { [] call dingus_fnc_atis_say_caesar; };
    case "active": { [] call dingus_fnc_atis_say_active; };
    case "departures": { [] call dingus_fnc_atis_say_departures; };
    case "use": { [] call dingus_fnc_atis_say_use; };
    case "malden": { [] call dingus_fnc_atis_say_malden; };
    case "pegasus": { [] call dingus_fnc_atis_say_pegasus; };
    case "wind": { [] call dingus_fnc_atis_say_wind; };
    case "winds": { [] call dingus_fnc_atis_say_winds; };
    case "are": { [] call dingus_fnc_atis_say_are; };
    case "out": { [] call dingus_fnc_atis_say_out; };
    case "of": { [] call dingus_fnc_atis_say_of; };
    case "end": { [] call dingus_fnc_atis_say_end; };
    case "the": { [] call dingus_fnc_atis_say_the; };
    case "arrival": { [] call dingus_fnc_atis_say_arrival; };
    case "gusts": { [] call dingus_fnc_atis_say_gusts; };
    case "left": { [] call dingus_fnc_atis_say_left; };
    case "right": { [] call dingus_fnc_atis_say_right; };
    case "change": { [] call dingus_fnc_atis_say_change; };
    case "expected": { [] call dingus_fnc_atis_say_expected; };
    case "overcast": { [] call dingus_fnc_atis_say_overcast; };
    case "few": { [] call dingus_fnc_atis_say_few; };
    case "lighting": { [] call dingus_fnc_atis_say_lighting; };
    case "initial": { [] call dingus_fnc_atis_say_initial; };
    case "advise": { [] call dingus_fnc_atis_say_advise; };
    case "controller": { [] call dingus_fnc_atis_say_controller; };
    case "upon": { [] call dingus_fnc_atis_say_upon; };
    case "make": { [] call dingus_fnc_atis_say_make; };
    case "straight_in": { [] call dingus_fnc_atis_say_straight_in; };
    case "contact": { [] call dingus_fnc_atis_say_contact; };
    case "final": { [] call dingus_fnc_atis_say_final; };

    default { systemChat format ["Bad phoenetic code: %1.", _pho] };
  };
};

dingus_fnc_atis_say_no = { playSound ["AtisVO_no", true]; sleep 0.4; };
dingus_fnc_atis_say_and = { playSound ["AtisVO_and", true]; sleep 0.4; };
dingus_fnc_atis_say_to = { playSound ["AtisVO_to", true]; sleep 0.3; };
dingus_fnc_atis_say_for = { playSound ["AtisVO_for", true]; sleep 0.5; };
dingus_fnc_atis_say_on = { playSound ["AtisVO_on", true]; sleep 0.5; };
dingus_fnc_atis_say_only = { playSound ["AtisVO_only", true]; sleep 0.5; };
dingus_fnc_atis_say_runway = { playSound ["AtisVO_runway", true]; sleep 0.6; };
dingus_fnc_atis_say_kilometer = { playSound ["AtisVO_kilometer", true]; sleep 0.7; };
dingus_fnc_atis_say_kilometers = { playSound ["AtisVO_kilometers", true]; sleep 0.8; };
dingus_fnc_atis_say_meter = { playSound ["AtisVO_meter", true]; sleep 0.4; };
dingus_fnc_atis_say_meters = { playSound ["AtisVO_meters", true]; sleep 0.5; };
dingus_fnc_atis_say_knot = { playSound ["AtisVO_knot", true]; sleep 0.4; };
dingus_fnc_atis_say_knots = { playSound ["AtisVO_knots", true]; sleep 0.5; };
dingus_fnc_atis_say_degree = { playSound ["AtisVO_degree", true]; sleep 0.5; };
dingus_fnc_atis_say_degrees = { playSound ["AtisVO_degrees", true]; sleep 0.6; };
dingus_fnc_atis_say_flight_level = { playSound ["AtisVO_flight_level", true]; sleep 0.8; };
dingus_fnc_atis_say_descend = { playSound ["AtisVO_descend", true]; sleep 0.6; };
dingus_fnc_atis_say_ascend = { playSound ["AtisVO_ascend", true]; sleep 0.6; };
dingus_fnc_atis_say_approach = { playSound ["AtisVO_approach", true]; sleep 0.6; };
dingus_fnc_atis_say_ground = { playSound ["AtisVO_ground", true]; sleep 0.4; };
dingus_fnc_atis_say_tower = { playSound ["AtisVO_tower", true]; sleep 0.5; };
dingus_fnc_atis_say_taxi = { playSound ["AtisVO_taxi", true]; sleep 0.5; };
dingus_fnc_atis_say_taxi_and_hold_short = { playSound ["AtisVO_taxi_and_hold_short", true]; sleep 1.3; };
dingus_fnc_atis_say_hold_short = { playSound ["AtisVO_hold_short", true]; sleep 0.75; };
dingus_fnc_atis_say_request = { playSound ["AtisVO_request", true]; sleep 0.6; };
dingus_fnc_atis_say_traffic = { playSound ["AtisVO_traffic", true]; sleep 0.6; };
dingus_fnc_atis_say_visual = { playSound ["AtisVO_visual", true]; sleep 0.6; };
dingus_fnc_atis_say_visibility = { playSound ["AtisVO_visibility", true]; sleep 0.7; };
dingus_fnc_atis_say_cleared = { playSound ["AtisVO_cleared", true]; sleep 0.5; };
dingus_fnc_atis_say_takeoff = { playSound ["AtisVO_takeoff", true]; sleep 0.7; };
dingus_fnc_atis_say_landing = { playSound ["AtisVO_landing", true]; sleep 0.6; };
dingus_fnc_atis_say_callsign = { playSound ["AtisVO_callsign", true]; sleep 0.8; };
dingus_fnc_atis_say_conditions = { playSound ["AtisVO_conditions", true]; sleep 0.7; };
dingus_fnc_atis_say_broken = { playSound ["AtisVO_broken", true]; sleep 0.5; };
dingus_fnc_atis_say_scattered = { playSound ["AtisVO_scattered", true]; sleep 0.6; };
dingus_fnc_atis_say_cumulonimbus_detected = { playSound ["AtisVO_cumulonimbus_detected", true]; sleep 1.3; };
dingus_fnc_atis_say_direct = { playSound ["AtisVO_direct", true]; sleep 0.6; };
dingus_fnc_atis_say_immediate = { playSound ["AtisVO_immediate", true]; sleep 0.6; };
dingus_fnc_atis_say_departure = { playSound ["AtisVO_departure", true]; sleep 0.6; };
dingus_fnc_atis_say_immediate_departure = { playSound ["AtisVO_immediate_departure", true]; sleep 0.9; };
dingus_fnc_atis_say_turn = { playSound ["AtisVO_turn", true]; sleep 0.4; };
dingus_fnc_atis_say_turn_to = { playSound ["AtisVO_turn_to", true]; sleep 0.6; };
dingus_fnc_atis_say_this_is = { playSound ["AtisVO_this_is", true]; sleep 0.4; };
dingus_fnc_atis_say_information = { playSound ["AtisVO_information", true]; sleep 0.8; };
dingus_fnc_atis_say_main_landing_runway = { playSound ["AtisVO_main_landing_runway", true]; sleep 1.2; };
dingus_fnc_atis_say_altis = { playSound ["AtisVO_altis", true]; sleep 0.7; };
dingus_fnc_atis_say_abdera = { playSound ["AtisVO_abdera", true]; sleep 0.7; };
dingus_fnc_atis_say_almyra = { playSound ["AtisVO_almyra", true]; sleep 0.7; };
dingus_fnc_atis_say_aac = { playSound ["AtisVO_aac", true]; sleep 0.8; };
dingus_fnc_atis_say_molos = { playSound ["AtisVO_molos", true]; sleep 0.75; };
dingus_fnc_atis_say_selakano = { playSound ["AtisVO_selakano", true]; sleep 0.9; };
dingus_fnc_atis_say_tanoa = { playSound ["AtisVO_tanoa", true]; sleep 0.7; };
dingus_fnc_atis_say_la_rochelle = { playSound ["AtisVO_la_rochelle", true]; sleep 0.85; };
dingus_fnc_atis_say_baja = { playSound ["AtisVO_baja", true]; sleep 0.7; };
dingus_fnc_atis_say_saint_george = { playSound ["AtisVO_saint_george", true]; sleep 1; };
dingus_fnc_atis_say_tuvanaka = { playSound ["AtisVO_tuvanaka", true]; sleep 0.8; };
dingus_fnc_atis_say_zero = { playSound ["AtisVO_zero", true]; sleep 0.6; };
dingus_fnc_atis_say_one = { playSound ["AtisVO_one", true]; sleep 0.4; };
dingus_fnc_atis_say_two = { playSound ["AtisVO_two", true]; sleep 0.4; };
dingus_fnc_atis_say_three = { playSound ["AtisVO_three", true]; sleep 0.4; };
dingus_fnc_atis_say_four = { playSound ["AtisVO_four", true]; sleep 0.4; };
dingus_fnc_atis_say_five = { playSound ["AtisVO_five", true]; sleep 0.5; };
dingus_fnc_atis_say_six = { playSound ["AtisVO_six", true]; sleep 0.5; };
dingus_fnc_atis_say_seven = { playSound ["AtisVO_seven", true]; sleep 0.55; };
dingus_fnc_atis_say_eight = { playSound ["AtisVO_eight", true]; sleep 0.4; };
dingus_fnc_atis_say_niner = { playSound ["AtisVO_niner", true]; sleep 0.5; };
dingus_fnc_atis_say_alpha = { playSound ["AtisVO_alpha", true]; sleep 0.5; };
dingus_fnc_atis_say_bravo = { playSound ["AtisVO_bravo", true]; sleep 0.5; };
dingus_fnc_atis_say_charlie = { playSound ["AtisVO_charlie", true]; sleep 0.5; };
dingus_fnc_atis_say_delta = { playSound ["AtisVO_delta", true]; sleep 0.7; };
dingus_fnc_atis_say_echo = { playSound ["AtisVO_echo", true]; sleep 0.5; };
dingus_fnc_atis_say_foxtrot = { playSound ["AtisVO_foxtrot", true]; sleep 0.8; };
dingus_fnc_atis_say_gulf = { playSound ["AtisVO_gulf", true]; sleep 0.4; };
dingus_fnc_atis_say_hotel = { playSound ["AtisVO_hotel", true]; sleep 0.65; };
dingus_fnc_atis_say_india = { playSound ["AtisVO_india", true]; sleep 0.5; };
dingus_fnc_atis_say_juliet = { playSound ["AtisVO_juliet", true]; sleep 0.5; };
dingus_fnc_atis_say_kilo = { playSound ["AtisVO_kilo", true]; sleep 0.5; };
dingus_fnc_atis_say_lima = { playSound ["AtisVO_lima", true]; sleep 0.5; };
dingus_fnc_atis_say_mike = { playSound ["AtisVO_mike", true]; sleep 0.5; };
dingus_fnc_atis_say_november = { playSound ["AtisVO_november", true]; sleep 0.6; };
dingus_fnc_atis_say_oscar = { playSound ["AtisVO_oscar", true]; sleep 0.5; };
dingus_fnc_atis_say_papa = { playSound ["AtisVO_papa", true]; sleep 0.4; };
dingus_fnc_atis_say_quebec = { playSound ["AtisVO_quebec", true]; sleep 0.5; };
dingus_fnc_atis_say_romeo = { playSound ["AtisVO_romeo", true]; sleep 0.6; };
dingus_fnc_atis_say_sierra = { playSound ["AtisVO_sierra", true]; sleep 0.5; };
dingus_fnc_atis_say_tango = { playSound ["AtisVO_tango", true]; sleep 0.5; };
dingus_fnc_atis_say_uniform = { playSound ["AtisVO_uniform", true]; sleep 0.6; };
dingus_fnc_atis_say_victor = { playSound ["AtisVO_victor", true]; sleep 0.4; };
dingus_fnc_atis_say_whiskey = { playSound ["AtisVO_whiskey", true]; sleep 0.5; };
dingus_fnc_atis_say_x_ray = { playSound ["AtisVO_xray", true]; sleep 0.5; };
dingus_fnc_atis_say_yankee = { playSound ["AtisVO_yankee", true]; sleep 0.5; };
dingus_fnc_atis_say_zulu = { playSound ["AtisVO_zulu", true]; sleep 0.4; };
dingus_fnc_atis_say_heavy = { playSound ["AtisVO_heavy", true]; sleep 0.5; };
dingus_fnc_atis_say_rain = { playSound ["AtisVO_rain", true]; sleep 0.5; };
dingus_fnc_atis_say_caesar = { playSound ["AtisVO_caesar", true]; sleep 0.5; };
dingus_fnc_atis_say_active = { playSound ["AtisVO_active", true]; sleep 0.4; };
dingus_fnc_atis_say_departures = { playSound ["AtisVO_departures", true]; sleep 0.6; };
dingus_fnc_atis_say_use = { playSound ["AtisVO_use", true]; sleep 0.4; };
dingus_fnc_atis_say_malden = { playSound ["AtisVO_malden", true]; sleep 0.4; };
dingus_fnc_atis_say_pegasus = { playSound ["AtisVO_pegasus", true]; sleep 0.65; };
dingus_fnc_atis_say_wind = { playSound ["AtisVO_wind", true]; sleep 0.4; };
dingus_fnc_atis_say_winds = { playSound ["AtisVO_winds", true]; sleep 0.5; };
dingus_fnc_atis_say_are = { playSound ["AtisVO_are", true]; sleep 0.4; };
dingus_fnc_atis_say_out = { playSound ["AtisVO_out", true]; sleep 0.3; };
dingus_fnc_atis_say_of = { playSound ["AtisVO_of", true]; sleep 0.3; };
dingus_fnc_atis_say_end = { playSound ["AtisVO_end", true]; sleep 0.4; };
dingus_fnc_atis_say_the = { playSound ["AtisVO_the", true]; sleep 0.3; };
dingus_fnc_atis_say_arrival = { playSound ["AtisVO_arrival", true]; sleep 0.6; };
dingus_fnc_atis_say_gusts = { playSound ["AtisVO_gusts", true]; sleep 0.7; };
dingus_fnc_atis_say_left = { playSound ["AtisVO_left", true]; sleep 0.4; };
dingus_fnc_atis_say_right = { playSound ["AtisVO_right", true]; sleep 0.3; };
dingus_fnc_atis_say_change = { playSound ["AtisVO_change", true]; sleep 0.7; };
dingus_fnc_atis_say_expected = { playSound ["AtisVO_expected", true]; sleep 0.7; };
dingus_fnc_atis_say_overcast = { playSound ["AtisVO_overcast", true]; sleep 0.75; };
dingus_fnc_atis_say_few = { playSound ["AtisVO_few", true]; sleep 0.7; };
dingus_fnc_atis_say_lighting = { playSound ["AtisVO_lighting", true]; sleep 0.6; };
dingus_fnc_atis_say_initial = { playSound ["AtisVO_initial", true]; sleep 0.6; };
dingus_fnc_atis_say_advise = { playSound ["AtisVO_advise", true]; sleep 0.7; };
dingus_fnc_atis_say_controller = { playSound ["AtisVO_controller", true]; sleep 0.7; };
dingus_fnc_atis_say_upon = { playSound ["AtisVO_upon", true]; sleep 0.5; };
dingus_fnc_atis_say_make = { playSound ["AtisVO_make", true]; sleep 0.3; };
dingus_fnc_atis_say_straight_in = { playSound ["AtisVO_straight_in", true]; sleep 0.7; };
dingus_fnc_atis_say_contact = { playSound ["AtisVO_contact", true]; sleep 0.7; };
dingus_fnc_atis_say_final = { playSound ["AtisVO_final", true]; sleep 0.6; };