[Transient Analysis]
{
   Npanes: 3
   Active Pane: 2
   {
      traces: 1 {524294,0,"V(vin,source)*Id(M1)+V(gate,source)*Ig(M1)"}
      X: ('m',0,0,0.001,0.01)
      Y[0]: (' ',1,-0.6,0.6,6.6)
      Y[1]: (' ',1,1e+308,0.7,-1e+308)
      Units: "W" (' ',0,0,1,-0.6,0.6,6.6)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {34603012,0,"I(Rload)"}
      X: ('m',0,0,0.001,0.01)
      Y[0]: (' ',1,-0.2,0.2,2)
      Y[1]: (' ',1,1e+308,0.2,-1e+308)
      Amps: (' ',0,0,1,-0.2,0.2,2)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524290,0,"V(signal)"} {589827,0,"V(gate,source)"}
      X: ('m',0,0,0.001,0.01)
      Y[0]: (' ',1,-3.2,0.8,5.6)
      Y[1]: (' ',1,1e+308,0.7,-1e+308)
      Volts: (' ',0,0,1,-3.2,0.8,5.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
