function res = audio_checkMixer(mixerID)
// Check the lines supported by a selected mixer.
//
// Syntax
//     res = audio_checkMixer(mixerID)
//
// Parameters
//     mixerID : Integer. Mixer ID.
//     res : String array. Status of the lines supported.
//
// Description
//     A mixer generally supports a line that connects to either the microphone or speaker. This functions determines the line that is supported by the mixer.
//
// Examples
//    disp(audio_getMixers())
//    res = audio_checkMixer(0);
//    disp(res)
//
// See also
//    audio_getMixers
//    audio_getActiveMixers
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    jimport com.bytecode_asia.AudioCaptureV4
    res =  AudioCaptureV4.checkMixer(mixerID)';
    
    jautoUnwrap(bool);
endfunction
