function config = recognizer_setup(acoustic,dict,lm)
    jimport edu.cmu.sphinx.api.Configuration
    config = Configuration.new()
    config.setAcousticModelPath(acoustic)
    config.setDictionaryPath(dict)
    config.setLanguageModelPath(lm)
endfunction
