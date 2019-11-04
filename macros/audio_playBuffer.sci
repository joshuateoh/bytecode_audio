function audio_playBuffer(line)
// Plays the entire audio buffer
//
// Syntax
//     audio_playBuffer(line)
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function plays the entire audio buffer as was set when creating an audio line.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,3);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_stopCapture(line)
//    audio_playBuffer(line)
//
// See also
//    audio_getBuffer
//    audio_saveBuffer
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);

    line.playAudio(%f)
    
    jautoUnwrap(bool);
endfunction
