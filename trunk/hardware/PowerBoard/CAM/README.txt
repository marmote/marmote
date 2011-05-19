PowerBoard Rev. A

PCB DECRIPTION: 90mm x 56mm 
                4 LAYER PCB (.062 inches thickness) FR4
                Controlled impedances based on the followin 4 layer stackup:
                
                -------------H oz plating to 1 oz finished
                  7630 (8 MIL)
                ======== .039 1/1 oz core
                  7630 (8 MIL)
                --------------H oz plating to 1 oz finished

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

PowerBoard_RevA.GTO - Top Silk Screen (component side)
PowerBoard_RevA.GTP - Top Solder paste (cream stencil, component side)
PowerBoard_RevA.GTS - Top Solder stop mask (component side)
PowerBoard_RevA.GTL - Top Copper (component side), Positive Polarity
PowerBoard_RevA.GP1 - Inner Layer 1, Positive Polarity
PowerBoard_RevA.GP2 - Inner Layer 2, Positive Polarity
PowerBoard_RevA.GBL - Bottom Copper (solder side), Positive Polarity
PowerBoard_RevA.GBS - Bottom Solder stop mask (solder side)
PowerBoard_RevA.GBP - Bottom Solder paste (cream stencil, solder side)
PowerBoard_RevA.GBO - Bottom Silk Screen (solder side)
PowerBoard_RevA.GML - Board outline
PowerBoard_RevA.gpi - Gerber Report 

PowerBoard_RevA.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
PowerBoard_RevA.dri - NC Drill Report

PowerBoard_RevA.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

PowerBoard_RevA.xy  - Centroid data for SMD components
   
PowerBoard_RevA_BOM.xls	- Bill of materials

PowerBoard_RevA_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
