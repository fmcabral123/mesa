import mesa_reader as mr
import matplotlib.pyplot as plt
import numpy as np

h = mr.MesaData('LOGS/history.data')
l = mr.MesaLogDir('./LOGS')

plt.plot(h.log_Teff, h.log_L)
plt.xlabel('log $T_{\\text{eff}}$ (K)')
plt.ylabel('log $L/L_{\odot}$')
plt.gca().invert_xaxis()
plt.title("HR Diagram")
plt.savefig("plots/HR.png")
plt.show()

plt.plot(h.log_cntr_Rho, h.log_cntr_T)
plt.ylabel("log $T_c$ (K)")
plt.xlabel("log $\\rho_c \, \mathrm{(g/cm^3)}$")
plt.title("Central Temperature-Density History")
plt.savefig("plots/T_Rho_Hist.png")
plt.show()

p = l.profile_data()

plt.loglog(p.Rho, p.T)
plt.xlabel('$\\rho \, \mathrm{(g/cm^3)}$')
plt.ylabel('$T$ (K)')
plt.title("Temperature-Density Profile")
plt.savefig("plots/T_Rho.png")
plt.show()

plt.plot(p.R, p.Rho)
plt.xlabel("$R/R_{\odot}$")
plt.ylabel('$\\rho \, \mathrm{(g/cm^3)}$')
plt.title("Density Profile")
plt.savefig("plots/Rho.png")
plt.show()

plt.plot(p.R, p.T)
plt.xlabel("$R/R_{\odot}$")
plt.ylabel("$T$ (K)")
plt.title("Temperature Profile")
plt.savefig("plots/T.png")
plt.show()

plt.plot(p.R, p.P)
plt.xlabel("$R/R_{\odot}$")
plt.ylabel("$P \, \mathrm{(g/cm\,s^2)}$")
plt.title("Pressure Profile")
plt.savefig("plots/P.png")
plt.show()

