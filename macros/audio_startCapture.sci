function audio_startCapture(line)
// Begins capturing audio
//
//    Copyright 2019 Bytecode.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 2 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/
//
// Calling Sequence
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
//    // Feel free to say something before running the next line of code.
//    audio_snapshot(line)
//    audio_playSnapshot(line)
//    audio_stopCapture(line)
//
// See also
//    audio_checkMixer
//    audio_getLine
//    audio_getMixers
//    audio_stopCapture
//    audio_snapshot
//    audio_playSnapshot
//    audio_getSnapshot
//    audio_saveSnapshot
//
// Authors
//     Joshua T. 

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
            err_smg = "%s: "+temp+"\n"
            error(msprintf(err_msg,"audio_startCapture"))
        end
        
    end
    
endfunction


