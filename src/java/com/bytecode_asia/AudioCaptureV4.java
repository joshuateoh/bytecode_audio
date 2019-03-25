// Changelog
// Version 4b
// Trying to fix crashes (just comment out all the System.exit)
// Now I want the error info in Scilab.
// Converting capture from void to a string
// Converted captureAudio from void to String
// The return message will depend on whether capturing is a success or not:
//  OK - success
//  exceptions - send the exception class
//  RUNNING - capture has already started previously
//
// On the Scilab side
// audio_startCapture now reads the messages and output a corresponding message
// Scilab no longer shuts down and will instead tell if the capture has started or not

// Added a static checkMixer method
// this is to check if which line is supported
// Added a scilab function too.

/*File AudioCaptureV4.java
This program demonstrates the capture and subsequent playback of audio data.

A GUI appears on the screen containing the following buttons:
Capture
Stop
Playback

Input data from a microphone is captured and saved in a ByteArrayOutputStream object when the user clicks the Capture button.
Data capture stops when the user clicks the Stop button.


Playback begins when the user clicks the Playback button.


Tested using SDK 1.4.0 under Win2000
**************************************/

package com.bytecode_asia;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.sound.sampled.*;

public class AudioCaptureV4 {

    boolean stopCapture = false;
    ByteArrayOutputStream byteArrayOutputStream;
    AudioFormat audioFormat;
    TargetDataLine targetDataLine;
    AudioInputStream audioInputStream;
    SourceDataLine sourceDataLine;
    CircularByteBuffer3 ringbuffer;
    byte[] audioData;
    int mixer_selector;
    boolean captureRunning = false;

    // Default values
    float sampleRateG = 8000.0F;
    int bitsG = 8;
    int channelsG = 1;
    boolean signedG = true;
    boolean bigEndianG = false;
    int duration = 2;
    int ring_duration = 10;
    boolean defaultMixer = true;

    public AudioCaptureV4() {// constructor

    }// end constructor

    // With user selected mixer
    public AudioCaptureV4(int mixer, float sr, int bits, int chnls, boolean sign, boolean endian, int dur,
            int ring_dur) {
        this();
        mixer_selector = mixer;
        sampleRateG = sr;
        bitsG = bits;
        channelsG = chnls;
        signedG = sign;
        bigEndianG = endian;
        duration = dur;
        ring_duration = ring_dur;
        defaultMixer = false;
    }

    // With default mixer
    public AudioCaptureV4(float sr, int bits, int chnls, boolean sign, boolean endian, int dur,
            int ring_dur) {
        this();
        sampleRateG = sr;
        bitsG = bits;
        channelsG = chnls;
        signedG = sign;
        bigEndianG = endian;
        duration = dur;
        ring_duration = ring_dur;
        defaultMixer = true;
    }
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // check whether a mixer is compatible with TargetDataLine and SourceDataLine
    public static String[] checkMixer(int mixerID){
        String[] mixerresult = new String[3];
        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        mixerresult[0] = mixerInfo[mixerID].toString();
        Mixer checkmixer = AudioSystem.getMixer(mixerInfo[mixerID]);
        
        AudioFormat audioFormat = new AudioFormat(8000.0F, 8, 1, true, false);

        DataLine.Info dataLineInfo_target = new DataLine.Info(TargetDataLine.class, audioFormat);
        
        if(checkmixer.isLineSupported(dataLineInfo_target)){
            mixerresult[1] = "Microphone line: Supported";
        } else {
            mixerresult[1] = "Microphone line: Not Supported";
        }

        DataLine.Info dataLineInfo_source = new DataLine.Info(SourceDataLine.class, audioFormat);
        if(checkmixer.isLineSupported(dataLineInfo_source)){
            mixerresult[2] = "Speaker line: Supported";
        } else {
            mixerresult[2] = "Speaker line: Not Supported";
        }

        return mixerresult;


    }
    
    public static String[] listMixers() {

        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        String[] mymixers = new String[mixerInfo.length];
        for (int cnt = 0; cnt < mixerInfo.length; cnt++) {

            mymixers[cnt] = Integer.toString(cnt) + ": " + mixerInfo[cnt].toString();

        }

        return mymixers;
    }

