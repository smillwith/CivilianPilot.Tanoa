/*
ATIS

https://en.wikipedia.org/wiki/Automatic_terminal_information_service


We've got 5 airports - 4 of them probably have it

Sample:

This is [Tan-oh-uh] arrival information Alpha.
Main landing runways One Seven and Three Five. 
Two Zero Zero degrees, Seven knots.
Visibility One Zero kilometres.
Scattered: Five Five Zero meters. Broken: Eight Zero Zero meters.
No significant change.
Contact Approach and Arrival callsign only.
End of information Alpha.

//Vars:

//Airport
"Tan-oh-uh", "Saint-George", "La Rochelle", "Tuvanaka", "Baja"

//Runways


//Wind (dir, speed)
//Easy

//Visibility (calculated?)
//Are there clouds? Is it raining? Is it foggy?


//Clouds (calculated)
"Scattered: Five Five Zero meters. Broken: Eight Zero Zero meters."
Clear? Ceiling?
"Cumulonimbus detected."

if (overcast < 1) then {
  //Lightly scattered: Eight Zero Zero Meters
}


}

//Forecast

Thoughts: Most of this is pretty easy. Except that in order to 'stich' all of this together, we might have issues.
I'm not sure if I should pre stitch the messages together or not

If arma can play things seamlessly then we might be ok.

Anyway, we can calculate active runway if we want. Or make it random.

----

How 'live' do we make it?

I would LOVE to make it as dynamic as possible.

You tune in at any point and hear the most current information



*/

dingus_fnc_canTuneAtisTanoa = {
  _ret = (triggerActivated tOverTanoaAirspace) && (vehicle player != player);
  _ret;
};

dingus_fnc_canTuneStGeorgeTanoa = {
  _ret = (triggerActivated tOverStGeorgeAirspace) && (vehicle player != player);
  _ret;
};

player addAction [["Tune to Tanoa Approach ATIS"] call dingus_fnc_formatActionLabel, { atc_tanoa1 sideRadio "AtisTest4"; }, [], 15, false, true, "", "([] call dingus_fnc_canTuneAtisTanoa);"];
player addAction [["Tune to Saint-George Approach ATIS"] call dingus_fnc_formatActionLabel, { atc_tanoa1 sideRadio "AtisTestStGeorge"; }, [], 16, false, true, "", "([] call dingus_fnc_canTuneStGeorgeTanoa);"];
