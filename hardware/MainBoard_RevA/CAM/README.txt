MainBoard (Teton) Revision A

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

MainBoard_RevA.GTO - Top Silk Screen (component side)
MainBoard_RevA.GTP - Top Solder paste (cream stencil, component side)
MainBoard_RevA.GTS - Top Solder stop mask (component side)
MainBoard_RevA.GTL - Top Copper (component side), Positive Polarity
MainBoard_RevA.GP1 - Power plane (GND), Positive Polarity
MainBoard_RevA.GI1 - Inner signal layer 1, Positive Polarity
MainBoard_RevA.GI2 - Inner signal layer 2, Positive Polarity
MainBoard_RevA.GP2 - Power plane (D3V3), Positive Polarity
MainBoard_RevA.GBL - Bottom Copper (solder side), Positive Polarity
MainBoard_RevA.GBS - Bottom Solder stop mask (solder side)
MainBoard_RevA.GBP - Bottom Solder paste (cream stencil, solder side)
MainBoard_RevA.GBO - Bottom Silk Screen (solder side)
MainBoard_RevA.GML - Board outline
MainBoard_RevA.gpi - Gerber Report 

MainBoard_RevA.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
MainBoard_RevA.dri - NC Drill Report

MainBoard_RevA.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

MainBoard_RevA.xy  - Centroid data for SMD components
   
MainBoard_RevA_BOM.xls	- Bill of materials

MainBoard_RevA_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
