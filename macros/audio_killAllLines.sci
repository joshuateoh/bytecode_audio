function n = audio_killAllLines()
// Kills all audio lines in Scilab
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
//    n = audio_killAllLines()
//     
//
// Parameters
//     n : Double. Number of audio lines killed.
//
// Description
//     This function kills all audio lines in Scilab and return the number of lines killed. 
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    mixerlist = audio_getActiveMixers()
//    n = audio_killAllLines()
//    mixerlist = audio_getActiveMixers()
//
// See also
//    audio_getLine
//    audio_killLine
//
// Authors
//     Joshua T. 
    
    jimport com.bytecode_asia.AudioCaptureV4
    n = AudioCaptureV4.killAllLines()
endfunction
