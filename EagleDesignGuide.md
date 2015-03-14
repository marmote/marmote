The Marmote project uses a multi-board platform. The printed circuit boards (PCBs) are created in [CadSoft EAGLE](http://www.cadsoftusa.com/) according the following rules:



# Library Components #

## Package ##

  1. Create new package (package names should come from the datasheet or follow standard naming, e.g. IPC)
  1. Set the grid based on the pin pitch of the device
  1. Set pad dimensions (the roundness can be changed later with the DRC)
  1. Calculate pad center coordinates X and Y
  1. Place the pads in sequence on the top layer using the console command `(X Y)`
  1. In the _Options > Set > Misc_ menu select _Display pad name_
  1. Make sure that the names of the pads are in order (1, 2, etc.)
  1. Draw essential information (pin<sub>1</sub> designator) on tPlace using 8 mil or 4 mil thickness (Do not cover areas on the silkscreen that are to be soldered!)
  1. Draw additional information on tDocu (not on silkscreen)
  1. Place '>NAME' label on tNames using proportional font, 16 mil height, 8% width (will not be on silkscreen, but assembly drawing)
  1. Place '>VALUE' label on tValues using vector font, 16 mil height, 8% width (will not be on silkscreen)
  1. OPTIONAL layers:
    * tPlace
      1. Mark pin #1 with a dot (circle)
      1. Optionally draw package outline that doesn't cross metallic parts
    * tDocu (optional)
      1. Chip outline
      1. Pins
    * Holes:       mounting holes
    * tRestrict: define area (RECT) without tracks (copper), e.g. around mounting holes, underneath metalic components, etc.
    * tKeepout:  define area (RECT) as big as the physical component (prevent overlapping components)
  1. In case of exposed pads under the chip, reduce the solder paste area
  1. Add description:
```
<b>FOOTPRINT NAME</b>
<p>
Textual description
<p>
Source: URL
```

External links:

  * [QFN and DFN Layout Guidelines](http://i.screamingcircuits.com/docs/QFN%20Layout%20Guidelines.pdf)

## Symbol ##

  1. Create new symbol (symbol name can be the same as device/part name)
  1. Use 100 mil grid
  1. Place pins: length short, visible both, function as desired
| **Name** | **Description** | **ERC** |
|:---------|:----------------|:--------|
| NC  | Not connected | A not connected pin |
| In | Input | A net connected to this pin and not only In pins connected to this net |
| Out | Output | Not only Out pins connected to the net, no Sup or OC pin at the same net |
| I/O | Input/output | No checks |
| OC  | Open Collector or Open Drain | No Out pin at the same net |
| Hiz | High impedance output | No checks |
| Pas | Passive (resistors, etc.) | No checks |
| Pwr | Power pin (power supply input) | A Sup pin set for this net |
| Sup | Power supply output for ground and supply symbols | ? |

  1. Add pin names
  1. Use WIRE on the Symbols layer to draw circuit symbol
  1. Place '>NAME' label on Names using proportional font, 70 mil height, 10% width
  1. Place '>VALUE' label on Values using proportional font, 70 mil height, 10% width

## Device ##

  1. Create new device (same as device/part name)
  1. Add symbol
  1. Make sure Addlevel=Next and a Swaplevel=0 (unless...)
  1. Select package and SPECIFY VARIANT NAME (will become part name suffix).
  1. OPTIONAL: you can specify technologies (per variants). These will become part of the part number (no other effect)
  1. Connect pins and pads
  1. Specify prefix (U for ICs, R, C, L, B (beads), D (diodes), X (quartz), J (connectors), JP (jumpers), TP (test points))
  1. Value
    * editable: ON (resistors, capacitors, inductors) or
    * non-editable: OFF(part name + tech name will be the value)
  1. Add descritpion:
```
<b>DEVICE NAME</b>
<p>
Textual description
<p>
Source: url
```

  1. Reference designator prefixes

| **Prefix** | **Device type** |
|:-----------|:----------------|
| C   | Capacitor |
| J   | Connector |
| X   | Crystal or crystal oscillator |
| D   | Diode |
| S   | ESD discharge strip |
| F   | Fuse |
| GP  | Ground test point |
| L   | Inductor |
| U   | Integrated circuit |
| JP  | Jumper |
| M   | Mechanical mounting hole |
| SW  | Mechanical switch |
| R   | Resistor |
| RP or R | Resistor pack/network |
| TP  | Test point |
| TF  | Transformer |
| Q   | Transistor |
| LED | Led |
| B   | Ferrite bead |


# Schematic #

TBD

# Layout #

## Silk screen ##
| small labels (refdes) | vector, 50 mil, 8% |
|:----------------------|:-------------------|
| large labels (conns) |  vector, 70 mil, 10% |
| very large labels | inverse text with bold fonts and capitals (looks nice) |

## Layers ##

[TBD](TBD.md)


## General PCB design notes ##

  * http://www.sparkfun.com/tutorials
  * http://www.sparkfun.com/tutorials/115
  * http://www.sparkfun.com/tutorial/Eagle-DFM/Eagle%20Rules.pdf
  * http://www.opencircuits.com/SFE_Footprint_Library_Eagle
  * http://www.alternatezone.com/electronics/files/PCBDesignTutorialRevA.pdf
  * http://www.youtube.com/watch?v=VXE_dh38HjU
  * Complete PCB design using OrCAD Capture and PCB editor / Kraig Mitzner (Ch1, Ch5, Ch6)

# Logo #

Note: This logo design guide uses 360x360 pixel input bitmap to create 10x10 mm PCB logo and 600x600 mil schematic logo.

  1. Create the logo design and save it as a 360x360 pixel B/W 1-bit bitmap

## Schematic symbol ##

  1. In EAGLE create a new Symbol
  1. Type 'RUN' to run a ULP script
  1. Select the bitmap file in the file dialog
  1. Select both colors in the pop-up dialog
  1. Select:
    * Format: Scaled
    * Unit: Mil
    * Scale: 1.6667 (600/360)
    * Start layer: 200
  1. Delete the small text in the lower-left corner
  1. Use Change > Layer to move the desired layer (200 or 201) to the symbol layer

## PCB footprint ##

  1. In EAGLE create a new Package
  1. Type 'RUN' to run a ULP script
  1. Select the bitmap file in the file dialog
  1. Select both colors in the pop-up dialog
  1. Select:
    * Format: Scaled
    * Unit: MM
    * Scale: 0.0277 (10/360)
    * Start layer: 200
  1. Delete the small text in the lower-left corner
  1. For PCBs with green stopmask
    * Use Change > Layer to move the desired inverse layer (200 or 201) to the Top layer
    * Draw a rectangular line around the Design in tRestrict
  1. For PCBs with black stopmask and gold finish
    * Use Change > Layer to move the desired inverse layer (200 or 201) to the tStop layer
  1. Fill out the Description field

# Gerber file export #

  1. Run File > CAM Processor
  1. Use the .cam job file found under the CAM directory
  1. Run the jobs and export the files under the CAM directory

For details see EagleGerberExportGuide.