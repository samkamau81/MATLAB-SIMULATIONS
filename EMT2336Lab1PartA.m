%PART A--------------------------------------------------------------------
% Defining the function
theta2 = linspace(15, 165, 30);
theta4 = 65 + 0.43*theta2;
format short g %to prevent e from forming in the output

% Defining the fixed link length
L1 = 410;

% Precision points using Chebyshev Spacing
precision_point=precise(15,165,3);% Using the function precise point function
theta4_p = 65 + 0.43*precision_point;
thetapp_4=precision_point-theta4_p
% Use Chebyshev's spacing to evaluate the link length ratios K1, K2, and K3
% Freudeinstein's Equation :K1cos(theta4)-K2cos(theta2)+K3=cos(theta2-theta4)
vals=[cosd(theta4_p),cosd(precision_point),[1;1;1]];
fin=[cosd(thetapp_4)];
% Using Matrix
ans=vals\fin 

K1=ans(1)
K2=ans(2)
K3=ans(3)


% Determine the lengths of the other links
L2 = abs(L1/K1) %a
L3 = abs(L1/K2) %c
L4 = sqrt(abs(K3*(2*L2*L3)-L2.^2-L3.^2-L1.^2))%b


% Compute the transmission angles for the given range of input angles
transmission_angles = acosd(abs((L4.^2 +L3.^2 - L2.^2- L1.^2+((2.*L2.*L1).*cosd(theta2)))./(2.*L4.*L3)));

% Plot the variation of the transmission angles with the input angles
plot(theta2, transmission_angles);
xlabel('Input angle (theta2)');
ylabel('Transmission angle');
title('Variation of transmission angle with input angle');


%Structural Error
theta2struc = linspace(15, 165, 30);
A=(1-K2).*cosd(theta2struc)-K1+K3;
B=-2*sind(theta2struc);
C=K1-((1+K2).*cosd(theta2struc))+K3;
theta4generated=2*atand((-B+sqrt((B.^2)-(4.*(A.*C))))./(2.*A));
theta4required=65 + 0.43*theta2struc;
error=theta4required-theta4generated
plot(theta2struc,error);
ylabel('error');
xlabel('Input Angle');
title('Structural Error Graphs - Lab1 a');


%Chebyshev Spacing Function
function precision_point=precise(theta_2init,theta_2final,n)
    precision_point=[];
    for c = 1:n
        theta_2pp = 0.5*(theta_2init+theta_2final)-0.5*(theta_2final-theta_2init).*cosd(180*(2*(c)-1)/(2*n));
        precision_point(end+1)=theta_2pp;
    end
    precision_point=precision_point.';
end






