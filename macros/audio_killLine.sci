function audio_killLine(line)
// Kills an audio line
//
// Syntax
//    audio_killLine(line)
//     
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function kills a given audio line. 
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    mixerlist = audio_getActiveMixers()
//    audio_killLine(line)
//    mixerlist = audio_getActiveMixers()
//
// See also
//    audio_getLine
//    audio_killAllLines
//
// Authors
//     Joshua T. 
    
    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    line.killLine()
    
    jautoUnwrap(bool);
endfunction
