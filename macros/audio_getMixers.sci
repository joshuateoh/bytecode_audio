function y = audio_getMixers()
// Obtain a list of available mixers
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
//    y = audio_getMixers()
//
// Parameters
//     y : A string array of the available mixers
//
// Description
//     This function returns a array of mixers that are available. Each mixer has a ID which can be used to select that particular mixer. Do note that a mixer's ID is not fixed and will change when devices are added or removed. 
//
// Examples
//    y = audio_getMixers();
//    disp(y)
//    
//
// See also
//    audio_getLine
//    audio_startCapture
//    audio_stopCapture
//    audio_snapshot
//    audio_playSnapshot
//    audio_getSnapshot
//    audio_saveSnapshot
//
// Authors
//     Joshua T. 


    jimport com.bytecode_asia.AudioCaptureV4
    y = AudioCaptureV4.listMixers()'
endfunction
