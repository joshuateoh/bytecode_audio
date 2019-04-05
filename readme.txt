Bytecode Audio Pack Version 0.1

This module is developed by Bytecode to allow audio recording inside SCILAB.

Features
This toolbox allows you to capture audio inside Scilab. There are currently 9 functions related to this feature.
audio_checkMixer — Check the lines supported by a selected mixer.
audio_getLine — Obtains an audio line
audio_getMixers — Obtain a list of available mixers
audio_getSnapshot — Imports the audio snapshot data into Scilab
audio_playSnapshot — Plays an audio snapshot
audio_saveSnapshot — Saves audio snapshot into a file
audio_snapshot — Obtain a snapshot of the audio data
audio_startCapture — Begins capturing audio
audio_stopCapture — Stops the audio capturing process


Experimental
This toolbox also contains 2 experimental functions that allow for some simple speech recognition. Currently, users will need to provide thier own acoustic model, dictionary and language model in order to use the functions.
Do note that the spinx4 jar file inside the jar folder is not detected by the builder upon building the toolbox. You will need to manually edit the loader in src/java to include it in the java class path. 

TODO
- Improve the speech recognition functions and add in help files for the speech recognition
- Text to Speech feature is planned to be added in the future.
- audio_snapshot - had the option set snapshot duration using number of bytes
- Add a function to grab the entire buffer data instead of just the snapshot
- Add a function to kill all lines


