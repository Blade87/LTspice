# Reference: Round Wire ac Resistance Calculator
# https://chemandy.com/calculators/round-wire-ac-resistance-calculator.htm

import numpy as np

d = 0.812                       # diameter [mm], e.g. 20 AWG = 0.812mm
rho = 1.678e-8                  # Resistivity [Ω.m], e.g. copper = 1.678 * 10^(-8)
f = 200.0e3                     # Frequency [Hz]
mu_0 = 4.0 * np.pi * 10**-7     # Permeability constant [H/m]
mu_r = 0.999991                 # Relative permeability, e.g. copper = 0.999994
mu = mu_0 * mu_r                # Absolute permeability

# Conductor radius
r = d/2.0

# Skin depth
delta = np.sqrt(rho / (np.pi * f * mu))
print(f"Skin Depth = {delta*1e6:{0}.{5}} [um]")

# First equation
Aeff1 = delta * np.pi * d
print(f"Effective Area (1) = {Aeff1*1e6:{0}.{5}} [mm^2]")

# Second equation
Aeff2 = (np.pi * r**2) - np.pi * (r - delta)**2
print(f"Effective Area (2) = {Aeff2*1e6:{0}.{5}} [mm^2]")

# Third equation
delta_prime = delta *(1 - np.exp(-r/delta))
Z = 0.62006 * r / delta
Y = 0.189774 / (1+0.272481*(Z**1.82938 - Z**-0.99457)**2)**1.0941
Aeff3 = np.pi * (2*r*delta_prime - delta_prime**2)*(1+Y)
print(f"Effective Area (3) = {Aeff3*1e6:{0}.{5}} [mm^2]")

# Wire length
l = 1000        # Length [mm]

Rsk = rho * l / Aeff3
print(f"R(skin effect + DC) = {Rsk*1000.0:{0}.{5}} [mΩ]")
