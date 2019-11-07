function line = audio_getLine(sr,bits,chnls,signed,endian,snap_dur,ring_dur,varargin)
// Obtains an audio line
//
// Syntax
//    line = audio_getLine()
//     line = audio_getLine(sr,bits,chnls,signed,endian,snap_dur,ring_dur,[mixer])
//     
//
// Parameters
//     sr : Double. Sampling rate
//     bits : Integer. Number of bits per sample
//     chnls : Integer. Number of channels.
//     signed : Boolean. True means signed data.
//     endian : Boolean. True means stored in big-endian.
//     snap_dur : Integer. Duration of snapshot.
//     ring_dur : Integer. Duration of ring buffer.
//     mixer : Integer. Optional. Mixer ID
//     line : Java object. Audio line.
//
// Description
//     This function obtains a audio line that can then be used to capture audio. With no arguments, a default audio format (8kHz, 8 bits, 1 channel, signed, little-endian) will be used with a compatible mixer at a snapshot duration of 2s and a buffer of 10s. A specific mixer can be selected using its ID (obtained from audio_getMixers) as an additional input.
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
//    audio_killLine
//    audio_killAllLine
//
// Authors
//     Joshua T. 

    bool = jautoUnwrap();
    jautoUnwrap(%t);

    jimport com.bytecode_asia.AudioCaptureV4
    
    rhs = argn(2);
    if rhs == 0 then
        line = AudioCaptureV4.new()
    elseif rhs == 7 then
    line = AudioCaptureV4.new(sr,bits,chnls,signed,endian,snap_dur,ring_dur)elseif rhs == 8
        mixer = varargin(1)
        line = AudioCaptureV4.new(mixer,sr,bits,chnls,signed,endian,snap_dur,ring_dur)
    else
        error(msprintf("%s: Wrong number of input arguments.\n","audio_getLine"))
    end
    
    jautoUnwrap(bool);
    
endfunction

