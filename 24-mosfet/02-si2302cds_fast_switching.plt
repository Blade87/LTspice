[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {34668550,0,"I(Rgate)"}
      X: ('n',0,0,2e-09,2e-08)
      Y[0]: ('m',0,-0.4,0.04,0)
      Y[1]: (' ',1,1e+308,0.2,-1e+308)
      Amps: ('m',0,0,0,-0.4,0.04,0)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {34668548,0,"I(Rload)"}
      X: ('n',0,0,2e-09,2e-08)
      Y[0]: (' ',1,-0.2,0.2,2)
      Y[1]: (' ',1,1e+308,0.1,-1e+308)
      Amps: (' ',0,0,1,-0.2,0.2,2)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(signal)"}
      X: ('n',0,0,2e-09,2e-08)
      Y[0]: (' ',1,0,0.5,5)
      Y[1]: (' ',1,1e+308,0.1,-1e+308)
      Volts: (' ',0,0,0,0,0.5,5)
      Log: 0 0 0
      GridStyle: 1
   }
}
