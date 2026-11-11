"""Data for co2GP.asy: a Gaussian process fitted to atmospheric CO2.

Data: monthly mean CO2 at Mauna Loa, co2_mm_mlo.txt (NOAA GML, with Scripps
data before 1974; downloaded 2026-11-11 from
gml.noaa.gov/webdata/ccgg/trends/co2/co2_mm_mlo.txt).

We train on 1958-2004, forecast 2005-2030 and compare with what was
measured.  r = t - t' in years; the kernel is a sum of
    smooth    s1^2 exp(-r^2/(2 l1^2))
    seasonal  s2^2 exp(-r^2/(2 l2^2) - 2 sin^2(pi r)/l3^2)   (period 1 year)
    wiggles   s3^2 exp(-r^2/(2 l4^2))
    noise     sn^2 [r = 0]
and, for model B only, a quadratic trend with uncertain coefficients,
    trend     c0^2 + c1^2 u u' + c2^2 (u u')^2,   u = (t - 1980)/30
(a polynomial kernel: Bayesian linear regression on 1, u, u^2).
Model A has only the constant mean of the training data: far from the
data it returns to that mean.  The hyperparameters (in log form) maximise
    log p(y|phi) = -y^T C^{-1} y/2 - log|C|/2 - (n/2) log(2 pi)
from four starts.  Writes co2GP_data.asy.
Run:  python co2GP.py && asy co2GP.asy     (about two minutes)
"""
import numpy as np
from scipy.optimize import minimize

SEED, T_SPLIT, T_END = 0, 2005.0, 2030.0
d = np.loadtxt("co2_mm_mlo.txt", comments="#")
t_all, y_all = d[:, 2], d[:, 3]
train = t_all < T_SPLIT
t, y = t_all[train], y_all[train]
ybar = y.mean()
y0 = y - ybar
NAMES = ["s1", "l1", "s2", "l2", "l3", "s3", "l4", "sn", "c0", "c1", "c2"]


def kernel(a, b, p, noise=False):
    """p holds 8 log hyperparameters, or 11 with the quadratic trend."""
    s1, l1, s2, l2, l3, s3, l4, sn = np.exp(p[:8])
    r = a[:, None] - b[None, :]
    K = (s1**2 * np.exp(-r**2 / (2 * l1**2))
         + s2**2 * np.exp(-r**2 / (2 * l2**2) - 2 * np.sin(np.pi * r)**2 / l3**2)
         + s3**2 * np.exp(-r**2 / (2 * l4**2)))
    if len(p) > 8:
        c0, c1, c2 = np.exp(p[8:])
        uu = np.outer((a - 1980) / 30, (b - 1980) / 30)
        K += c0**2 + c1**2 * uu + c2**2 * uu**2
    if noise:
        K += sn**2 * np.eye(len(a))
    return K


def neg_log_evidence(p):
    try:
        L = np.linalg.cholesky(kernel(t, t, p, noise=True))
    except np.linalg.LinAlgError:
        return 1e10
    alpha = np.linalg.solve(L.T, np.linalg.solve(L, y0))
    return (0.5 * y0 @ alpha + np.log(np.diag(L)).sum()
            + 0.5 * len(t) * np.log(2 * np.pi))


def fit_and_predict(label, start):
    rng = np.random.default_rng(SEED)
    best = None
    for k in range(4):
        p0 = start + (0 if k == 0 else 0.5 * rng.standard_normal(len(start)))
        res = minimize(neg_log_evidence, p0, method="L-BFGS-B")
        if best is None or res.fun < best.fun:
            best = res
    p = best.x
    print(f"--- {label}: log evidence {-best.fun:.1f}")
    print("   " + ", ".join(f"{n} = {v:.3g}" for n, v in zip(NAMES, np.exp(p))))
    # predictions, including the noise (the band is for a new measurement)
    L = np.linalg.cholesky(kernel(t, t, p, noise=True))
    Ks = kernel(ts, t, p)
    alpha = np.linalg.solve(L.T, np.linalg.solve(L, y0))
    mean = Ks @ alpha + ybar
    v = np.linalg.solve(L, Ks.T)
    var = np.diag(kernel(ts, ts, p)) - (v**2).sum(0) + np.exp(p[7])**2
    sd = np.sqrt(np.maximum(var, 0))
    test = ~train
    pm = np.interp(t_all[test], ts, mean)
    psd = np.interp(t_all[test], ts, sd)
    inside = np.abs(y_all[test] - pm) <= 2 * psd
    rmse = np.sqrt(np.mean((y_all[test] - pm)**2))
    i25 = np.argmin(np.abs(ts - 2025.0))
    print(f"   test 2005-: {test.sum()} months, RMSE {rmse:.2f} ppm, "
          f"{100 * inside.mean():.0f}% inside the 2-sd band; "
          f"Jan 2025: {mean[i25]:.1f} +- {2 * sd[i25]:.1f} ppm")
    return mean, sd


ts = np.arange(1958.0, T_END + 1e-9, 1 / 12)
# starting values in ppm and years, from looking at the data
muA, sdA = fit_and_predict("A: constant mean",
                           np.log([30, 50, 3, 50, 1, 0.5, 1, 0.3]))
muB, sdB = fit_and_predict("B: with a quadratic trend",
                           np.log([1, 1, 3, 50, 1, 0.5, 1, 0.3, 30, 30, 10]))
test = ~train
print(f"measured Jan 2025: {y_all[np.argmin(np.abs(t_all - 2025.04))]:.1f} ppm")


def arr(name, xs, fmt="{:.4f}"):
    return f"real[] {name} = {{" + ", ".join(fmt.format(x) for x in xs) + "};\n"


with open("co2GP_data.asy", "w") as f:
    f.write("// written by co2GP.py -- do not edit\n")
    f.write(arr("tTrain", t) + arr("yTrain", y))
    f.write(arr("tTest", t_all[test]) + arr("yTest", y_all[test]))
    f.write(arr("ts", ts) + arr("muA", muA) + arr("sdA", sdA)
            + arr("muB", muB) + arr("sdB", sdB))
    f.write(f"real tSplit = {T_SPLIT};\n")
