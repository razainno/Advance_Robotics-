

close all; clear all; clc;

Q1 = 0; Q2 = 0; Q3 = 0; Q4 = 0; Q5 = 0; Q6 = 0;
d1 = 10*10e-3; d2 = 10*10e-3;
l1 = 300e-3; l2 = 300e-3; 
% q=[0.3, 0.4, 0.2];
q=HOWTO(0.1,0.2,0.1);
px=0.2;
Tbase = eye(4); Ttool=eye(4);
kac = 10e5;
d6=[0 d1 -d1;    
    -d1 0 d1;
    d1 -d1 0];

Dd=[0 d1 -d1;
    -d1 0 d1;
    d1 -d1 0];
De= [eye(3,3) d6; Dd zeros(3,3)];


 rx2=Rx(q(2));
 
 rx3=Rx(q(3)) 



 Q2 = [rx2(1:3,1:3) zeros(3,3); zeros(3,3) rx2(1:3,1:3)]
 Q3= [rx3(1:3,1:3) zeros(3,3); zeros(3,3) rx3(1:3,1:3)]
k23_11 = Q2*k11_calc(d1,l1)*Q2'; k23_12 = Q2*k12_calc(d2,l1)*Q2'; k23_21 = Q2*k23_12'*Q2'; k23_22 = Q2*k12_calc(d1,l1)*Q2';
k45_11 = Q3*k11_calc(d2,l2)*Q3'; k45_12 = Q3*k12_calc(d2,l2)*Q3; k45_21 = Q3*k45_12'*Q3'; k45_22 =Q3* k22_calc(d2,l2)*Q3';
lambda_01_e = [0 0 0 1 0 0 ]; 
lambda_01_r = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0;0 0 0 0 1 0; 0 0 0 0 1  0 ];

lambda_12_r = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1 ];

lambda_34_r = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1 ];

lambda_56_r = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
lambda_p = [0 0 0 1 0 0 ];

X = [zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)     eye(6,6)     zeros(6,6)        zeros(6,6)   zeros(6,6)    zeros(6,6)   zeros(6,6)   zeros(6,6)   zeros(6,6);
     zeros(6,6)     zeros(6,6)    -eye(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)           k23_11        k23_12    zeros(6,6)   zeros(6,6)   zeros(6,6)   zeros(6,6);
     zeros(6,6)    zeros(6,6)     zeros(6,6)    -eye(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)           k23_21        k23_22    zeros(6,6)   zeros(6,6)   zeros(6,6)   zeros(6,6);
     zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)     -eye(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)        zeros(6,6)    zeros(6,6)     k45_11      k45_12      zeros(6,6)   zeros(6,6);
     zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)      zeros(6,6)     -eye(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)        zeros(6,6)    zeros(6,6)     k45_21      k45_12      zeros(6,6)   zeros(6,6);
     zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)       zeros(6,6)    zeros(6,6)   zeros(6,6)  zeros(6,6)       eye(6,6)         -eye(6,6);%De
     zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)     eye(6,6)        De'       zeros(6,6)    zeros(6,6)        zeros(6,6)    zeros(6,6)   zeros(6,6)  zeros(6,6)    zeros(6,6)   zeros(6,6);                                                                                                                                   
     zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)     zeros(5,6)     zeros(5,6)   zeros(5,6)    zeros(5,6)    lambda_01_r   -lambda_01_r      zeros(5,6)    zeros(5,6)   zeros(5,6)  zeros(5,6)    zeros(5,6)   zeros(5,6);
       eye(6,6)      eye(6,6)    zeros(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    zeros(6,6)    zeros(6,6)    zeros(6,6)        zeros(6,6)    zeros(6,6)   zeros(6,6)  zeros(6,6)    zeros(6,6)   zeros(6,6);
    lambda_01_e    zeros(1,6)    zeros(1,6)     zeros(1,6)     zeros(1,6)     zeros(1,6)   zeros(1,6)    zeros(1,6)  lambda_01_e*kac -lambda_01_e*kac  zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)     zeros(5,6)     zeros(5,6)   zeros(5,6)    zeros(5,6)    zeros(5,6)     lambda_12_r     lambda_12_r    zeros(5,6)   zeros(5,6)  zeros(5,6)    zeros(5,6)   zeros(5,6);
     zeros(5,6)   lambda_12_r    lambda_12_r    zeros(5,6)     zeros(5,6)     zeros(5,6)   zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)       zeros(5,6)    zeros(5,6)   zeros(5,6)  zeros(5,6)    zeros(5,6)   zeros(5,6);
     zeros(1,6)     lambda_p     zeros(1,6)     zeros(1,6)     zeros(1,6)     zeros(1,6)   zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(1,6)    zeros(1,6)     lambda_p      zeros(1,6)     zeros(1,6)     zeros(1,6)   zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)     zeros(5,6)     zeros(5,6)   zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)       zeros(5,6)   lambda_34_r  -lambda_34_r zeros(5,6)    zeros(5,6)   zeros(5,6);
     zeros(5,6)    zeros(5,6)    zeros(5,6)     lambda_34_r   lambda_34_r     zeros(5,6)   zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)       zeros(5,6)    zeros(5,6)   zeros(5,6)  zeros(5,6)    zeros(5,6)   zeros(5,6);
     zeros(1,6)    zeros(1,6)    zeros(1,6)     lambda_p       zeros(1,6)     zeros(1,6)   zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)      lambda_p      zeros(1,6)   zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)     zeros(5,6)     zeros(5,6)   zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)       zeros(5,6)    zeros(5,6)   zeros(5,6)  lambda_56_r  -lambda_56_r  zeros(5,6);
     zeros(5,6)    zeros(5,6)    zeros(5,6)     zeros(5,6)     zeros(5,6)     lambda_56_r  lambda_56_r   zeros(5,6)    zeros(5,6)     zeros(5,6)       zeros(5,6)    zeros(5,6)   zeros(5,6)  zeros(5,6)    zeros(5,6)   zeros(5,6);
     zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)     zeros(1,6)      lambda_p    zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(1,6)    zeros(1,6)    zeros(1,6)     zeros(1,6)     zeros(1,6)     zeros(1,6)    lambda_p     zeros(1,6)    zeros(1,6)     zeros(1,6)       zeros(1,6)    zeros(1,6)   zeros(1,6)  zeros(1,6)    zeros(1,6)   zeros(1,6);
     zeros(6,6)    zeros(6,6)    zeros(6,6)     zeros(6,6)     zeros(6,6)     zeros(6,6)   zeros(6,6)    eye(6,6)    zeros(6,6)     zeros(6,6)       zeros(6,6)    zeros(6,6)   zeros(6,6)  zeros(6,6)    zeros(6,6)   zeros(6,6)
];
  

