
import numpy as np
import matplotlib.pyplot as plt

from scipy.constants import mu_0
from scipy.optimize import least_squares


# ============================================================
# 1. WINDING PARAMETERS
# ============================================================

wire_d = 0.5e-3          # Bare copper diameter [m]
wire_od = 0.55e-3        # Insulated wire diameter [m]

N_layers = 5
N_turns_layer = 10

mean_turn_length = 20e-3  # Mean length per turn [m]

temperature = 25.0        # Operating temperature [deg C]

f_min = 10e3              # Minimum frequency [Hz]
f_max = 1e6               # Maximum frequency [Hz]
N_points = 201

N_branches = 5


# ============================================================
# 2. COPPER MATERIAL PROPERTIES
# ============================================================

rho_20 = 1.724e-8         # Copper resistivity at 20 deg C [ohm.m]
alpha_cu = 0.00393        # Temperature coefficient [1/deg C]

rho = rho_20 * (
    1 + alpha_cu * (temperature - 20)
)

sigma = 1 / rho
mu = mu_0


# ============================================================
# 3. DC WINDING RESISTANCE
# ============================================================

N_total = N_layers * N_turns_layer

total_wire_length = (
    N_total * mean_turn_length
)

copper_area = np.pi * wire_d**2 / 4

Rdc = rho * total_wire_length / copper_area


# ============================================================
# 4. ROUND-WIRE EQUIVALENT-FOIL PARAMETERS
# ============================================================

# Equivalent square conductor height
h_c = np.sqrt(np.pi) / 2 * wire_d

# Winding height (tightly packed turns)
h_winding = N_turns_layer * wire_od

# Dowell porosity factor
eta = N_turns_layer * h_c / h_winding


# ============================================================
# 5. FREQUENCY VECTOR
# ============================================================

freq = np.logspace(
    np.log10(f_min),
    np.log10(f_max),
    N_points
)

omega = 2 * np.pi * freq


# ============================================================
# 6. DOWELL RESISTANCE CALCULATION
# ============================================================

# Modified penetration ratio
Delta = h_c * np.sqrt(
    np.pi * freq * mu * sigma * eta
)

# Skin-effect function
Fs = (
    np.sinh(2 * Delta) + np.sin(2 * Delta)
) / (
    np.cosh(2 * Delta) - np.cos(2 * Delta)
)

# Proximity-effect function
Fp = (
    np.sinh(Delta) - np.sin(Delta)
) / (
    np.cosh(Delta) + np.cos(Delta)
)

# Total AC resistance factor
FR = Delta * (
    Fs + (2 / 3) * (N_layers**2 - 1) * Fp
)

# Target AC resistance
R_target = Rdc * FR


# ============================================================
# 7. FIVE-SECTION FOSTER RL MODEL
# ============================================================

# Initial guesses for this winding.
# These are optimizer starting values, not fixed results.

R0 = np.array([
    5.908842,
    0.178199,
    0.652838,
    5.413423,
    13.552672
])

fc0 = np.array([
    138904.5,
    555273.2,
    1143007.4,
    1273896.1,
    4370952.7
])

tau0 = 1 / (2 * np.pi * fc0)


# ------------------------------------------------------------
# Model:
#
# R(f) = Rdc + sum[ Ri*(w*taui)^2/(1+(w*taui)^2) ]
#
# Optimization variables:
# log(Ri), log(taui)
# ------------------------------------------------------------

def foster_model(x):

    R = np.exp(x[:N_branches])
    tau = np.exp(x[N_branches:])

    wt = omega[:, None] * tau[None, :]

    branch_resistance = (
        R[None, :] * wt**2 / (1 + wt**2)
    )

    return Rdc + np.sum(
        branch_resistance,
        axis=1
    )


# Relative-error objective in logarithmic form
def objective(x):

    R_model = foster_model(x)

    return np.log(R_model / R_target)


# Initial parameter vector
x0 = np.log(np.concatenate([R0, tau0]))


# Positive parameter bounds
lower_bounds = np.log(np.concatenate([
    np.full(N_branches, 1e-8),
    np.full(N_branches, 1e-9)
]))

upper_bounds = np.log(np.concatenate([
    np.full(N_branches, 100),
    np.full(N_branches, 1e-3)
]))


# Nonlinear least-squares optimization
result = least_squares(
    objective,
    x0,
    bounds=(lower_bounds, upper_bounds),
    max_nfev=10000,
    x_scale="jac"
)


# ============================================================
# 8. EXTRACT RESISTANCES AND INDUCTANCES
# ============================================================

Rac = np.exp(result.x[:N_branches])

tau = np.exp(result.x[N_branches:])

