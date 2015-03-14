# Rev A #

## Errata ##

  * External TCXO is connected to MAX2830 XTAL pin (28) instead of CTUNE pin (29) **(fixed)**
  * Baseband single-ended to differential conversion maps approximately from single-ended [to 0.6V](0.md) to differential [to -0.5V](0.md) (instead of from single-ended [to 3.3V](0.md) to differential [-0.5V to +0.5V] (confirm whether this is what we want)
  * TCXO power supply digital, ground analog **(fixed)**
  * Mark for 1. pin for baluns not visible enough **(fixed)**
  * C105, C106 names covered by vias in documentation **(fixed)**
  * Consider adding a testpoint to the MAX2830 tune pin (similarly to TPTUNE on the MAX2830EVKIT)
  * Add (via) test points for the pins such as CLKOUT, LD)