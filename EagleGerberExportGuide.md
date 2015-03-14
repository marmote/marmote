# Generating Gerber Files #

Gerber RS274X is the recommended Gerber format. Use the `IES.cam` CAM job file, found under the CAM directory, to automatically generate the necessary Gerber files.

_Note: See the External Links section for more information on Gerber file format(s)._

# Generating a Pick and Place File #

Use the `IES-pick-place.ulp` scrip in the CAM directory to generate the `.xy` pick and place file.

# Exporting Assembly Drawings #

When printing the board assembly layout into PDF, include the following layers:

## Top view ##
```
  * Dimension
  * tPlace
  * tNames
  * tDocu
  * tStop
  * Pads
  * Vias
```
_Note: Top side silk screen texts and graphics are assumed to reside in the `tPlace` layer._

## Bottom view ##
```
  * Dimension
  * bPlace
  * bNames
  * bDocu
  * bStop
  * Pads
  * Vias
```
_Note: Bottom side silk screen texts and graphics are assumed to reside in the `bPlace` layer._ Print the bottom assembly PDF mirrored.

Either combine the two PDFs into `<ProjectName>_Asy.pdf`, or simply name them `<ProjectName>_AsyT.pdf` and `<ProjectName>_AsyB.pdf` respectively.

# External links #

  * [Eagle CAD design rule files for SunStone PCB fabrication](http://www.sunstone.com/pcb-resources/Downloads.aspx)

  * [What's All This About RS274X Anyway?](http://www.artwork.com/gerber/274x/rs274x.htm)
  * [D-codes, Apertures & Gerber Plot Files](http://www.artwork.com/gerber/appl2.htm)

# BOM #

To export the Bill of Materials, use an advanced ULP script such as bom\_w\_attr\_v1.03.ulp.