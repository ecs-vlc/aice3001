"""Data for doubleDescent.asy: test error of least squares against the
number of features p, with m = 40 training points.

y = x.beta + noise with D = 100 independent N(0,1) features.  The model uses
the first p features.  For p <= m it is least squares; for p > m there are
infinitely many exact fits and we take the minimum-norm one (np.linalg.lstsq
returns it).  The test error peaks at p = m, where the smallest singular
value of X goes to zero, then falls again.  A ridge fit with small eta is
shown for comparison.  Averaged over TRIALS draws of the training set.
Writes doubleDescent_data.asy.
Run:  python doubleDescent.py && asy doubleDescent.asy
"""
import numpy as np

SEED, D, M, SIGMA, TRIALS, ETA = 0, 100, 40, 0.5, 400, 1.0
rng = np.random.default_rng(SEED)
beta = rng.standard_normal(D) / np.sqrt(D)     # |beta|^2 about 1
ps = np.arange(1, D + 1)
err_mn = np.zeros(len(ps))
err_ridge = np.zeros(len(ps))
for t in range(TRIALS):
    X = rng.standard_normal((M, D))
    y = X @ beta + SIGMA * rng.standard_normal(M)
    for i, p in enumerate(ps):
        Xp = X[:, :p]
        w = np.linalg.lstsq(Xp, y, rcond=None)[0]       # min-norm if p > M
        wr = np.linalg.solve(Xp.T @ Xp + ETA * np.eye(p), Xp.T @ y)
        # test inputs are N(0, I): error = |w - beta_p|^2 + |beta_rest|^2 + noise
        rest = (beta[p:] ** 2).sum() + SIGMA**2
        err_mn[i] += ((w - beta[:p]) ** 2).sum() + rest
        err_ridge[i] += ((wr - beta[:p]) ** 2).sum() + rest
err_mn /= TRIALS
err_ridge /= TRIALS
for p in (1, 10, 20, 30, 38, 40, 42, 50, 70, 100):
    print(p, round(err_mn[p - 1], 3), round(err_ridge[p - 1], 3))


def arr(name, xs):
    return f"real[] {name} = {{" + ", ".join(f"{x:.5g}" for x in xs) + "};\n"


with open("doubleDescent_data.asy", "w") as f:
    f.write("// written by doubleDescent.py -- do not edit\n")
    f.write(f"int m = {M};\nreal eta = {ETA};\n")
    f.write(arr("errMN", err_mn) + arr("errRidge", err_ridge))