    // This method creates and returns an AudioFormat object for a given set of
    // format parameters.
    // If these parameters don't work well for you, try some of the other allowable
    // parameter values, which
    // are shown in comments following the declarations.
    private AudioFormat getAudioFormat() {
        float sampleRate = sampleRateG;
        // 8000,11025,16000,22050,44100
        int sampleSizeInBits = bitsG;
        // 8,16
        int channels = channelsG;
        // 1,2
        boolean signed = signedG;
        // true,false
        boolean bigEndian = bigEndianG;
        // true,false
        return new AudioFormat(sampleRate, sampleSizeInBits, channels, signed, bigEndian);

    }// end getAudioFormat

    // This method captures audio input from a microphone and saves it in a
    // ByteArrayOutputStream object.
    public String captureAudio() {

        if (captureRunning == true) {
            // Capture is already running
            // do nothing
            // indicate that it is running
            return "RUNNING";
        } else {
            captureRunning = true;

            try {
                
                // Get everything set up for capture
                Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
                audioFormat = getAudioFormat();
                DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);

                if (defaultMixer == true){
                    targetDataLine = (TargetDataLine) AudioSystem.getLine(dataLineInfo); 
                } else{
                    Mixer mixer = AudioSystem.getMixer(mixerInfo[mixer_selector]);
                    targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
                }

                targetDataLine.open(audioFormat);
                targetDataLine.start();

                // Create a thread to capture the microphone data and start it running. It will
                // run until the Stop button is clicked.
                Thread captureThread = new Thread(new CaptureThread());
                captureThread.start();
            } catch (Exception e) {
                System.out.println(e);
                //Throwable cause = e.getCause();
                //System.out.println("getCause: ");
                //System.out.println(cause);
                //System.out.println("Localized Message: ");
                //System.out.println(e.getLocalizedMessage());
                //System.out.println("Message: ");
                //System.out.println(e.getMessage());
                //System.out.println("toString: ");
                //System.out.println(e.toString());
                //System.out.println("Class :");
                //System.out.println(e.getClass());
                captureRunning = false;

                //System.exit(0);
                return e.getClass().toString();
            } // end catch
            return "OK";
        }

        
    }// end captureAudio method

    public byte[] getAudioData() {
        return audioData;
    }

    public void getAudioData(String filepath) {
        File wavFile = new File(filepath);
        AudioFileFormat.Type fileType = AudioFileFormat.Type.WAVE;
        InputStream byteArrayInputStream = new ByteArrayInputStream(audioData);
        AudioInputStream audioInputStream2 = new AudioInputStream(byteArrayInputStream, audioFormat,
                audioData.length / audioFormat.getFrameSize());
        try {
            AudioSystem.write(audioInputStream2, fileType, wavFile);

        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void stopAudio() {
        stopCapture = true;
        captureRunning = false;
    }

    // Snapshot Audio
    // Get the latest 1-2 seconds
    public void snapAudio() {
        // Snap 2 seconds of audio
        // duration x sr x bytes per sample x nbr of channels
        int audioDataSize = duration * (int) sampleRateG * (bitsG / 8) * channelsG;
        audioData = new byte[audioDataSize];
        int mytemp = ringbuffer.getLatest(audioData);

    }

    // This method plays back the audio data that has been saved in the ByteArrayOutputStream
    public void playAudio() {
        if (audioData == null) {
            // do nothing
        } else {
            try {

                // Get an input stream on the byte array containing the data
                InputStream byteArrayInputStream = new ByteArrayInputStream(audioData);
                AudioFormat audioFormat = getAudioFormat();
                audioInputStream = new AudioInputStream(byteArrayInputStream, audioFormat,
                        audioData.length / audioFormat.getFrameSize());
                DataLine.Info dataLineInfo = new DataLine.Info(SourceDataLine.class, audioFormat);
                sourceDataLine = (SourceDataLine) AudioSystem.getLine(dataLineInfo);
                sourceDataLine.open(audioFormat);
                sourceDataLine.start();

                // Create a thread to play back the data and start it running. It will run until
                // all the data has been played back.
                Thread playThread = new Thread(new PlayThread());
                playThread.start();

            } catch (Exception e) {
                System.out.println(e);
                //System.exit(0);
            } // end catch
        } // end of else
    }// end playAudio

    // ==========================================================================================================================================//
    // Inner class to capture data from microphone
    class CaptureThread extends Thread {
        // Maximum buffer from line is 1 second
        // sample rate x bytes per sample x nbr of channels
        int linebuffer = (int) sampleRateG * (bitsG / 8) * channelsG;
        

        byte tempBuffer[] = new byte[linebuffer];

        public void run() {
            // Number of bytes for 10 seconds
            int ringbuffer10sec = ring_duration * (int) sampleRateG * (bitsG / 8) * channelsG;
            // System.out.println("linebuffer is "+linebuffer);
            // System.out.println("ringbuffer10sec is "+ringbuffer10sec);
            ringbuffer = new CircularByteBuffer3(ringbuffer10sec);

            stopCapture = false;
            try {// Loop until stopCapture is set by another thread that services the Stop
                 // button.

                while (!stopCapture) {
                    // Read data from the internal buffer of the data line.
                    int cnt = targetDataLine.read(tempBuffer, 0, tempBuffer.length);

                    if (cnt > 0) {
                        // Save data in output stream object.
                        // byteArrayOutputStream.write(tempBuffer, 0, cnt);
                        ringbuffer.put(tempBuffer);

                    } // end if
                } // end while
                  // byteArrayOutputStream.close();
                targetDataLine.stop();
                targetDataLine.close();
            } catch (Exception e) {
                System.out.println(e);
                System.exit(0);
            } // end catch
        }// end run
    }// end inner class CaptureThread

    // ============================================================================================================================================//
    // Inner class to play back the data that was saved.
    class PlayThread extends Thread {
        int playDataSize = duration * (int) sampleRateG * (bitsG) * channelsG;

        byte tempBuffer[] = new byte[playDataSize];

        public void run() {
            try {
                int cnt;
                System.out.println("playDataSize is " + playDataSize);
                // Keep looping until the input read method returns -1 for empty stream.
                while ((cnt = audioInputStream.read(tempBuffer, 0, tempBuffer.length)) != -1) {
                    if (cnt > 0) {
                        // Write data to the internal buffer of the data line where it will be delivered
                        // to the speaker.
                        sourceDataLine.write(tempBuffer, 0, cnt);

                    } // end if
                } // end while

                // Block and wait for internal buffer of the data line to empty.
                sourceDataLine.drain();
                sourceDataLine.close();
            } catch (Exception e) {
                System.out.println(e);
                System.exit(0);
            } // end catch
        }// end run
    }// end inner class PlayThread

    class CircularByteBuffer3 {
        private final byte[] buffer;
        private final int capacity;
        private int idxPut;

        public CircularByteBuffer3() {
            this(8192);
        }

        public CircularByteBuffer3(int capacity) {
            this.capacity = capacity;
            buffer = new byte[this.capacity];
        }

        /**
         * Clears all data from the buffer.
         */
        public synchronized void clear() {
            idxPut = 0;
        }

        public synchronized int getStart(byte[] dst) {

            int count = dst.length;
            System.arraycopy(buffer, 0, dst, 0, count);
            return count;
        }

        public synchronized int getLatest(byte[] dst) {
            int count = dst.length;

            if (count <= idxPut) {
                System.out.println();
                int idxRead = idxPut - dst.length;
                System.arraycopy(buffer, idxRead, dst, 0, count);
            } else if (idxPut == 0) {
                int idxRead = capacity - count;
                System.arraycopy(buffer, idxRead, dst, 0, count);

            } else {
                int rem = count - idxPut;
                int idxRead = capacity - rem;
                System.arraycopy(buffer, idxRead, dst, 0, rem);
                System.arraycopy(buffer, 0, dst, rem, idxPut);
            }

            return count;
        }

        public int put(byte[] src) {
            return put(src, 0, src.length);
        }

        public synchronized int put(byte[] src, int off, int len) {

            int limit = capacity;
            int count = Math.min(limit - idxPut, len);
            System.arraycopy(src, off, buffer, idxPut, count);
            idxPut += count;

            if (idxPut == capacity) {
                int count2 = len - count; // remainder
                if (count2 > 0) {
                    System.arraycopy(src, off + count, buffer, 0, count2);
                    idxPut = count2;
                    count += count2;
                } else {
                    idxPut = 0;
                }
            }
            return count;
        }

        /**
         * The capacity (size) is the maximum of bytes that can be stored inside this
         * buffer.
         */
        public int capacity() {
            return capacity;
        }

    }

    // ===================================//
}// end outer class AudioCapture01.java