clear
clc
% Define time variable
t = 0:0.1:20;

disp("the expresion is:");
disp("(E * s^2 + F * s + G) / (A * s^3 + B * s^2 + C * s + D)");

% Define numerical values for the parameters
E = 1;
F = 6;
G = 10;
A = 8;
B = 0;
C = 7;
D = 1;

% Calculate the coefficients of the characteristic polynomial
coeffs_char = [A, B, C, D];

% Calculate the roots of the characteristic polynomial
roots_char = roots(coeffs_char);

% Initialize the time-domain response array
h_numeric = zeros(size(t));
% Compute the time-domain response using the partial fraction decomposition
for i = 1:length(roots_char)
    h_numeric = h_numeric + (E * roots_char(i)^2 + F * roots_char(i) + G) ...
        ./ polyval(coeffs_char, roots_char(i)) ...
        .* (1 - exp(roots_char(i) * t)) ...
        .* exp(roots_char(i) * t);
end


%{
figure();
% Plot the time-domain response
subplot(1,2,1);
plot(t, h_numeric,'r');
%plot(t,default,'g');
xlabel('Time (t)');
ylabel('Amplitude');
title('Time-Domain Response');
grid on;
%}
figure();
% Define the transfer function coefficients
default_num = [1, 6, 10];
default_den = [1, 0, 7, 1];
% Create the numerical transfer function
default_sys = tf(default_num, default_den);

% Plot the root locus graph
subplot(1,2,1);
rlocus(default_sys);
title('Root Locus Graph');
grid on;

% Define the transfer function coefficients
num = [E, F, G];
den = [A, B, C, D];
% Create the numerical transfer function
sys = tf(num, den);

% Plot the root locus graph
subplot(1,2,2);
rlocus(sys);
title('Root Locus Graph');
grid on;
% Open Simulink model
open_system('control_system');
sim('control_system');
