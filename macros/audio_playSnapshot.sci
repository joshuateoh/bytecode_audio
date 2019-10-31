function audio_playSnapshot(line)
// Plays an audio snapshot
//
// Syntax
//     audio_playSnapshot(line)
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function plays the audio snapshot that was taken using the function audio_snapshot.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_snapshot(line)
//    audio_playSnapshot(line)
//    audio_stopCapture(line)
//
// See also
//    audio_snapshot
//    audio_getSnapshot
//    audio_saveSnapshot
// Authors
//     Joshua T. 
    line.playAudio(%t)
endfunction
