import numpy as np
import math

L1 = 100.9
L2 = 222.1
L3 = 136.2
angles = [270, 30, -45]

def forward_k(angles):
    t_1, t_2, t_3 = angles
    c_1 = math.cos(np.deg2rad(t_1))
    c_2 = math.cos(np.deg2rad(t_2))
    c_3 = math.cos(np.deg2rad(t_3))
    s_1 = math.sin(np.deg2rad(t_1))
    s_2 = math.sin(np.deg2rad(t_2))
    s_3 = math.sin(np.deg2rad(t_3))


    d_1 = L1
    a_2 = L2
    a_3 = L3
    #I use the last column of the forward kinematics-matrix from oblig 1
    T_03 = np.array([c_1*c_2*c_3*a_3 + c_1*c_2*a_2 - c_1*a_3*s_2*s_3,
    c_2*c_3*a_3*s_1 + c_2*a_2*s_1 - a_3*s_1*s_2*s_3,
    c_3*a_3*s_2 + a_2*s_2 + d_1 + c_2*a_3*s_3])

    return T_03

def invers_k(point):
    d_1 = L1
    a_2 = L2
    a_3 = L3
    x, y, z = point
    solutions = []
    
    r_1 = math.sqrt(x**2 + y**2)
    r_2 = z-d_1
    r_3 = math.sqrt(r_1**2 + r_2**2)
    phi_1 = math.acos((-a_3**2+r_3**2+a_2**2)/(2*r_3*a_2))
    phi_2 = math.atan2(r_2, r_1)
    phi_3 = math.acos((-r_3**2+a_2**2+a_3**2)/(2*a_2*a_3))
    
    #Solution 1 elbow down
    th_1 = math.atan2(y,x)
    th_2 = phi_2 - phi_1
    th_3 = math.pi - phi_3
    s = [round(np.rad2deg(th_1), 4), round(np.rad2deg(th_2), 4), round(np.rad2deg(th_3), 4)]
    solutions.append(s)
    #soultion 2 elbow down, th_1 rotated
    th_1 = th_1+math.pi
    th_2 = math.pi-th_2
    th_3 = -th_3
    s = [round(np.rad2deg(th_1), 4), round(np.rad2deg(th_2), 4), round(np.rad2deg(th_3), 4)]
    solutions.append(s)
    #solution 3 elbow up
    th_1 = math.atan2(y,x)
    th_2 = phi_2 + phi_1
    phi_3 = -math.acos((-r_3**2+a_2**2+a_3**2)/(2*a_2*a_3))
    s = [round(np.rad2deg(th_1), 4), round(np.rad2deg(th_2), 4), round(np.rad2deg(th_3), 4)]
    solutions.append(s)
    #solution 4 elbow up, th_1 rotated
    th_1 = math.atan2(y,x)+math.pi
    th_2 = math.pi-th_2
    th_3 = -th_3
    s = [round(np.rad2deg(th_1), 4), round(np.rad2deg(th_2), 4), round(np.rad2deg(th_3), 4)]
    solutions.append(s)
    #solution 
    


    return solutions

#a simple not idiot-proof check
def check_k(angles):
    
    b = forward_k(angles)
    x, y, z = b
    inverse_angles = invers_k([x, y, z])
    for list in inverse_angles:
        for i in range(len((list))):
            if list[i] < 0:
                list[i] += 360
    if angles in inverse_angles:
        print("The kinomatics are correct")
    else:
        print("The kinomatics are wrong")
        

def exerciseD():
    x, y, z = [0,-323.9033, 176.6988]
    inverse_angles = invers_k([x, y, z])
    print("these are the different solutions: \n" , inverse_angles)


angles = [270, 30, 315]
check_k(angles)
exerciseD()
