function [mixerlist,nmixer]=audio_getActiveMixers()
// Obtain a list of mixers that have lines that are currently open
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
//    [mixerlist,nmixer]=audio_getActiveMixers()
//
// Parameters
//     mixerlist : A string array of the active mixers
//     nmixers : Double. The number of active mixers
//
// Description
//     This function returns a array of mixers with active audio lines as well as the total. 
//
// Examples
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    [mixerlist,nmixer]=audio_getActiveMixers()
//    audio_startCapture(line)
//    [mixerlist,nmixer]=audio_getActiveMixers()
//    audio_stopCapture(line)
//
// See also
//    audio_checkMixer
//    audio_getMixers
//
// Authors
//     Joshua T. 
    
    jimport com.bytecode_asia.AudioCaptureV4
    mixerlist = AudioCaptureV4.listActiveMixers()'
    nmixer = AudioCaptureV4.getActiveMixers()
    
endfunction
