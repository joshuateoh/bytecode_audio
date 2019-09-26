function data = audio_getBuffer(line)
// Retrieve the entire data in the buffer
//
// Syntax
//     data=audio_getBuffer(line)
//
// Parameters
//     line : Java object. Audio line
//     data : Matrix array. Audio buffer data
//
// Description
//     This function imports the entire buffer data into a Scilab variable.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_stopCapture(line)
//    data = audio_getBuffer(line);
//    plot(data)
//
// See also
//    audio_saveBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    data = line.getAllBuffer();
endfunction
