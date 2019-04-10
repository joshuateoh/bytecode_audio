function audio_snapshot(line,n,secOrByte)
// Obtain a snapshot of the audio data
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
//     audio_snapshot(line)
//     audio_snapshot(line,x,secByte)
//
// Parameters
//     line : Java object. Audio line.
//     x : Double. The number of seconds or the number of bytes.
//     secByte : Boolean. True for seconds, false for bytes.
//
// Description
//     This function obtains a snapshot of the latest audio data stored in the buffer. This data can then be played, stored as a variable or saved into a file. The snapshot duration is based on the parameters set when creating the audio line. You can also specify the amount of data in the snapshot in either seconds or bytes. 
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
//    audio_playSnapshot
//    audio_getSnapshot
//    audio_saveSnapshot
//
// Authors
//     Joshua T. 

    rhs = argn(2)
    if rhs == 1 then
        line.snapAudio()
    elseif rhs == 3 then
        line.snapAudio(n,secOrByte)
    else
        error(msprintf("%s: Wrong number of input arguments.\n","audio_snapshot"))
    end
    
endfunction
