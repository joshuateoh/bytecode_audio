function audio_startCapture(line)
// Begins capturing audio
//
// Syntax
//     audio_startCapture(line)
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function starts the audio capturing process (done in the background) on a given audio line. The audio is continuously captured but the buffer will only keep the latest audio data for a certain duration before being overwritten by newer data. The buffer duration is set when creating the audio line using audio_getLine.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    // The audio capture process has started. 
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_snapshot(line)
//    audio_playSnapshot(line)
//    audio_stopCapture(line)
//
// See also
//    audio_stopCapture
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);

    msg = line.captureAudio()
    
    if msg == "OK" then
        disp("Audio is now being captured. Remember to stop capturing when done.")
    elseif msg == "RUNNING" then
        disp("Audio capture is already running.")
    else
        temp = strsubst(msg,'/.*\./','','r');
        select temp
        case "LineUnavailableException" then
            err_msg = "%s: LineUnavailableException - the line is currently in used\n"
            error(msprintf(err_msg,"audio_startCapture"))
        else
            err_msg = "%s: "+temp+"\n"
            error(msprintf(err_msg,"audio_startCapture"))
        end
        
    end
    
    jautoUnwrap(bool);
    
endfunction


