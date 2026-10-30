"""Data for ratingsShrink.asy: shrinkage in a hierarchical beta-binomial model.

Product j has an unknown fraction theta_j of positive reviews,
theta_j ~ Beta(a, b), and k_j of its n_j reviews are positive,
k_j ~ Bin(n_j, theta_j).  We simulate products with between 2 and 2000
reviews, add the lecture's two examples (A: 3 of 3 positive, B: 1840 of
2000), fit (a, b) by maximising the marginal likelihood (empirical Bayes;
the beta-binomial is in closed form) and compute each posterior mean
(a + k_j)/(a + b + n_j).  Writes ratingsShrink_data.asy.
Run:  python ratingsShrink.py && asy ratingsShrink.asy
"""
import numpy as np
from scipy.optimize import minimize
from scipy.special import betaln, gammaln

SEED, J = 3, 28
A_TRUE, B_TRUE = 16.0, 4.0          # population mean 0.8
rng = np.random.default_rng(SEED)
n = np.round(np.exp(rng.uniform(np.log(2), np.log(2000), J))).astype(int)
theta = rng.beta(A_TRUE, B_TRUE, J)
k = rng.binomial(n, theta)
n = np.append(n, [3, 2000])          # products A and B of the slides
k = np.append(k, [3, 1840])


def neg_log_evidence(log_ab):
    a, b = np.exp(log_ab)
    return -np.sum(gammaln(n + 1) - gammaln(k + 1) - gammaln(n - k + 1)
                   + betaln(a + k, b + n - k) - betaln(a, b))


fit = minimize(neg_log_evidence, np.log([2.0, 2.0]), method="Nelder-Mead",
               options=dict(xatol=1e-8, fatol=1e-10, maxiter=4000))
a, b = np.exp(fit.x)
post = (a + k) / (a + b + n)
print(f"a = {a:.2f}, b = {b:.2f}, prior mean {a/(a+b):.3f}, "
      f"pseudo-reviews a+b = {a+b:.1f}")
print(f"A: raw {k[-2]/n[-2]:.3f} posterior {post[-2]:.3f}")
print(f"B: raw {k[-1]/n[-1]:.3f} posterior {post[-1]:.3f}")


def arr(name, xs, fmt):
    return f"{name} = {{" + ", ".join(fmt.format(x) for x in xs) + "};\n"


with open("ratingsShrink_data.asy", "w") as f:
    f.write("// written by ratingsShrink.py -- do not edit\n")
    f.write(arr("int[] n", n, "{}"))
    f.write(arr("int[] k", k, "{}"))
    f.write(arr("real[] post", post, "{:.4f}"))
    f.write(f"real a = {a:.4f};\nreal b = {b:.4f};\n")
