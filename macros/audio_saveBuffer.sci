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
//    line = audio_getLine(16000,16,1,%t,%t,2,3);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_stopCapture(line)
//    audio_saveBuffer(line,TMPDIR+"\myaudio.wav")
//    [audiodata,fs]=wavread(TMPDIR+"\myaudio.wav");
//    playsnd(audiodata,fs)
//
// See also
//    audio_getBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    line.saveBuffer(wavfile);
    
    jautoUnwrap(bool);
endfunction
