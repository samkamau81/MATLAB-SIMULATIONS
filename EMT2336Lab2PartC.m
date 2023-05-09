%Structural Error
format long g %to prevent e from forming in the output

theta2=[40,45,50,55,60];
theta4=[70,76,83,91,100];


%Matrix of the Least Square Method Formula
A = [sum((cosd(theta4)).^2), -sum(cosd(theta2).*cosd(theta4)), sum(cosd(theta4));
    sum(cosd(theta4).*cosd(theta2)), -sum((cosd(theta2)).^2), sum(cosd(theta2));
    sum(cosd(theta4)), -sum(cosd(theta2)),5];

B = [(sum(cosd(theta4).*cosd(theta2-theta4)));
    (sum(cosd(theta2).*cosd(theta2-theta4)));
    (sum(cosd(theta2-theta4)))];

x = A\B;

% Link length ratios
K1 = x(1)
K2 = x(2)
K3 = x(3)



%Structural Error
theta2struc =linspace(40,60,20);
theta4struc=linspace(70,100,20);

A=(1-K2).*cosd(theta2struc)-K1+K3;
B=-2*sind(theta2struc);
C=K1-((1+K2).*cosd(theta2struc))+K3;

theta4generated=2*atand((-B-sqrt((B.^2)-(4.*(A.*C))))./(2.*A));
theta4required=theta4struc;
error=theta4required-theta4generated
plot(theta2struc,error);

ylabel('error');
xlabel('Input Angle');
title('Structural Error Graphs- Lab2 c');