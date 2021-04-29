syms I1x I1y I1z I2x I2y I2z I3x I3y I3z th1 th2 th3 qdx qdy qdz L1 L2 L3 qddx qddy qddz g
m1 = 0.3833;
m2 = 0.2724;
m3 = 0.1406;
s1 = sin(th1);
s2 = sin(th2);
s3 = sin(th3);
c1 = cos(th1);
c2 = cos(th2);
c3 = cos(th3);
g = [0;0;-9.81];
g = transpose(g);
s23 = sin(th2*th3);
c23 = cos(th2*th3);

%%task 2a
rc1 = [0;0;L1/2];
rc2 = [cos(th2)*L2/2; 0 ;L1+sin(th2)*L2/2];
rc3 = [cos(th2)*L2+sin(th3)*L3/2; 0; L1+sin(th2)*L2+cos(th3)*L3/2];

P1 = m1*g*rc1;
P2 = m2*g*rc2;
P3 = m3*g*rc3;


P = P1+P2+P3;

vpa(P, 4);

%%task 2b
qdott = [qdx
         qdy
         qdz];
I1 = [I1x 0 0
      0 I1y 0
      0 0 I1z];
I2 = [I2x 0 0
      0 I2y 0
      0 0 I2z];
I3 = [I3x 0 0
      0 I3y 0
      0 0 I3z];

A1 = [1 0 0
       0 1 0
       0 0 1];
%A2 and A3 are z-rotations
A2 = [cos(th2) -sin(th2) 0
       sin(th2) cos(th2) 0
       0 0 1];
A3 = [cos(th3) -sin(th3) 0
       sin(th3) cos(th3) 0
       0 0 1];
R01 = A1;
R02 = R01*A2;
R03 = R02*A3;



%These parts of the jacobian are directly copied from task 1b
Jv3 = [-s1*(L2*c2+L3*c23) -c1*(L2*s2+L3*s23) -c1*(L3*s23)
      c1*(L2*c2+L3*c23) -s1*(L2*s2+L3*s23) -s1*(L3*s23)
      0 (L2*c2+L3*c23) L3*c23];

Jv1 = [ 0 0 0
        0 0 0
        0 0 0];
Jv2 = [-s1*L2*c2 -c1*L2*s2 0
       c1*L2*c2 -s1*L2*s2 0
       0 L2*c2 0];

%These parts of the jacobian are directly copied from task 1b
Jw1 = [0 0 0
       0 0 0
       1 0 0];

Jw2 = [0 s1 0
       0 -c1 0
       1 0 0];

Jw3 = [0 s1 s1
       0 -c1 -c1
      1 0 0];
%Here I calculate the kinetic energy as described in eq 14
k1 =  m1*transpose(Jv1)*Jv1 + transpose(Jw1)*R01*I1*transpose(R01)*Jw1;
k2 =  m2*transpose(Jv2)*Jv2 + transpose(Jw2)*R02*I2*transpose(R02)*Jw2;
k3 =  m3*transpose(Jv3)*Jv3 + transpose(Jw3)*R03*I3*transpose(R03)*Jw3;
K = 1/2*transpose(qdott)*(k1+k2+k3)*qdott;

%% Task 2d


%From equation 15 in the assignment, we can se that D must be equal to the
%sum of k1,k2,k3
D = k1+k2+k3;

%From the lecture slides for dynamics, page 41 we get the an equation for g
%The P is from task 2a
P = - 5.932*L1 - 0.6896*L3*cos(th3) - 2.715*L2*sin(th2);
g1 = diff(P, th1);
g2 = diff(P, th2);
g3 = diff(P, th3);
g = [g1
     g2
     g3];


%The C-matrix formula is also taken from page 41 in the slides for dynamics
q_vector = [th1
            th2
            th3];

C = sym(zeros(3,3));
for k=1:3
    for j=1:3
        for i=1:3
            pt1 = diff(D(k,j), q_vector(i));
            pt2 = diff(D(k,i), q_vector(j));
            pt3 = diff(D(i,j), q_vector(k));
            C(k,j) = C(k,j) + 1/2*(pt1+pt2-pt3);
        end
    end
end


%% Task 2e
%Lastly we will calculate tau from eq 16 in the task
qdottdott = [qddx
         qddy
         qddz];

t = D*qdottdott + C*qdott + g



