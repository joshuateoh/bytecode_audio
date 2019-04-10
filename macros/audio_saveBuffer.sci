function audio_saveBuffer(line,wavfile)
// Saves the entire audio buffer into a file
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
//     audio_saveBuffer(line,wavfile)
//
// Parameters
//     line : Java object. Audio line
//     wavfile : String. Name of wav file that will used to save the audio
//
// Description
//     This function saves the entire audio buffer into a specified file. The audio will be saved as a wav file.
//
// Examples
//    // Requires a microphone 
//    line = audio_getLine(16000,16,1,%t,%t,2,10);
//    audio_startCapture(line)
//    messagebox("Please say something and then click OK to continue","modal");
//    audio_snapshot(line)
//    audio_saveSnapshot(line,TMPDIR+"\myaudio.wav")
//    [audiodata,fs]=wavread(TMPDIR+"\myaudio.wav");
//    sound(audiodata,fs)
//    audio_stopCapture(line)
//
// See also
//    audio_getBuffer
//    audio_playBuffer
//
// Authors
//     Joshua T. 
    
    line.getAllBuffer(wavfile);
endfunction