# L = R * tau
Lac = Rac * tau

# Corner frequencies
fc = 1 / (2 * np.pi * tau)

# Sort branches by increasing corner frequency
idx = np.argsort(fc)

Rac = Rac[idx]
Lac = Lac[idx]
tau = tau[idx]
fc = fc[idx]


# ============================================================
# 9. RECONSTRUCT THE FINAL FOSTER MODEL
# ============================================================

R_fit = Rdc + np.sum(
    Rac[None, :] *
    (omega[:, None] * tau[None, :])**2 /
    (1 + (omega[:, None] * tau[None, :])**2),
    axis=1
)

# Relative error
error = (
    (R_fit - R_target) / R_target
) * 100

max_error = np.max(np.abs(error))

rms_error = np.sqrt(np.mean(error**2))


# ============================================================
# 10. PRINT RESULTS
# ============================================================

print("\n========== WINDING PARAMETERS ==========")

print(f"Total turns       : {N_total}")
print(f"Total wire length : {total_wire_length*1e3:.3f} mm")
print(f"Copper area       : {copper_area*1e6:.6f} mm^2")
print(f"Resistivity       : {rho:.9e} ohm.m")
print(f"Conductivity      : {sigma/1e6:.4f} MS/m")
print(f"Equivalent height : {h_c*1e3:.6f} mm")
print(f"Porosity factor   : {eta:.6f}")
print(f"DC resistance     : {Rdc*1e3:.6f} mOhm")


print("\n========== FOSTER RL PARAMETERS ==========")

print(f"{'Branch':<10}{'Rac (ohm)':<18}"
      f"{'Lac (uH)':<18}{'fc (kHz)':<15}")

for i in range(N_branches):

    print(
        f"{i+1:<10}"
        f"{Rac[i]:<18.9f}"
        f"{Lac[i]*1e6:<18.9f}"
        f"{fc[i]/1e3:<15.6f}"
    )


print("\n========== FITTING PERFORMANCE ==========")

print(f"Maximum relative error : {max_error:.9e} %")
print(f"RMS relative error     : {rms_error:.9e} %")

print("\n========== RESISTANCE COMPARISON ==========")

print(f"{'Frequency':<15}{'Dowell (ohm)':<20}"
      f"{'Foster (ohm)':<20}")

test_freq = np.array([
    10e3, 20e3, 50e3, 100e3,
    200e3, 500e3, 1e6
])

for f in test_freq:

    R_d = np.interp(
        np.log10(f),
        np.log10(freq),
        R_target
    )

    R_f = Rdc + np.sum(
        Rac * (2*np.pi*f*tau)**2 /
        (1 + (2*np.pi*f*tau)**2)
    )

    print(
        f"{f/1e3:<15.3f}"
        f"{R_d:<20.9f}"
        f"{R_f:<20.9f}"
    )


# ============================================================
# 11. PLOT 1: DOWELL VS FOSTER RESISTANCE
# ============================================================

plt.figure(figsize=(10, 6))

plt.loglog(
    freq,
    R_target,
    label="Dowell resistance",
    linewidth=2
)

plt.loglog(
    freq,
    R_fit,
    "--",
    label="Five-section Foster model",
    linewidth=2
)

plt.xlabel("Frequency [Hz]")
plt.ylabel("AC Resistance [Ohm]")

plt.title("Dowell vs. Foster RL Model")

plt.grid(True, which="both")
plt.legend()
plt.tight_layout()


# ============================================================
# 12. PLOT 2: RELATIVE FITTING ERROR
# ============================================================

plt.figure(figsize=(10, 5))

plt.semilogx(
    freq,
    error,
    linewidth=1.5
)

plt.axhline(0, linestyle="--", linewidth=1)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Relative Error [%]")

plt.title("Foster Model Fitting Error")

plt.grid(True, which="both")
plt.tight_layout()


# ============================================================
# 13. PLOT 3: INDIVIDUAL BRANCH CONTRIBUTIONS
# ============================================================

plt.figure(figsize=(10, 6))

for i in range(N_branches):

    branch_R = (
        Rac[i] * (2*np.pi*freq*tau[i])**2 /
        (1 + (2*np.pi*freq*tau[i])**2)
    )

    plt.loglog(
        freq,
        branch_R,
        label=f"Branch {i+1}"
    )

plt.loglog(
    freq,
    R_fit - Rdc,
    "k--",
    linewidth=2,
    label="Total additional resistance"
)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Resistance Contribution [Ohm]")

plt.title("Individual Foster RL Branch Contributions")

plt.grid(True, which="both")
plt.legend()
plt.tight_layout()

plt.show()
