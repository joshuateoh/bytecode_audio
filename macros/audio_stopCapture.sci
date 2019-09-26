function audio_stopCapture(line)
// Stops the audio capturing process
//
// Syntax
//     audio_stopCapture(line)
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function stops the audio capture process started by audio_startCapture.
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
//    audio_startCapture
//
// Authors
//     Joshua T. 
    line.stopAudio()
    disp("Audio capturing has stopped. No new data will be captured.")
endfunction
