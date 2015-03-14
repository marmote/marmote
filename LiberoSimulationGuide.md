# Unit test #

Use the following steps to set up a unit test:

  1. Check out the source code from SVN
  1. Regenerate MSS related library files (might be unnecessary if libraries not needed?)
    1. Open the MSS on the Libero SmartDesign canvas
    1. Click the generate button
  1. Regenerate the canvas files (might be unnecessary if libraries not needed?)
    1. Open the Libero SmartDesign canvas
    1. Click the generate button
  1. Make the desired unit test active
    1. From `Project > Project Settings` select the `Simulation Options` entry
      1. In the `DO File` sub-entry set the test module name and the top level instance name
      1. In the `Waveforms` sub-entry set the `Include DO file` field to point the script setting up the waveforms
    1. Select the `Simulation Libraries` entry and make sure that only the necessary libraries are included

# Integration test #

_TBD_