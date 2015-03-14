# Requirements #

  * Libero SoC 10 with license (free)
  * Synphony Model Compiler AE with license (free)

  * Matlab 2011b+ and Simulink with licenses for
    * Fixed-point Toolbox
    * Communication systems toolbox

# Set up #

  1. Download and install Libero SoC and Synphony Model Compiler from http://www.actel.com/download/default.aspx
  1. Download, install and run the necessary license manager daemon from http://www.actel.com/products/software/libero/licensing.aspx#daemons
    1. Follow the instructions described in the email with the license
    1. Start the daemon prior to launching Matlab
  1. Create a Simulink model using the Synplify Model Compiler blockset
  1. Simulate and generate HDL code for the model
  1. Add the <synphony\_top\_module.vhd> and `SynLib.vhd` to the Libero project
  1. Create a library 'shlslib' in Libero and add `SynLib.vhd` to it
  1. Follow the regular Libero design flow
    1. Simulate the HDL project using ModelSim
    1. Synthesize the design
    1. etc.