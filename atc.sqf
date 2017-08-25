
/*
Note about: ATCMode player variable

This also gets updated via triggers

Arrived at location: sets it to "" (landed / default)
Departed location sets it to "flying"
*/

dingus_fnc_atc_init = {
  baja_airspace_trigger = ["m_airport_baja"] call dingus_fnc_atc_createAirspaceTrigger;
  larochelle_airspace_trigger = ["m_airport_larochelle"] call dingus_fnc_atc_createAirspaceTrigger;
  stgeorge_airspace_trigger = ["m_airport_stgeorge"] call dingus_fnc_atc_createAirspaceTrigger;
  tanoa_airspace_trigger = ["m_airport_tanoa"] call dingus_fnc_atc_createAirspaceTrigger;
  tuvanaka_airspace_trigger = ["m_airport_tuvanaka"] call dingus_fnc_atc_createAirspaceTrigger;
};

dingus_fnc_atc_createAirspaceTrigger = {
  params ["_marker"];

  //systemChat format ["%1 %2", _marker, getMarkerPos _marker];

  _tr = createTrigger ["EmptyDetector", getMarkerPos _marker];
  _tr setTriggerArea [5000, 5000, 0, false, 0];
  _tr setTriggerActivation ["ANY", "PRESENT", true];
  _tr;
};

dingus_fnc_isPlayerOverAirspace = {
  params ["_code"];
  thelist = [];

  switch (_code) do {
    case "baja": {thelist = (list baja_airspace_trigger)};
    case "larochelle": {thelist = (list larochelle_airspace_trigger)};
    case "stgeorge": {thelist = (list stgeorge_airspace_trigger)};
    case "tanoa": {thelist = (list tanoa_airspace_trigger)};
    case "tuvanaka": {thelist = (list tuvanaka_airspace_trigger)};
    case "default": {systemChat format ["no list for code %1", _code]}
  };

  _exists = false;

  if (!isNil "thelist") then {
    {
      if (isPlayer _x) then {
        _exists = true;
      };

    } forEach thelist;
  } else {
    //systemChat 'list is null'
  };

  _exists;
};

// ------------------------------------------------------
//  Conditions
// ------------------------------------------------------

//Current Airport = Altis, In Vehicle, State = (none), ground level, or simply at apron?
dingus_fnc_canRequestGround = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  //TODO: Determine if we are in a plane and on the ground and at the airport
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "") && !_isTalking;
  _ret;
};

//At airport, in vehicle, state = pretaxi
dingus_fnc_canReadback1 = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "pretaxi") && !_isTalking;
  _ret;
};

//At airport, arrived at the hold short destination, in a plane, in the 'taxi' State
dingus_fnc_canRequestClearance = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "taxi") && !_isTalking;
  _ret;
};

//In airspace, state = flying, in vehicle
dingus_fnc_canRequestApproach = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "flying") && !_isTalking;
  _ret;
};

//In airspace, state = preapproach, in vehicle
dingus_fnc_canReadback2 = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "preapproach") && !_isTalking;
  _ret;
};

//In airspace, state = approach, in vehicle
dingus_fnc_canDeclareFinal = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _state = player getVariable ["ATCMode", ""];
  _ret = (_atAirport) && (vehicle player != player) && (_state == "approach") && !_isTalking;
  _ret;
};

//pretaxi
dingus_fnc_canRepeat = {
  params ["_code"];
  _isTalking = (player getVariable ["ATCTalking", "0"] == "1");
  _atAirport = [_code] call dingus_fnc_isPlayerOverAirspace;
  _words = player getVariable ["ATCLast", []];
  _ret = (_atAirport) && (vehicle player != player) && (count _words > 0) && !_isTalking;
  _ret;
};

// ------------------------------------------------------
//  Actions
// ------------------------------------------------------

// Is talking variable?

dingus_fnc_atc_say = {
  params ["_words"];
  //Stuff this in the variable
  player setVariable ["ATCLast", _words];

  [_words] call dingus_fnc_atis_say_words;
};

dingus_fnc_atc_requestDeparture = {
  params ["_code", "_runway"];

  player setVariable ["ATCTalking", "1"];

  //First, do the pilot
  playSound [format["ATC_departure_%1_alpha", _code], true]; sleep 8.2;

  //Wait
  sleep 3.0;

  // Caesar One Five November, Tanoa Tower. Taxi and hold-short, runway One-Seven.
  // ["Caesar One Five November, Tanoa Tower. Taxi and hold-short, runway One-Seven."] call dingus_fnc_atis_say;
  _words = ["caesar", "one", "five", "november", "comma", _code, "tower", "period", "taxi_and_hold_short", "runway"];
  [_words] call dingus_fnc_atc_say;
  [_runway] call dingus_fnc_atis_SayRunway;

  sleep 8;

  player setVariable ["ATCTalking", "0"];

  //Set mode?
  player setVariable ["ATCMode", "pretaxi"];
};


dingus_fnc_atc_readback1 = {
  params ["_code"];
  
  player setVariable ["ATCTalking", "1"];
  playSound [format["ATC_readback_%1", _code], true]; sleep 8.2;
  player setVariable ["ATCMode", "taxi"];
  player setVariable ["ATCTalking", "0"];
};


