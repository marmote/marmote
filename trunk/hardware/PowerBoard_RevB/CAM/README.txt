PowerBoard (Yellowstone) Revision B

PCB DECRIPTION: 90mm x 56mm 
                4 LAYER PCB (.062 inches thickness) FR4
                Smallest line width and spacing 4/4
                Smallest standard drill hole 8 mils
                Components/Silkscreen on both sides
                Double side BLACK soldermask
                
PCB STACKUP:

	Stack Layer		Gerber Polarity	Comment	
	-----------		---------------	-------
	1 (Top)			Positive		Component side (signal)
	2 (GND)			Positive		Power (GND)
	3 (SUPPLY)		Positive		Power (VCC)
	16 (Bottom)		Positive		Solder side (signal)



FILES:

PowerBoard_RevB.GTO - Top Silk Screen (component side)
PowerBoard_RevB.GTP - Top Solder paste (cream stencil, component side)
PowerBoard_RevB.GTS - Top Solder stop mask (component side)
PowerBoard_RevB.GTL - Top Copper (component side), Positive Polarity
PowerBoard_RevB.GP1 - Inner Ground plane, Positive Polarity
PowerBoard_RevB.GP2 - Inner Supply plane, Positive Polarity
PowerBoard_RevB.GBL - Bottom Copper (solder side), Positive Polarity
PowerBoard_RevB.GBS - Bottom Solder stop mask (solder side)
PowerBoard_RevB.GBP - Bottom Solder paste (cream stencil, solder side)
PowerBoard_RevB.GBO - Bottom Silk Screen (solder side)
PowerBoard_RevB.GML - Board outline
PowerBoard_RevB.gpi - Gerber Report 

PowerBoard_RevB.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
PowerBoard_RevB.dri - NC Drill Report

PowerBoard_RevB.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

PowerBoard_RevB.xy  - Centroid data for SMD components
   
PowerBoard_RevB_BOM.xls	- Bill of materials

PowerBoard_RevB_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
