*
*******************************************
*
*PMEG045T150EPD
*
*NXP Semiconductors
*
*45V, 15A low VF Trench MEGA Schottky barrier rectifier
*
*
*VRmax     = 45V 
*
*IFmax(AV) = 15A 
*VF        = 430mV @ IF = 15A
*IR        = 420µA @ VR = 45V
*
*
*
*
*
*
*
*
*
*Package pinning does not match Spice model pinning.
*Package: SOT1289 (CFP15)
*
*Package Pin 1: Cathode 
*Package Pin 2: Anode 
* 
*
*
*Extraction date (week/year): 51/2015
*Simulator: SPICE3
*
*******************************************
*#
.SUBCKT PMEG045T150EPD 1 2
R1 1 2 1.2E+006
D1 1 2
+ DIODE1
D2 1 2
+ DIODE2
*
*The resistor R1 and the diode D2 do not reflect 
*physical devices but improve 
*only modeling in the reverse 
*mode of operation.
*
.MODEL DIODE1 D
+ IS = 4E-006
+ N = 1
+ BV = 63.5
+ IBV = 0.027
+ RS = 0.004
+ CJO = 3.38E-009
+ VJ = 1.15
+ M = 0.66
+ FC = 0
+ TT = 0
+ EG = 0.69
+ XTI = 2
.MODEL DIODE2 D
+ IS = 5E-012
+ N = 1
+ RS = 1.2
.ENDS
*
