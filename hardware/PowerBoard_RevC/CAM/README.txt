PowerBoard (Yellowstone) Revision C

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

PowerBoard_RevC.GTO - Top Silk Screen (component side)
PowerBoard_RevC.GTP - Top Solder paste (cream stencil, component side)
PowerBoard_RevC.GTS - Top Solder stop mask (component side)
PowerBoard_RevC.GTL - Top Copper (component side), Positive Polarity
PowerBoard_RevC.GP1 - Inner Ground plane, Positive Polarity
PowerBoard_RevC.GP2 - Inner Supply plane, Positive Polarity
PowerBoard_RevC.GBL - Bottom Copper (solder side), Positive Polarity
PowerBoard_RevC.GBS - Bottom Solder stop mask (solder side)
PowerBoard_RevC.GBP - Bottom Solder paste (cream stencil, solder side)
PowerBoard_RevC.GBO - Bottom Silk Screen (solder side)
PowerBoard_RevC.GML - Board outline
PowerBoard_RevC.gpi - Gerber Report 

PowerBoard_RevC.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
PowerBoard_RevC.dri - NC Drill Report

PowerBoard_RevC.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

PowerBoard_RevC.xy  - Centroid data for SMD components
   
PowerBoard_RevC_BOM.xls	- Bill of materials

PowerBoard_RevC_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
