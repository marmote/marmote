PowerBoard Revision B

PCB DECRIPTION: 90mm x 56mm 
                4 LAYER PCB (.062 inches thickness) FR4
                Smallest line width and spacing 4/4
                Smallest standard drill hole 8 mils
                Components/Silkscreen on both sides
                Double side soldermask
                
PCB STACKUP:

	Stack Layer		Gerber Polarity	Comment	
	-----------		---------------	-------
	1 (Top)			Positive		Component side (signal)
	2 (Inner 1)		Positive		Power (GND)
	3 (Inner 2)		Positive		Power (VCC)
	4 (Bottom)		Positive		Solder side (signal)



FILES:

PowerBoard.GTO - Top Silk Screen (component side)
PowerBoard.GTP - Top Solder paste (cream stencil, component side)
PowerBoard.GTS - Top Solder stop mask (component side)
PowerBoard.GTL - Top Copper (component side), Positive Polarity
PowerBoard.GP1 - Inner Layer 1, Positive Polarity
PowerBoard.GP2 - Inner Layer 2, Positive Polarity
PowerBoard.GBL - Bottom Copper (solder side), Positive Polarity
PowerBoard.GBS - Bottom Solder stop mask (solder side)
PowerBoard.GBP - Bottom Solder paste (cream stencil, solder side)
PowerBoard.GBO - Bottom Silk Screen (solder side)
PowerBoard.GML - Board outline
PowerBoard.gpi - Gerber Report 

PowerBoard.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
PowerBoard.dri - NC Drill Report

PowerBoard.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

PowerBoard.xy  - Centroid data for SMD components
   
PowerBoard_BOM.xls	- Bill of materials

PowerBoard_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
