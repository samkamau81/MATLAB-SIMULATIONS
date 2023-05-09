%PART B--------------------------------------------------------------------
%Using the Least Square Method 
% Defining the fixed link length
L1 = 410;

precision_point=precise(15,165,5)
theta4 = 65 + 0.43*precision_point;

%Matrix of the Least Square Method Formula
a = [sum((cosd(theta4)).^2), -sum(cosd(precision_point).*cosd(theta4)), sum(cosd(theta4));
    sum(cosd(theta4).*cosd(precision_point)), -sum((cosd(precision_point)).^2), sum(cosd(precision_point));
    sum(cosd(theta4)), -sum(cosd(precision_point)),5];

b = [(sum(cosd(theta4).*cosd(precision_point-theta4)));
    (sum(cosd(precision_point).*cosd(precision_point-theta4)));
    (sum(cosd(precision_point-theta4)))];

x = a\b;

% Link length ratios
K1 = x(1)
K2 = x(2)
K3 = x(3)

% Determine the lengths of the other links
L2 = abs(L1/K1) %a
L3 = abs(L1/K2) %c
L4 = sqrt(abs(K3*(2*L2*L3)-L2.^2-L3.^2-L1.^2))%b


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
title('Structural Error Graphs- Lab1 b');


%Chebyshev Spacing function
function precision_point=precise(theta_2init,theta_2final,n)
    precision_point=[];
    for c = 1:n
        theta_2pp = 0.5*(theta_2init+theta_2final)-0.5*(theta_2final-theta_2init).*cosd(180*(2*(c)-1)/(2*n));
        precision_point(end+1)=theta_2pp;
    end
    precision_point=precision_point.';
end