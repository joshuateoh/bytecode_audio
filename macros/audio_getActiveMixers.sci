function [mixerlist,nmixer]=audio_getActiveMixers()
// Obtain a list of mixers that have lines that are currently open
//
// Syntax
//    [mixerlist,nmixer]=audio_getActiveMixers()
//
// Parameters
//     mixerlist : A string array of the active mixers
//     nmixers : Double. The number of active mixers
//
// Description
//     This function returns a array of mixers with active audio lines as well as the total. 
//
// Examples
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    [mixerlist,nmixer]=audio_getActiveMixers()
//    audio_startCapture(line)
//    [mixerlist,nmixer]=audio_getActiveMixers()
//    audio_stopCapture(line)
//
// See also
//    audio_checkMixer
//    audio_getMixers
//
// Authors
//     Joshua T. 
    
    jimport com.bytecode_asia.AudioCaptureV4
    mixerlist = AudioCaptureV4.listActiveMixers()'
    nmixer = AudioCaptureV4.getActiveMixers()
    
endfunction
