"""Data for ridgeBV.asy: bias and variance of ridge regression against eta.

Fixed design y = X w* + noise (variance SIGMA2).  In the SVD basis the
ridge estimate of component k has mean s_k^2/(s_k^2+eta) w_k and variance
SIGMA2 s_k^2/(s_k^2+eta)^2, so the expected squared error of the weights,
E|w_hat - w*|^2, splits exactly into
    bias^2   = sum_k (eta/(s_k^2+eta))^2 w_k^2
    variance = sum_k SIGMA2 s_k^2/(s_k^2+eta)^2 .
The singular values run from 3 down to 0.1: the small ones make plain least
squares (eta = 0) very noisy.  A Monte Carlo check is printed.
Writes ridgeBV_data.asy.   Run:  python ridgeBV.py && asy ridgeBV.asy
"""
import numpy as np

SIGMA2 = 1.0
s = np.geomspace(3, 0.1, 10)              # singular values of X
w = np.ones_like(s)                       # true weights in the V basis
eta = np.geomspace(1e-3, 1e2, 200)

S2 = s[None, :] ** 2
E = eta[:, None]
bias2 = ((E / (S2 + E)) ** 2 * w**2).sum(1)
var = (SIGMA2 * S2 / (S2 + E) ** 2).sum(1)
total = bias2 + var
k = np.argmin(total)
print(f"eta=0 variance {SIGMA2 * (1 / s**2).sum():.1f}; "
      f"best eta {eta[k]:.3f}: bias2 {bias2[k]:.2f} var {var[k]:.2f} "
      f"total {total[k]:.2f}")

# Monte Carlo check at the best eta, with an explicit design matrix
rng = np.random.default_rng(0)
m, p = 30, len(s)
U, _ = np.linalg.qr(rng.standard_normal((m, p)))
V, _ = np.linalg.qr(rng.standard_normal((p, p)))
X = U @ np.diag(s) @ V.T
wstar = V @ w
err = []
for _ in range(20000):
    y = X @ wstar + np.sqrt(SIGMA2) * rng.standard_normal(m)
    wh = np.linalg.solve(X.T @ X + eta[k] * np.eye(p), X.T @ y)
    err.append(((wh - wstar) ** 2).sum())
print(f"Monte Carlo E|w_hat - w*|^2 at best eta: {np.mean(err):.2f}")


def arr(name, xs):
    return f"real[] {name} = {{" + ", ".join(f"{x:.5g}" for x in xs) + "};\n"


with open("ridgeBV_data.asy", "w") as f:
    f.write("// written by ridgeBV.py -- do not edit\n")
    f.write(arr("eta", eta) + arr("bias2", bias2) + arr("var", var)
            + arr("total", total))
    f.write(f"real etabest = {eta[k]:.5g};\n")