dingus_fnc_atc_holdingShort = {
  params ["_code"];
  
  player setVariable ["ATCTalking", "1"];

  playSound [format["ATC_ready_%1", _code], true]; sleep 6.3;

  sleep 2.0;

  //Caesar One Five November, Tanoa Tower. Cleared for takeoff runway One-Seven. Nice flight.
  _words = ["caesar", "one", "five", "november", "comma", _code, "tower", "period", "cleared", "for", "takeoff"];
  [_words] call dingus_fnc_atc_say;

  player setVariable ["ATCMode", "holding"];
  player setVariable ["ATCTalking", "0"];
};

dingus_fnc_atc_requestApproach = {
  params ["_code", "_runway"];

  player setVariable ["ATCTalking", "1"];

  playSound [format["ATC_initial_%1", _code], true]; sleep 4.8;

  sleep 2;

  //Caesar One Five November, Tanoa Tower. Make straight in approach, runway One-Seven. Contact on final.
  _words = ["caesar", "one", "five", "november", "comma", _code, "tower", "make", "straight_in", "approach", "runway"];
  [_words] call dingus_fnc_atc_say;
  [_runway] call dingus_fnc_atis_SayRunway;
  _words2 = ["contact", "tower", "on", "final"];
  [_words2] call dingus_fnc_atc_say;

  player setVariable ["ATCMode", "preapproach"];
  player setVariable ["ATCTalking", "0"];
};

dingus_fnc_atc_readback2 = {
  params ["_code"];
  player setVariable ["ATCTalking", "1"];
  playSound [format["ATC_readbackapproach_%1", _code], true]; sleep 5.4;
  player setVariable ["ATCMode", "approach"];
  player setVariable ["ATCTalking", "0"];
};


dingus_fnc_atc_declareFinal = {
  params ["_code"];
  player setVariable ["ATCTalking", "1"];
  playSound [format["ATC_contactfinal_%1", _code], true]; sleep 5.4;
  player setVariable ["ATCMode", "landing"];
  player setVariable ["ATCTalking", "0"];
};

dingus_fnc_atc_repeat = {
  params ["_code"];
  player setVariable ["ATCTalking", "1"];
  _words = player getVariable ["ATCLast", []];
  [_words] call dingus_fnc_atis_say_words;
  player setVariable ["ATCTalking", "0"];
};

// dingus_fnc_atc_Ground1 = {
//   params ["_airport", "_runway"];
//   // Caesar One Five November, Tanoa Tower. Taxi and hold-short, runway One-Seven.
//   // ["Caesar One Five November, Tanoa Tower. Taxi and hold-short, runway One-Seven."] call dingus_fnc_atis_say;
//   _words = ["caesar", "one", "five", "november", "comma", "tanoa", "tower", "period", "taxi_and_hold_short", "runway"];
//   [_words] call dingus_fnc_atis_say_words;
//   [_runway] call dingus_fnc_atis_SayRunway;
// };

// dingus_fnc_atc_Ground3 = {
//   //Caesar One Five November, Tanoa Tower. Cleared for takeoff runway One-Seven. Nice flight.
//   _words = ["caesar", "one", "five", "november", "comma", "tanoa", "tower", "period", "taxi_and_hold_short", "runway", "one", "seven"];
// };


//Pilot simulated comms
//Tanoa Tower, Caesar Sierra Zero One Five November on apron, with information Alfa, request clearance for departure .
//Hold short runway One-Seven, Caesar One Five November.
//Tanoa tower, Caesar One Five November, holding short runway One-Seven, request departure.


//Takeoff
// player addAction [["Tanoa Tower: Request Departure"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
// player addAction [["Tanoa Tower: Say again..."] call dingus_fnc_formatActionLabelComms, { ["tanoa"] spawn {params ["_airport"]; [_airport] call dingus_fnc_GroundSayAgain}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
// player addAction [["Tanoa Tower: Acknowledge hold short"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
// player addAction [["Tanoa Tower: Holding short"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];

//Arrival
// player addAction [["Tanoa Tower: Landing with info"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
// player addAction [["Tanoa Tower: Acknowledge approach"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
// player addAction [["Tanoa Tower: On Final"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_Ground1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];

// These work just disabled for now until we can get all airports working
player addAction [["Tanoa Tower: Request departure"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_requestDeparture}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestGround"];
player addAction [["Tanoa Tower: Acknowledge hold short"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_readback1}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canReadback1"];
player addAction [["Tanoa Tower: Holding short"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_holdingShort}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestClearance"];
player addAction [["Tanoa Tower: Landing w/ info"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_requestApproach}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRequestApproach"];
player addAction [["Tanoa Tower: Acknowledge approach"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_readback2}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canReadback2"];
player addAction [["Tanoa Tower: On final"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_declareFinal}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canDeclareFinal"];
// player addAction [["Tanoa Tower: Say again, tower"] call dingus_fnc_formatActionLabelComms, { ["tanoa", ["1", "7"]] spawn {params ["_airport", "_runway"]; [_airport, _runway] call dingus_fnc_atc_repeat}; }, [], 15, false, true, "", "[""tanoa""] call dingus_fnc_canRepeat"];

dingus_fnc_atis_say_sentence = {
  params ["_sentence"];
  //  //Lower case
  //Replace some shit like commas, periods. but replace with time
  //Split by space to look like this
  //_words = ["caesar", "one", "five", "november", "comma", "this_is", "tanoa", "tower", "period", "taxi_and_hold_short", "runway", "one", "seven"];
};

dingus_fnc_atis_say_words = {
  params ["_words"];
  {
    if (_x == "comma") then {
      sleep 0.2;
    } else {
      if (_x == "period") then {
        sleep 0.5;
      } else {
        [_x] call dingus_fnc_atis_SayPhoenetic;
      };
    };
    
  } forEach _words;
};
