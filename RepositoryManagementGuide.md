# Directory and File Structure #

## Head Revision ##

The PCB related directories and files are stored under `/trunk/hardware/`. Names should use CamelCase. For a project named 'PowerBoard' the main directory should be named simply `PowerBoard`, without any version number or product variation like `PowerBoard with BNC connectors`. '[[FabName](FabName.md)]' should refer to the corresponding fab. Thus, the directory structure should look like as follows:
```
PowerBoard/
  CAM/
    [FabName].cam
    [FabName].dru
    PowerBoard.Gxx   (*1)
    PowerBoard.Dxx   (*1)
    PowerBoard.xy 
    ReadMe.txt
  Datasheet/
  Misc/
  Photo/ 
  Simulation/
  eagle.epf
  Notes.txt
  PowerBoard.brd
  PowerBoard.lbr
  PowerBoard.sch
  PowerBoard_Sch.pdf (*2)
  PowerBoard_Asy.pdf (*2)
  PowerBoard_BOM.xlsx (*2)
```

(`*`1) Gerber Files
| .GTO | Top Silkscreen (tPlace, _tNames_) |
|:-----|:----------------------------------|
| .GTP | Top Paste (tCream) |
| .GTS | Top Soldermask (tStop) |
| .GTL | Top Copper (Top, Pads, Vias) |
| .GP1 | Ground Plane (Route2, Pads, Vias) |
| .GP2 | Power Plane (Route3, Pads, Vias) |
| .GBL | Bottom Copper (Bottom, Pads, Vias) |
| .GBS | Bottom Soldermask (bStop) |
| .GBP | Bottom Paste (bCream) |
| .GBO | Bottom Silkscreen (bPlace, _bNames_) |
| .GML | Board Outline (Dimension) |
| .GPI | Gerber Report (only on the last file) |
| .DRD | NC Drill (Drills, Holes) |
| .DRI | NC Drill Report |
| .GWK | GraphiCode GC-Prevue Project File (Gerbers and drill) |
For all gerber files, use `pos. Coord` and `Optimize` (and nothing else). All signal layers (inner layers too) will have positive polarity.
NC Drill files are in `1.4, Abs, inches, leading zero supress, quad` format.

(`*`2) Note: these files typically generated only for finished board (see revisions)

## Creating a New Revision ##

Major revisions are stored as SVN branches under `/trunk/hardware/`. The 'ProjectName' in the directory and file names are suffixed with `_RevX`, where X is an uppercase letter. That is for a project called 'PowerBoard' that has two major revision the directory structure should follow the pattern below:
```
trunk/
  hardware/
    PowerBoard/
    PowerBoard_RevA/
    PowerBoard_RevB/
```

File names should be adjusted accordingly. That is for a project called 'PowerBoard' the directory containing Rev B:
```
PowerBoard_RevB/
  CAM/
    [FabName].cam
    [FabName].dru
    PowerBoard_RevB.Gxx
    PowerBoard_RevB.Dxx
    PowerBoard_RevB.xy 
    ReadMe.txt
  Datasheet/
  Misc/
  Photo/ 
  Simulation/
  eagle.epf
  Notes.txt
  PowerBoard_RevB.brd
  PowerBoard_RevB.lbr
  PowerBoard_RevB.sch
  PowerBoard_RevB_Sch.pdf
  PowerBoard_RevB_Asy.pdf
  PowerBoard_RevB_BOM.xlsx
```

## Directory and File Details ##

`Document` directory
| `PowerBoard_RevB_Sch.pdf` | `File > Print`, then set printer to `Print to File (PDF)` |
|:--------------------------|:----------------------------------------------------------|
| `PowerBoard_RevB_Asy.pdf` |  Create a two-page (top and bottom) document with the following layers:<p>  <code>tPlace, tNames, tDocu, tStop, Dimension, Document</code><br>  <code>bPlace, bNames, bDocu, bStop, Dimension, Document</code> 