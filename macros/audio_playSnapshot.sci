function audio_playSnapshot(line)
// Plays an audio snapshot
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
//     audio_playSnapshot(line)
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function plays the audio snapshot that was taken using the function audio_snapshot.
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
//    audio_snapshot
//    audio_getSnapshot
//    audio_saveSnapshot
// Authors
//     Joshua T. 
    line.playAudio(%t)
endfunction
