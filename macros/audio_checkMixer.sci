function res = audio_checkMixer(mixerID)
// Check the lines supported by a selected mixer.
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
//     res = audio_checkMixer(mixerID)
//
// Parameters
//     mixerID : Integer. Mixer ID.
//     res : String array. Status of the lines supported.
//
// Description
//     A mixer generally supports a line that connects to either the microphone or speaker. This functions determines the line that is supported by the mixer.
//
// Examples
//    res = audio_checkMixer(0);
//    disp(res)
//
// See also
//    audio_getMixers
//    audio_getActiveMixers
//
// Authors
//     Joshua T. 
    jimport com.bytecode_asia.AudioCaptureV4
    res =  AudioCaptureV4.checkMixer(mixerID)';
endfunction
