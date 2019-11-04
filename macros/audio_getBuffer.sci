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
//    line = audio_getLine(16000,16,1,%t,%t,2,3);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_stopCapture(line)
//    data = audio_getBuffer(line);
//    plot(data)
//    playsnd(data,16000)
//
// See also
//    audio_saveBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    bool = jautoUnwrap();
    jautoUnwrap(%t);
    
    data_short = line.getAllBuffer();
    data_dbl = double(data_short)./2^15;
    n = line.getChannel();
    data = data_dbl(1:double(n):$);
    
    jautoUnwrap(bool);
endfunction
