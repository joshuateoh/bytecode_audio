function y = audio_getMixers()
// Obtain a list of available mixers
//
// Syntax
//    y = audio_getMixers()
//
// Parameters
//     y : A string array of the available mixers
//
// Description
//     This function returns a array of mixers that are available. Each mixer has a ID which can be used to select that particular mixer. Do note that a mixer's ID is not fixed and will change when devices are added or removed. 
//
// Examples
//    y = audio_getMixers();
//    disp(y)
//    
//
// See also
//    audio_checkMixer
//    audio_getActiveMixers
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);

    jimport com.bytecode_asia.AudioCaptureV4
    y = AudioCaptureV4.listMixers()';
    
    jautoUnwrap(bool);
endfunction
