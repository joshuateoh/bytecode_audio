function n = audio_killAllLines()
// Kills all audio lines in Scilab
//
// Syntax
//    n = audio_killAllLines()
//     
//
// Parameters
//     n : Double. Number of audio lines killed.
//
// Description
//     This function kills all audio lines in Scilab and return the number of lines killed. 
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    mixerlist = audio_getActiveMixers()
//    n = audio_killAllLines()
//    mixerlist = audio_getActiveMixers()
//
// See also
//    audio_getLine
//    audio_killLine
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    jimport com.bytecode_asia.AudioCaptureV4
    n = AudioCaptureV4.killAllLines()
    
    jautoUnwrap(bool);
endfunction
