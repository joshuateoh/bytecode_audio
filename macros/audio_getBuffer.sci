function data = audio_getBuffer(line)
// Retrieve the entire data in the buffer
//
// Syntax
//     data=audio_getBuffer(line)
//
// Parameters
//     line : Java object. Audio line
//     data : Matrix array. Audio buffer data. Data from each channel is stored in separate rows.
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
//    plot(data(1,:))
//    playsnd(data(1,:),16000)
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
    
    for i = 1:double(n)
        data(i,:) = data_dbl(i:double(n):$);
    end
    
    jautoUnwrap(bool);
endfunction
