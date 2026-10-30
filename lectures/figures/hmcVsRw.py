"""Data for hmcVsRw.asy: random-walk Metropolis against Hamiltonian Monte Carlo.

Target: a 2-D Gaussian with unit variances and correlation RHO, so the
probability lies along a narrow diagonal ridge.  Both samplers start at the
same point in the tail and get about the same amount of work: N_RW
random-walk proposals (one density evaluation each) against N_HMC HMC
iterations of L leapfrog steps (one gradient each).  Writes hmcVsRw_data.asy.
Run:  python hmcVsRw.py && asy hmcVsRw.asy
"""
import numpy as np

SEED, RHO = 2, 0.95
N_RW, STEP = 300, 0.3                # random walk
N_HMC, L, EPS = 15, 20, 0.15         # HMC: 15 x 20 = 300 gradients
START = np.array([-2.5, -1.0])

rng = np.random.default_rng(SEED)
P = np.linalg.inv(np.array([[1, RHO], [RHO, 1]]))   # precision matrix


def U(x):                            # -log pi, up to a constant
    return 0.5 * x @ P @ x


def gradU(x):
    return P @ x


# random-walk Metropolis
x, rw, acc_rw = START.copy(), [START.copy()], 0
for t in range(N_RW):
    y = x + STEP * rng.standard_normal(2)
    if np.log(rng.random()) < U(x) - U(y):
        x, acc_rw = y, acc_rw + 1
    rw.append(x.copy())

# Hamiltonian Monte Carlo
x, hmc, paths, acc_hmc = START.copy(), [START.copy()], [], 0
for t in range(N_HMC):
    p = rng.standard_normal(2)
    H0 = U(x) + 0.5 * p @ p
    q, path = x.copy(), [x.copy()]
    p = p - 0.5 * EPS * gradU(q)     # leapfrog
    for s in range(L):
        q = q + EPS * p
        if s < L - 1:
            p = p - EPS * gradU(q)
        path.append(q.copy())
    p = p - 0.5 * EPS * gradU(q)
    if np.log(rng.random()) < H0 - (U(q) + 0.5 * p @ p):
        x, acc_hmc = q, acc_hmc + 1
    hmc.append(x.copy())
    paths.append(path)

rw, hmc = np.array(rw), np.array(hmc)
print(f"random walk: accepted {acc_rw}/{N_RW}, "
      f"mean of last half {rw[N_RW//2:].mean(0).round(2)}")
print(f"HMC: accepted {acc_hmc}/{N_HMC}, mean {hmc[1:].mean(0).round(2)}")


def pts(name, xs):
    return (f"pair[] {name} = {{" +
            ", ".join(f"({a:.3f},{b:.3f})" for a, b in xs) + "};\n")


with open("hmcVsRw_data.asy", "w") as f:
    f.write("// written by hmcVsRw.py -- do not edit\n")
    f.write(f"real rho = {RHO};\n")
    f.write(f"int accRW = {acc_rw}, nRW = {N_RW};\n")
    f.write(f"int accHMC = {acc_hmc}, nHMC = {N_HMC};\n")
    f.write(pts("rw", rw))
    f.write(pts("hmc", hmc))
    f.write(f"pair[][] paths = new pair[{N_HMC}][];\n")
    for i, path in enumerate(paths):
        f.write(pts(f"paths[{i}]", path).replace("pair[] ", "")
                .replace(" = {", " = new pair[] {"))
