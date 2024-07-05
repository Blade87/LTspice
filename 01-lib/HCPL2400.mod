* Copyright 2016 Broadcom Limited. All Right Reserved
*
* HCPL-2400 Spice Macromodel
* Rev.A 
* 05/16
* LSP
* 
* Macro model performance matches the typical datasheet specifications 
*     - SPICE Model is verified by Orcad PSpice at Ta=25^C. Compatible to LTSPICE.
*     - Macro model performance matches the typical datasheet specifications 
*     - Worst case performance are not modeled. 
*
* Macromodels provided by Broadcom Limited are not warranted
* as fully representing all of the specification and operating 
* characteristics of the product.
*
* Macromodels are useful for evaluating product performance but they
* cannot model exact device performance under all condition, nor are
* they intented to replace breadboarding for final verification.
**
**********************************************************************
* 		  Pin configuration
*                 1  2  3  4  5    6  7	 8
*                 |  |  |  |  |    |  |	 |	
.subckt hcpl-2400 NC an ca NC agnd Vo VE VCC
E1 N008 N009 N006 N007 {CTR}
XX2 N008 N009 agnd N005 pdnoc
XX1 an ca N007 N006 xled
I1 agnd N005 0.1u
XX3 N005 VFon agnd tia
E2 N001 agnd VCC agnd 1
XX5 N003 N002 agnd N001 inv
XX6 N002 agnd N003 N001 st
XX7 VFon agnd N004 VCC st
XX4 N004 VE Vo agnd VCC and2
R1 VCC agnd 400
.ends hcpl-2400

.subckt pdnoc LOPP LOPN AN CA
D1 AN CA PDC
G1 CA AN LOPP LOPN 0.0026
V1 LOPN AN 0
.model PDC D RS=1.0E-3 CJO=0.015p M=0.333 VJ=0.75 ISR=100.0E-12 BV=100 TT=10E-12
.ends pdnoc

.subckt xled AN CA LOPN LOPP
RSERIES AN 5 5
DELECT 5 CA XLEDNOR
ELED 6 LOPN 5 CA 1
DOPTIC 6 8 XLEDNORC
FPHOTO LOPN 3 VSENSE 1
VSENSE 8 LOPN 0
RL 3 LOPN 0.1
EOUT LOPP LOPN 3 LOPN 60
VSIM LOPN CA 0
Rnl 6 N001 5k
Vnl N002 LOPN 0
Fnl 3 LOPN Vnl 1
Dsw N001 N002 DSW
.model DSW D Is=1e-4
.model XLEDNOR D IS=330E-21 N=1.33 XTI=3 EG=1.52 BV=4.83 IBV=10u
+  CJO=35p VJ=.75 M=.3333 FC=.5 TT=10n
.model XLEDNORC D IS=330E-21 N=1.33 XTI=3 EG=1.52 BV=4.83 IBV=10u
+  CJO=0 VJ=.75 M=.3333 FC=.5 TT=0
.ends xled

.subckt tia in out agnd
G2 agnd out agnd in 0.1
R1 N004 in 25K
C1 out in 0.1p
D1 P001 in D
R2 out N004 25K
C2 N005 agnd 0.05p
R3 N005 N004 20K
D2 N001 P001 D
D3 N002 N001 D
D4 N003 N002 D
D5 out N003 D
.ends tia

.subckt inv A Y VEE VCC
Q1A N006 N003 N005 0 NPNMOD1
R1 N003 VCC 6k
R6 N001 VCC 130
R3 N002 VCC 6.4k
Q4 N002 N006 N007 0 NPNMOD1
R5 VEE N007 1k
Q6 Y N007 VEE 0 NPNMOD1
D1 N004 Y D
Q5 N001 N002 N004 0 NPNMOD1
D3 VEE N005 D
R2 A N005 50
.MODEL NPNMOD1 NPN IS=2.06E-16 VAF=92.2 NF=1.03
+      BF=500 ISE=5.990E-17
+      NE=1.1 IKF=9.568E-3 RE=0 RC=0 RB=0 IRB=30.88U 
+      BR=100 ISC=8.844E-16 NR=1.005 VAR=2.872 NC=1.1 IKR=5.201E-3
+      CJE=1p MJE=.7278 VJE=.9627 CJC=1P MJC=.3924 VJC=.580
+      CJS=1p MJS=.1387 VJS=.3757 FC=.5 XTB=1.52 TR=.116E-10
+      XCJC=.35 TF=.116E-10 PTF=46.26 XTF=213.8 VTF=.568 ITF=113.2E-3
.ends inv

