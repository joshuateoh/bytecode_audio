function audio_saveBuffer(line,wavfile)
// Saves the entire audio buffer into a file
//
// Syntax
//     audio_saveBuffer(line,wavfile)
//
// Parameters
//     line : Java object. Audio line
//     wavfile : String. Name of wav file that will used to save the audio
//
// Description
//     This function saves the entire audio buffer into a specified file. The audio will be saved as a wav file.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_snapshot(line)
//    audio_saveSnapshot(line,TMPDIR+"\myaudio.wav")
//    [audiodata,fs]=wavread(TMPDIR+"\myaudio.wav");
//    sound(audiodata,fs)
//    audio_stopCapture(line)
//
// See also
//    audio_getBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    line.getAllBuffer(wavfile);
endfunction
