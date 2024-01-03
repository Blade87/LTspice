***********************************************************
*
* PNE20030EP
*
* Nexperia
*
* 200V, 3A hyperfast recovery rectifier
* IFmax = 3A
* VRmax = 200V
* VFmax = 0,98V   @ IF = 3A
* IRmax = 1µA     @ VR = 200V
* 
*
*
* Package pinning does not match Spice model pinning.
* Package: CFP5 (SOD128)
* 
* Package Pin 1: Cathode
* Package Pin 2: Anode
* 
*
*
* Extraction date (week/year): 18/2020
* Simulator: SPICE3
*
***********************************************************
*
* The resistor R1 and the diode D2  
* do not reflect physical devices.
* Instead they improve modeling in the 
* forward and reverse mode of operation.
*
.SUBCKT PNE20030EP 1 2
R1 1 2 2.5E+010
D1 1 2
+ DIODE1
D2 1 2
+ DIODE2
*
.MODEL DIODE1 D
+ IS = 2E-012
+ N = 0.92
+ BV = 259
+ IBV = 6.69E-008
+ RS = 0.7
+ CJO = 8.09E-011
+ VJ = 0.4
+ M = 0.38
+ FC = 0.5
+ TT = 0
+ EG = 1.1
+ XTI = 3
.MODEL DIODE2 D
+ IS = 5E-014
+ N = 0.95
+ RS = 0.04
.ENDS
*