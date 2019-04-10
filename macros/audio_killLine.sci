function audio_killLine(line)
// Kills an audio line
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
//    audio_killLine(line)
//     
//
// Parameters
//     line : Java object. Audio line.
//
// Description
//     This function kills a given audio line. 
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    mixerlist = audio_getActiveMixers()
//    audio_killLine(line)
//    mixerlist = audio_getActiveMixers()
//
// See also
//    audio_getLine
//    audio_killAllLines
//
// Authors
//     Joshua T. 
    
    
    line.killLine()
endfunction
