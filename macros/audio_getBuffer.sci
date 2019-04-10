function data = audio_getBuffer(line)
// Retrieve the entire data in the buffer
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
//     data=audio_getBuffer(line)
//
// Parameters
//     line : Java object. Audio line
//     data : Matrix array. Audio buffer data
//
// Description
//     This function imports the entire buffer data into a Scilab variable.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_stopCapture(line)
//    data = audio_getBuffer(line);
//    plot(data)
//
// See also
//    audio_saveBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    data = line.getAllBuffer();
endfunction
