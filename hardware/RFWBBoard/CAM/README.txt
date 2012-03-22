RFWBBoard (Joshua) Revision A

PCB DECRIPTION: 90mm x 56mm 
                4 LAYER PCB (.062 inches thickness) FR4
                Smallest line width and spacing 4/4
                Smallest standard drill hole 8 mils
                Components/Silkscreen on both sides
                Double side soldermask
                
PCB STACKUP:

	Stack Layer		Gerber Polarity	Comment	
	-----------		---------------	-------
	 1 (SIGNAL1)		Positive		Component side (signal)
	 2 (GND1)		Positive		Power (GND)
	 3 (SIGNAL2)		Positive		Inner signal layer (signal)
	14 (GND2)		Positive		Power (GND)
	15 (SUPPLy)		Positive		Power (VCC)
	16 (GND3)		Positive		Solder side (signal)



FILES:

RFWBBoard.GTO - Top Silk Screen (component side)
RFWBBoard.GTP - Top Solder paste (cream stencil, component side)
RFWBBoard.GTS - Top Solder stop mask (component side)

RFWBBoard.GTL - Top Copper (component side), Positive Polarity
RFWBBoard.GP1 - Inner Ground plane 1, Positive Polarity
RFWBBoard.IS  - Inner Signal layer, Positive Polarity
RFWBBoard.GP2 - Inner Ground plane 2, Positive Polarity
RFWBBoard.PP  - Inner Supply plane, Positive Polarity
RFWBBoard.GBL - Bottom Copper (solder side), Positive Polarity

RFWBBoard.GBS - Bottom Solder stop mask (solder side)
RFWBBoard.GBP - Bottom Solder paste (cream stencil, solder side)
RFWBBoard.GBO - Bottom Silk Screen (solder side)
RFWBBoard.GML - Board outline
RFWBBoard.gpi - Gerber Report 

RFWBBoard.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
RFWBBoard.dri - NC Drill Report

RFWBBoard.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

RFWBBoard.xy  - Centroid data for SMD components
   
RFWBBoard_BOM.xls	- Bill of materials

RFWBBoard_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