.subckt st Vi V- Vo V+
Q1 N001 N003 N004 0 NPNMOD2
Q2 Vo N002 N004 0 NPNMOD2
R1 N002 N001 4k
R2 V- N002 8k
RE V- N004 0.1k
RC1 N001 V+ 2.2k
RC2 Vo V+ 100k
RB N003 Vi 100
.MODEL NPNMOD2 NPN IS=2.06E-17 VAF=92.2 NF=1.01
+      BF=500 ISE=5.990E-18
+      NE=1.308 IKF=9.568E-3 RE=0 RC=0 RB=0 IRB=30.88U 
+      BR=1000 ISC=8.844E-16 NR=1.005 VAR=2.872 NC=1.1 IKR=5.201E-3
+      CJE=0.01P MJE=.7278 VJE=.9627 CJC=0.01P MJC=.3924 VJC=.580
+      CJS=0.5P MJS=.1387 VJS=.3757 FC=.5 XTB=1.52 TR=1.5E-8
+      XCJC=.35 TF=.116E-10 PTF=46.26 XTF=213.8 VTF=.568 ITF=113.2E-3
.ends st

.subckt and2 A B Y VEE VCC
Q1A N006 N003 N004 0 NPNMOD1
R1 N003 VCC 6k
R6 N001 VCC 130
R3 N002 VCC 1.1k
Q4 N002 N006 N010 0 NPNMOD1
R5 VEE N010 1k
Q6 N007 N010 N011 0 NPNMOD3
Q5 N001 N002 N005 0 NPNMOD2
D2 VEE N004 D
R2 A N004 50
R8 VEE N011 25
D1 N005 N007 D
S1 N007 Y N008 N009 SW1
V1 N009 VEE 1.5
R9 N008 B 50
.MODEL NPNMOD1 NPN IS=2.06E-16 VAF=92.2 NF=1.03
+      BF=50 ISE=5.990E-17
+      NE=1.1 IKF=9.568E-3 RE=0 RC=0 RB=0 IRB=30.88U 
+      BR=100 ISC=8.844E-16 NR=1.005 VAR=2.872 NC=1.1 IKR=5.201E-3
+      CJE=1p MJE=.7278 VJE=.9627 CJC=1P MJC=.3924 VJC=.580
+      CJS=1p MJS=.1387 VJS=.3757 FC=.5 XTB=1.52 TR=.116E-10
+      XCJC=.35 TF=.116E-10 PTF=46.26 XTF=213.8 VTF=.568 ITF=113.2E-3
.MODEL NPNMOD2 NPN IS=2.06E-16 VAF=92.2 NF=0.98
+      BF=50 ISE=5.990E-17
+      NE=1.1 IKF=9.568E-3 RE=0 RC=0 RB=0 IRB=30.88U 
+      BR=100 ISC=8.844E-16 NR=1.005 VAR=2.872 NC=1.1 IKR=5.201E-3
+      CJE=1p MJE=.7278 VJE=.9627 CJC=1p MJC=.3924 VJC=.580
+      CJS=1p MJS=.1387 VJS=.3757 FC=.5 XTB=1.52 TR=.116E-11
+      XCJC=.35 TF=.116E-11 PTF=46.26 XTF=213.8 VTF=.568 ITF=113.2E-3
.MODEL NPNMOD3 NPN IS=2.06E-13 VAF=92.2 NF=1.03
+      BF=50 ISE=5.990E-17
+      NE=1.1 IKF=9.568E-3 RE=0 RC=0 RB=0 IRB=30.88U 
+      BR=100 ISC=8.844E-16 NR=1.005 VAR=2.872 NC=1.1 IKR=5.201E-3
+      CJE=1p MJE=.7278 VJE=.9627 CJC=1p MJC=.3924 VJC=.580
+      CJS=1p MJS=.1387 VJS=.3757 FC=.5 XTB=1.52 TR=.116E-11
+      XCJC=.35 TF=.116E-11 PTF=46.26 XTF=213.8 VTF=.568 ITF=113.2E-3
.MODEL SW1 VSWITCH(Ron=100MEG Roff=1m Von=1m Voff=0)
.ends and2

.model D D

.param CTR=0.5
