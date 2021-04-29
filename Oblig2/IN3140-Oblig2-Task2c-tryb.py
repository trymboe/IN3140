import numpy as np
import math
import sympy as sp
from sympy import *
from sympy.matrices import Matrix

np.set_printoptions(suppress=True)

th_1= symbols("th_1")
th_2= symbols("th_2")
th_3= symbols("th_3")

#th_1, th_2, th_3 = [270, 30, 315]
d_1, a_2, a_3 = 100.9, 222.1, 136.2

s_1, s_2, s_3 = np.sin(th_1), np.sin(th_2), np.sin(th_3)
c_1, c_2, c_3 = np.cos(th_1), np.cos(th_2), np.cos(th_3)
a = d = round(c_1*c_2*c_3*a_3 + c_1*c_2*a_2 - c_1*s_2*s_3*a_3)
b = e = round(s_1*c_2*c_3*a_3 + s_1*c_2*a_2 - s_1*s_2*s_3*a_3)
print(-b)
c = round(s_2*c_3*a_3 + s_2*a_2 + a_3*c_2*s_3 + d_1)
f = round(c-d_1)
g = round(a-c_1*c_2*a_2)
h = round(b-c_2*a_2*s_1)
i = round(c+a_2*s_2+d_1)

Jq = np.array([[-b, a, 0, 0, 0, 1], [-c_1*f, -s_1*f, s_1*e+c_1*d, s_1, -c_1, 0], [-c_1*i, -s_1*i, -s_1*h+c_1*g, s_1, -c_1, 0]])
Jq = sp.Matrix(Jq)
print(Jq)