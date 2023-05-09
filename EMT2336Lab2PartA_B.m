%Using Least Square Method
format long g %to prevent e from forming in the output

theta2=[40,45,50,55,60];
theta4=[70,76,83,91,100];
% Fixed Link
d=180;

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

% Determine the lengths of the other links
a = abs(d/K1) 
c = abs(d/K2) 
b = sqrt(abs(K3*(2*a*c)-a.^2-c.^2-d.^2))


% Compute the transmission angles for the given range of input angles
theta2_trans=linspace(40,60,20)
transmission_angles = acosd(abs((b.^2 +c.^2 - a.^2- d.^2+((2.*a.*d).*cosd(theta2_trans)))./(2.*b.*c)));

% Plot the variation of the transmission angles with the input angles
plot(theta2_trans, transmission_angles);
xlabel('Input angle (theta2)');
ylabel('Transmission angle');
title('Transmission angle Vs input angle');






