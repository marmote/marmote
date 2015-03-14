# Measurement setup #

## Receiver ##

USRP1 with an RFX2400 daughterboard tuned to 2.40495 GHz (all cases).

## Transmitter ##

### 1. No transmitter (receiver noise level) ###

![http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Noise%20level.png](http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Noise%20level.png)

### 2. USRP1 transmitting at 2.405 GHz ###

![http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20USRP%20TX.png](http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20USRP%20TX.png)

### 3. Marmote transmitting at 2.405 GHz with **FOX924 20 MHz TCXO ([FOX924B-20.000](http://www.foxonline.com/pdfs/fox924.pdf))** ###

The CMOS output of the TCXO is fed to the SmartFusion PLL directly. The 20 MHz PLL output drives the external AFEs.

![http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20MAX924%2020%20MHz%20TCXO%20TX.png](http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20MAX924%2020%20MHz%20TCXO%20TX.png)

### 4. Marmote transmitting at 2.405 GHz with **Connor-Winfield 20 MHz TCXO ([D53G-020.0M](http://www.conwin.com/datasheets/tx/tx239.pdf))** ###

The clipped sine output of the TCXO is fed to the MAX2830 and then the SmartFusion PLL. The 20 MHz PLL output drives the external AFEs.

![http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20Precision%2020%20MHz%20TCXO%20TX.png](http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20Precision%2020%20MHz%20TCXO%20TX.png)

### 5. Marmote transmitting at 2.405 GHz with **Connor-Winfield 26 MHz TCXO ([D53G-026.0M](http://www.conwin.com/datasheets/tx/tx239.pdf))** ###

The clipped sine output of the TCXO is fed to the MAX2830 and then the SmartFusion PLL. The 20 MHz PLL output drives the external AFEs.

![http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20Precision%2026%20MHz%20TCXO%20TX.png](http://marmote.googlecode.com/svn/trunk/hardware/RFWBBoard/Misc/2012-10-19%20-%20Marmote%20Precision%2026%20MHz%20TCXO%20TX.png)

# Remarks #

  * In all cases the signal seems to be approximately 40 dBc clean