[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {34603011,0,"Ic(Q1)"}
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',0,-0.36,0.03,0.03)
      Y[1]: ('m',0,1e+308,0.03,-1e+308)
      Amps: ('m',0,0,0,-0.36,0.03,0.03)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(pulse)"}
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',1,0,0.5,5)
      Y[1]: ('m',0,1e+308,0.03,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5)
      Log: 0 0 0
      GridStyle: 1
   }
}