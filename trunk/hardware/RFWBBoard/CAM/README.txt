RFWBBoard (Joshua) Revision B

PCB DECRIPTION: 90mm x 56mm 
                4 LAYER PCB (.062 inches thickness) FR4
                Smallest line width and spacing 4/4
                Smallest standard drill hole 8 mils
                Components/Silkscreen on both sides
                Double side BLACK soldermask
                
                CONTROLLED IMPEDANCE: 50 Ohm traces to X4, X5, X6, X7, TX/RX, RX
                
PCB STACKUP:

	Stack Layer		Gerber Polarity	Comment	
	-----------		---------------	-------
	 1 (SIGNAL1)	Positive		Component side (signal)
	 2 (GND1)		Positive		Power (GND)
	 3 (SIGNAL2)	Positive		Inner signal layer (signal)
	14 (GND2)		Positive		Power (GND)
	15 (SUPPLy)		Positive		Power (VCC)
	16 (GND3)		Positive		Solder side (signal)



FILES:

RFWBBoard_RevB.GTO - Top Silk Screen (component side)
RFWBBoard_RevB.GTP - Top Solder paste (cream stencil, component side)
RFWBBoard_RevB.GTS - Top Solder stop mask (component side)

RFWBBoard_RevB.GTL - Top Copper (component side), Positive Polarity
RFWBBoard_RevB.GP1 - Inner Ground plane 1, Positive Polarity
RFWBBoard_RevB.IS  - Inner Signal layer, Positive Polarity
RFWBBoard_RevB.GP2 - Inner Ground plane 2, Positive Polarity
RFWBBoard_RevB.PP  - Inner Supply plane, Positive Polarity
RFWBBoard_RevB.GBL - Bottom Copper (solder side), Positive Polarity

RFWBBoard_RevB.GBS - Bottom Solder stop mask (solder side)
RFWBBoard_RevB.GBP - Bottom Solder paste (cream stencil, solder side)
RFWBBoard_RevB.GBO - Bottom Silk Screen (solder side)
RFWBBoard_RevB.GML - Board outline
RFWBBoard_RevB.gpi - Gerber Report 

RFWBBoard_RevB.DRD - NC Drill : 1.4, Abs, inches, leading zero supress, quad
RFWBBoard_RevB.dri - NC Drill Report

RFWBBoard_RevB.gwk - GraphiCode GC-Prevue Project File (Gerbers and drill)

RFWBBoard_RevB.xy  - Centroid data for SMD components
   
RFWBBoard_RevB_BOM.xls	- Bill of materials

RFWBBoard_RevB_Asy.pdf	- Board assembly drawing


QUESTIONS?

  Please contact Peter Volgyesi <peter.volgyesi@vanderbilt.edu>
  at 615.294.6520 with any problems or questions
