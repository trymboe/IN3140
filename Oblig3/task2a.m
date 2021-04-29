syms g L1 L2 L3 th2 th3
m1 = 0.3833;
m2 = 0.2724;
m3 = 0.1406;
g = [0;0;-9.81];
g = transpose(g);
rc1 = [0;0;L1/2];
rc2 = [cos(th2)*L2/2; 0 ;L1+sin(th2)*L2/2];
rc3 = [cos(th2)*L2+sin(th3)*L3/2; 0; L1+sin(th2)*L2+cos(th3)*L3/2];

P1 = m1*g*rc1;
P2 = m2*g*rc2;
P3 = m3*g*rc3;


P = P1+P2+P3;

vpa(P, 4)
