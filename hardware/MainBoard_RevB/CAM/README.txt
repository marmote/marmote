MainBoard (Teton) Revision B

PCB DECRIPTION: 90mm x 56mm 
                6 LAYER PCB (.062 inches thickness) FR4
                Smallest line width and spacing 6/4
                Smallest standard drill hole 8 mils
                Components/Silkscreen on both sides
                Double side BLACK soldermask
                
PCB STACKUP:

	Stack Layer		Gerber Polarity	Comment	
	------------	---------------	-------
	 1 (Top)		Positive		Component side (signal)
	 2 (GND)		Positive		Power (GND)
	 3 (Inner 1)	Positive		Inner signal layer 1 (signal)
	14 (Inner 2)	Positive		Inner signal layer 2 (signal)
	15 (D3V3)		Positive		Power (VCC)
	16 (Bottom)		Positive		Solder side (signal)



FILES:

MainBoard_RevB.GTO - Top Silk Screen (component side)
MainBoard_RevB.GTP - Top Solder paste (cream stencil, component side)
MainBoard_RevB.GTS - Top Solder stop mask (component side)
MainBoard_RevB.GTL - Top Copper (component side), Positive Polarity
MainBoard_RevB.GP1 - Power plane (GND), Positive Polarity
MainBoard_RevB.GI1 - Inner signal layer 1, Positive Polarity
MainBoard_RevB.GI2 - Inner signal layer 2, Positive Polarity
MainBoard_RevB.GP2 - Power plane (D3V3), Positive Polarity
MainBoard_RevB.GBL - Bottom Copper (solder side), Positive Polarity
MainBoard_RevB.GBS - Bottom Solder stop mask (solder side)
MainBoard_RevB.GBP - Bottom Solder paste (cream stencil, solder side)
MainBoard_RevB.GBO - Bottom Silk Screen (solder side)
MainBoard_RevB.GML - Board outline
MainBoard_RevB.gpi - Gerber Report 

MainBoard_RevB.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
MainBoard_RevB.dri - NC Drill Report

MainBoard_RevB.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

MainBoard_RevB.xy  - Centroid data for SMD components
   
MainBoard_RevB_BOM.xls	- Bill of materials

MainBoard_RevB_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
