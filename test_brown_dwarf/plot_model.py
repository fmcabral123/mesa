import numpy as np
import matplotlib.pyplot as plt

# Load the data
data = np.loadtxt('model_output.txt', skiprows=1)
r = data[:, 0]
P = data[:, 1]
T = data[:, 2]
rho = data[:, 3]

# Plotting with subplots in a single row
fig, axes = plt.subplots(1, 3, figsize=(18, 6))
fig.suptitle('Target mass = $7 \\times 10^{18}$ g, Target radius = $7 \\times 10^8$ cm', fontsize=16)

# Temperature vs Radius
axes[0].plot(r, T, color='blue')
axes[0].set_xlabel('Radius (r) [cm]')
axes[0].set_ylabel('Temperature (T) [K]')
axes[0].set_title('Temperature vs Radius')
axes[0].set_ylim(-0.05*max(T), 1.05*max(T))  # Set y-axis limit to start at 0 K

# Pressure vs Radius
axes[1].plot(r, P, color='green')
axes[1].set_xlabel('Radius (r) [cm]')
axes[1].set_ylabel('Pressure (P) [Ba]')
axes[1].set_title('Pressure vs Radius')

# Density vs Radius
axes[2].plot(r, rho, color='red')
axes[2].set_xlabel('Radius (r) [cm]')
axes[2].set_ylabel('Density (ρ) [g/cm³]')
axes[2].set_title('Density vs Radius')

plt.tight_layout(rect=[0, 0, 1, 0.95])  # Adjust layout to fit title
plt.savefig("test_model_7d18_7d8.png")
plt.show()