A = X(1:90, 1:90);   

B = X(1:90, 91:96);        
C = X(91:96,1:90);        
D = X(91:96,91:96);
 A_inv = pinv(A);
Kc = D - C*(A_inv)*B
% save('MSA_Model','Kc','A','B','C','D');




function[k] = k11_calc(d, L)
E = 70e9; % Young's modulus
G = 25.5e9; % Shear modulus

Iy = (pi*d*d*d*d)/64;
Iz = (pi*d*d*d*d)/64;
J = Iy + Iz;
S = (pi*d*d)/4;

J = Iy + Iz;
k = [E*S/L       0                  0                0           0          0;
    0           12*E*Iz/L^3         0                0           0          6*E*Iz/L^2;
    0           0                  12*E*Iy/L^3       0       -6*E*Iy/L^2    0;
    0           0                  0                 G*J/L       0          0;
    0           0                  -6*E*Iy/L^2       0       4*E*Iy/L       0;
    0           6*E*Iz/L^2         0                 0           0          4*E*Iz/L];
end


function [k] = k12_calc(d, L)
E = 70e9; % Young's modulus
G = 25.5e9; % Shear modulus

Iy = (pi*d*d*d*d)/64;
Iz = (pi*d*d*d*d)/64;
J = Iy + Iz;
S = (pi*d*d)/4;

J = Iy + Iz;
k = [-E*S/L       0                  0                0           0          0;
    0           -12*E*Iz/L^3         0                0           0          6*E*Iz/L^2;
    0           0                  -12*E*Iy/L^3       0       -6*E*Iy/L^2    0;
    0           0                  0                 -G*J/L       0          0;
    0           0                  6*E*Iy/L^2       0       2*E*Iy/L       0;
    0           -6*E*Iz/L^2         0                 0           0          2*E*Iz/L];
end

function [k] = k22_calc(d, L)
E = 70e9; % Young's modulus
G = 25.5e9; % Shear modulus

Iy = (pi*d*d*d*d)/64;
Iz = (pi*d*d*d*d)/64;
J = Iy + Iz;
S = (pi*d*d)/4;

k = [E*S/L       0                  0                0           0          0;
    0           12*E*Iz/L^3         0                0           0          -6*E*Iy/L^2;
    0           0                  12*E*Iy/L^3       0       6*E*Iy/L^2    0;
    0           0                  0                 G*J/L       0          0;
    0           0                  6*E*Iy/L^2       0       4*E*Iy/L       0;
    0           -6*E*Iy/L^2         0                 0           0          4*E*Iz/L];
end






function T = Rx(q)

Sq = sin(q);    Cq = cos(q);

T = [   1   0    0     0; ...
        0   Cq  -Sq    0; ...
        0   Sq   Cq    0; ...
        0   0    0     1];
end
function T = Ry(q)

Sq = sin(q);    Cq = cos(q);

T = [  Cq   0    Sq    0; ...
        0    1    0     0; ...
       -Sq   0   Cq    0; ...
        0    0    0     1];
end
function T = Rz(q)

Sq = sin(q);    Cq = cos(q);

T = [  Cq   -Sq   0     0; ...
       Sq   Cq    0    0; ...
        0   Sq    1    0; ...
        0   0     0    1];
end
