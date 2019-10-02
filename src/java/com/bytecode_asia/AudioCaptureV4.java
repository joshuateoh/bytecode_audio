/*File AudioCaptureV4.java
This Java file allows audio to be captured and recorded inside Scilab.
Input from a microphone is captured and saved inside a ring buffer. 
*/

package com.bytecode_asia;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import javax.sound.sampled.*;
import java.util.ArrayList;

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
    float sampleRateG = 8000.0F; // Default sample rate
    int bitsG = 8; // Default number of bits per sample
    int channelsG = 1; // Default number of channels
    boolean signedG = true; // Default is signed numbers
    boolean bigEndianG = false; // Default is small endian
    int duration = 2; // Default snapshot duration
    int ring_duration = 10; // Default ring buffer duration
    boolean defaultMixer = true; // Mixer is chosen automatically by default

    // ========================================================================================================================================
    //                                                           CONSTRUCTORS          
    // ========================================================================================================================================

    // Using default values
    public AudioCaptureV4() {// constructor

    }// end constructor

    // Using user input but with default mixer
    public AudioCaptureV4(float sr, int bits, int chnls, boolean sign, boolean endian, int dur, int ring_dur) { // constructor
        this();
        sampleRateG = sr;
        bitsG = bits;
        channelsG = chnls;
        signedG = sign;
        bigEndianG = endian;
        duration = dur;
        ring_duration = ring_dur;
        defaultMixer = true;
    } // end constructor

    // Using user input including the mixer
    public AudioCaptureV4(int mixer, float sr, int bits, int chnls, boolean sign, boolean endian, int dur, int ring_dur) { // constructor
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
    } // end constructor

    // ========================================================================================================================================
    //                                                               STATIC METHODS           
    // ========================================================================================================================================

    /* Current static methods are:
         listMixers()
         checkMixer(int mixerID)
         listActiveMixers()
         getActiveMixers()
         byteToShort(byte[] byteData, boolean writeLittleEndian)
         killAllLines()
    */

    // Returns a string array of available mixers
    public static String[] listMixers() {

        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        String[] mymixers = new String[mixerInfo.length];
        for (int cnt = 0; cnt < mixerInfo.length; cnt++) {

            mymixers[cnt] = Integer.toString(cnt) + ": " + mixerInfo[cnt].toString();

        }

        return mymixers;
    } // end listMixers

    // Check a mixer's compatibility with TargetDataLine and SourceDataLine
    // Returns a string array with the mixer's name and results
    public static String[] checkMixer(int mixerID){
        String[] mixerresult = new String[3];

        // Obtain the selected mixer
        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        mixerresult[0] = mixerInfo[mixerID].toString();
        Mixer checkmixer = AudioSystem.getMixer(mixerInfo[mixerID]);
        
        AudioFormat audioFormat = new AudioFormat(8000.0F, 8, 1, true, false);

        // Test compatibility with TargetDataLine
        DataLine.Info dataLineInfo_target = new DataLine.Info(TargetDataLine.class, audioFormat);    
        if(checkmixer.isLineSupported(dataLineInfo_target)){
            mixerresult[1] = "Microphone line: Supported";
        } else {
            mixerresult[1] = "Microphone line: Not Supported";
        }

        // Test compatibility with SourceDataLine
        DataLine.Info dataLineInfo_source = new DataLine.Info(SourceDataLine.class, audioFormat);
        if(checkmixer.isLineSupported(dataLineInfo_source)){
            mixerresult[2] = "Speaker line: Supported";
        } else {
            mixerresult[2] = "Speaker line: Not Supported";
        }

        return mixerresult;

    } // end checkMixer
    
    // Returns a string array of mixers with lines that are currently open
    public static String[] listActiveMixers(){
        ArrayList<String> activemixers = new ArrayList<String>();

        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        for (int i = 0; i < mixerInfo.length; i++){
            Mixer mixer = AudioSystem.getMixer(mixerInfo[i]);
            Line[] mixerlines = mixer.getTargetLines(); // Return a list of lines that currently open
            for (int j=0; j < mixerlines.length; j++){
                Mixer.Info mixerinfo = mixer.getMixerInfo();
                activemixers.add(mixerinfo.toString());
            }

        }
        String[] activestr = activemixers.toArray(new String[activemixers.size()]);
        return activestr;

    } // end listActiveMixers

    // Returns the number of mixers with lines that are currently open
    public static Integer getActiveMixers(){
        Integer n_mixers = 0;
        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        for (int i = 0; i < mixerInfo.length; i++){
            Mixer mixer = AudioSystem.getMixer(mixerInfo[i]);
            Line[] mixerlines = mixer.getTargetLines();
            for (int j=0; j < mixerlines.length; j++){
                n_mixers++;
            }   
        }
        return n_mixers;
    } // end getActiveMixers

    // Converts byte to short
    public static short[] byteToShort(byte[] byteData, boolean writeLittleEndian) {
        short[] data = new short[byteData.length / 2];
        int size = data.length;
        byte lb, hb;
        if (writeLittleEndian) {
            for (int i = 0; i < size; i++) {
                lb = byteData[i * 2];
                hb = byteData[i * 2 + 1];
                data[i] = (short) (((short) hb << 8) | lb & 0xff);
            }
        } else {
            for (int i = 0; i < size; i++) {
                lb = byteData[i * 2];
                hb = byteData[i * 2 + 1];
                data[i] = (short) (((short) lb << 8) | hb & 0xff);
            }

        }
        return data;
    } // end byteToShort

    // Kill all open lines
    public static Integer killAllLines() {
        Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();
        Integer linecnt = 0;
        for (int i = 0; i < mixerInfo.length; i++){
            Mixer mixer = AudioSystem.getMixer(mixerInfo[i]);
            Line[] mixerlines = mixer.getTargetLines();
            for (int j=0; j < mixerlines.length; j++){
                mixerlines[j].close();
                linecnt++;
            }
        }
        return linecnt;
    } // end killAllLines

    // ========================================================================================================================================
    //                                                    NON - STATIC METHODS           
    // ========================================================================================================================================

    /* Current non-static methods are:
        getAudioFormat()
        captureAudio()
        stopAudio()
        playAudio(boolean snapshotOrBuffer)
        getAudioData()
        saveAudioData(String filepath)
        snapAudio()
        snapAudio(float x, boolean secOrByte )
        getAllBuffer()
        saveBuffer(String filepath)
        killLine()

    */

    // This method creates and returns an AudioFormat object for a given set of format parameters.
    private AudioFormat getAudioFormat() {
        float sampleRate = sampleRateG;
        int sampleSizeInBits = bitsG;
        int channels = channelsG;
        boolean signed = signedG;
        boolean bigEndian = bigEndianG;
        return new AudioFormat(sampleRate, sampleSizeInBits, channels, signed, bigEndian);
    }// end getAudioFormat

    // Obtain a line for a mixer before starting a new thread for capture
    public String captureAudio() {

        // Initialize the line if it hasn't been done yet
        if (targetDataLine == null) {
        
            // Initialize targetDataline
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

            } catch (Exception e) {
                System.out.println(e);
                return e.getClass().toString();
            } // end catch   
        } // end if

        if (targetDataLine.isOpen()) {
            // do nothing
            return "RUNNING";
        }
        else {
            try{
                targetDataLine.open(audioFormat);
                targetDataLine.start();

                // Create a thread to capture the microphone data and start it running. 
                // It will run until stopAudio is called or the line is closed.
                Thread captureThread = new Thread(new CaptureThread());
                captureThread.start();
            }
            catch (Exception e){
                System.out.println(e);
                return e.getClass().toString();
            }
            return "OK";
        } // end else

    }// end captureAudio

    // Stops the audio capture process
    public void stopAudio() {
        stopCapture = true;
    } // end stopCapture

    // Plays the audio data
    // The boolean input determines whether the snapshot audio or buffer should be played
    public void playAudio(boolean snapshotOrBuffer) {

        // True - If user wants to play snapshot
        if (snapshotOrBuffer){
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

                    // Create a thread to play back the data and start it running. 
                    // It will run until all the data has been played back.
                    Thread playThread = new Thread(new PlayThread());
                    playThread.start();

                } catch (Exception e) {
                    System.out.println(e);
                } // end catch
            } // end of else
        } // end of if(snapshotOrBuffer)
        else { // If user wants to play the entire buffer
            int capacity = ringbuffer.capacity();
            byte[] audioall = new byte[capacity];
            int mytemp = ringbuffer.getLatest(audioall);

            try {

                // Get an input stream on the byte array containing the data
                InputStream byteArrayInputStream = new ByteArrayInputStream(audioall);
                AudioFormat audioFormat = getAudioFormat();
                audioInputStream = new AudioInputStream(byteArrayInputStream, audioFormat,
                        audioall.length / audioFormat.getFrameSize());
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
            } // end catch
        } // end of else

    }// end playAudio

    // Returns the snapshot audio data
    public short[] getAudioData() {
        //return audioData;
        return byteToShort(audioData, false);
    } // end getAudioData

    // Saves the snapshot audio data in a file
    public void saveAudioData(String filepath) {
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
    } // end saveAudioData

    // Get the latest n seconds from buffer
    // Duration is fixed and depends on initialization parameters
    public void snapAudio() {
        // Total byte size = duration x sr x bytes per sample x nbr of channels
        int audioDataSize = duration * (int) sampleRateG * (bitsG / 8) * channelsG;
        audioData = new byte[audioDataSize];
        int mytemp = ringbuffer.getLatest(audioData);
    } // end snapAudio

    // Get the latest x seconds or bytes  from buffer
    // x is customizable when using the method
    public void snapAudio(float x, boolean secOrByte ){
        
        if (secOrByte){ // True - If using seconds
            float temp = x * sampleRateG * (bitsG / 8) * channelsG;
            int audioDataSize = (int) temp; 
            audioData = new byte[audioDataSize];
            int mytemp = ringbuffer.getLatest(audioData);
        }
        else{ // False - If using bytes
            audioData = new byte[(int) x];
            int mytemp = ringbuffer.getLatest(audioData);
        }
    } // end snapAudio


    // Returns the entire ring buffer
    public short[] getAllBuffer(){
        int capacity = ringbuffer.capacity();
        byte[] audioall = new byte[capacity];
        int mytemp = ringbuffer.getLatest(audioall);
        return byteToShort(audioall, false);
    } // end getAllBuffer

    // Saves the entire ring buffer to a file
    public void saveBuffer(String filepath){
        int capacity = ringbuffer.capacity();
        byte[] audioall = new byte[capacity];
        int mytemp = ringbuffer.getLatest(audioall);
        File wavFile = new File(filepath);
        AudioFileFormat.Type fileType = AudioFileFormat.Type.WAVE;
        InputStream byteArrayInputStream = new ByteArrayInputStream(audioall);
        AudioInputStream audioInputStream2 = new AudioInputStream(byteArrayInputStream, audioFormat,
                                audioall.length / audioFormat.getFrameSize());
        try {
            AudioSystem.write(audioInputStream2, fileType, wavFile);

        } catch (Exception e) {
            System.out.println(e);
        }
    } // end saveBuffer

    // Kill the TargetDataline for this object
    public void killLine(){   
        if (targetDataLine != null) {
            if (targetDataLine.isOpen()){
                try{
                    targetDataLine.stop();
                    targetDataLine.close();               
                }
                catch (Exception e){
                    System.out.println(e.getClass().toString());
                }
            }
        }
    }


    // ==========================================================================================================================================
    //                                                     INNER CLASSES
    // ==========================================================================================================================================//
    
    // Inner class to capture data from microphone
    class CaptureThread extends Thread {
        // Maximum buffer from line is 1 second
        // sample rate x bytes per sample x nbr of channels
        // Read smaller amount of buffer if snapshot is used at a higher rate.
        int linebuffer = (int) sampleRateG * (bitsG / 8) * channelsG / 1000;
        

        byte tempBuffer[] = new byte[linebuffer];

        public void run() {
            // Number of bytes for 10 seconds
            int ringbuffer10sec = ring_duration * (int) sampleRateG * (bitsG / 8) * channelsG;
            ringbuffer = new CircularByteBuffer3(ringbuffer10sec);

            stopCapture = false;
            try {// Loop until stopCapture is set true
                while (!stopCapture) {

                    if (targetDataLine.isOpen()){
                        // Read data from the internal buffer of the data line.
                        int cnt = targetDataLine.read(tempBuffer, 0, tempBuffer.length);

                        if (cnt > 0) {
                            // Save data in ring buffe.
                            ringbuffer.put(tempBuffer);

                        } // end if
                    } 
                    else{ // If line is close, stop capture
                        stopCapture = true;
                    }
                } // end while
                  
                targetDataLine.stop();
                targetDataLine.close();
            } catch (Exception e) {
                System.out.println(e);
                
            } // end catch
            System.out.println("Exiting Capture thread");

            if (targetDataLine != null){
                System.out.println("Stopping and closing line does not make it null!");
            }

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

    // ============================================================================================================================================//
    // Ring Buffer class
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

    // ============================================================================================================================================//
}// end outer class AudioCaptureV4.java
