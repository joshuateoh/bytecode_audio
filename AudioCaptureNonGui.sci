
javaclasspath("C:\Users\Joshua\Desktop\AudioCaptureNonGUI")
jimport AudioCaptureV3c

AudioCaptureV3c.listMixers()'
// Device position may change
// 7 - Microphone (Jabra SPEAK 510 USB)
// 5 - Internal Mic (IDT High Definition Audio CODEC)

mic_jabra = 7 
mic_internal = 5
audio_jabra = AudioCaptureV3c.new(mic_jabra,16000,16,1,%t,%t,3,10)
audio_internal = AudioCaptureV3c.new(mic_internal,16000,16,1,%t,%t,3,10)

audio_jabra.captureAudio()
audio_internal.captureAudio()

audio_jabra.snapAudio()
audio_jabra.playAudio()

audio_internal.snapAudio()
audio_internal.playAudio()

audio_jabra.playAudio()
audio_internal.playAudio()

jabra_data = audio_jabra.getAudioData();
internal_data = audio_internal.getAudioData();

audio_jabra.getAudioData("jabra.wav");
audio_internal.getAudioData("internal.wav")

audio_jabra.stopAudio()
audio_internal.stopAudio()

// Test
