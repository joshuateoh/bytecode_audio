function data=audio_getSnapshot(line)
// Imports the audio snapshot data into Scilab
//
// Syntax
//     data=audio_getSnapshot(line)
//
// Parameters
//     line : Java object. Audio line
//     data : Matrix array. Audio snapshot data
//
// Description
//     This function imports the audio snapshot data into a Scilab variable.The audio snapshot data is first taken using the function audio_snapshot.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_snapshot(line)
//    data = audio_getSnapshot(line);
//    audio_stopCapture(line)
//    plot(data)
//    playsnd(data,16000)
//
// See also
//    audio_snapshot
//    audio_playSnapshot
//    audio_saveSnapshot
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    data_short = line.getAudioData();
    data_dbl = double(data_short)./2^15;
    n = line.getChannel();
    data = data_dbl(1:double(n):$)
    
    jautoUnwrap(bool);
endfunction
