function y = speech_recognizer(config)
    jimport javax.sound.sampled.AudioFormat;
    jimport javax.sound.sampled.AudioSystem;
    jimport javax.sound.sampled.AudioInputStream; 
    jimport edu.cmu.sphinx.api.StreamSpeechRecognizer;
    recog= StreamSpeechRecognizer.new(config);
    
    myformat=AudioFormat.new(16000, 16, 1, %t, %f);
    line = AudioSystem.getTargetDataLine(myformat);
    line.open();
    inputStream = AudioInputStream.new(line);
    line.start();
    
    recog.startRecognition(inputStream);
    disp("Please say a word that is in the dictionary")
    res  = recog.getResult()
    
    y=res.getHypothesis()
    recog.stopRecognition()
    line.stop();
    line.close();
    
endfunction
