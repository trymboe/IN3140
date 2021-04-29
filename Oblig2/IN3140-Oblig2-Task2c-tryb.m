joint_velocity = [0.1
                0.05
                0.05];

joint_angles = deg2rad([270
                30
                -45]);

a = vpa(jacobian(joint_velocity, joint_angles))

function cart_velocities = jacobian(joint_velocities, joint_angles)
    t1 = joint_angles(1);
    t2 = joint_angles(2);
    t3 = joint_angles(3);
    d_1 = 100.9;
    a_2 = 222.1;
    a_3 = 136.2;
    c_1 = cos(t1);
    c_2 = cos(t2);
    c_3 = cos(t3);
    s_1 = sin(t1);
    s_2 = sin(t2);
    s_3 = sin(t3);
    
    %The following matrices are all from task 2a 
    z_0 = [0
           0
           1];
    
    z_1 =[s_1
          -c_1
          0];
    
    z_2 = z_1;
    
    a = c_1*c_2*c_3*a_3 + c_1*c_2*a_2 - c_1*a_3*s_2*s_3;
    b = c_2*c_3*a_3*s_1 + c_2*a_2*s_1 - a_3*s_2*s_1*s_3;
    c = c_3*a_3*s_2 + a_2*s_2 + c_2*a_3*s_3 + d_1;
    
    o_3_0 = [a
             b
             c];
    
    o_3_1 = [a
             b
             c - d_1];
    
    o_3_2 = [a - c_1*c_2*a_2
             b - c_2*a_2*s_1
             c - (a_2*s_2 + d_1)];
    
    %Make the jacobian
    J = [cross(z_0, o_3_0) cross(z_1, o_3_1) cross(z_2, (o_3_2))
         z_0 z_1 z_2]
    
    k = J * joint_velocities;
    %extract the upper rows of the jacobian
    cart_velocities = k(1 : 3, :);
    
end























