% Matlab script to select the proper feedback potentiometer for the
% BUCK regulator

clear all;
clc;

R1 = 50e3 : 10e3 : 1e6;
R2 = 160e3; % Ohm

U = .8*(1+R1/R2);

plot(R1/1e3, U);
title(sprintf('Buck regulator output voltage (R2 = %d k\\Omega)', R2/1e3));
xlabel('R1 [k\Omega]')
ylabel('U [V]')
axis tight
grid on

%

tap = 0 : 256; % [1]
Rnom = 200e3; % [ohm]
Rcl = [36 36.5 37.4 38.3 39 39.2 40] * 1e3; % [ohm]

for Rc = Rcl

Ra = Rnom * (max(tap)-tap) / max(tap); % [ohm]
Rb = Rnom - Ra; % [ohm]

R1 = Ra;
R2 = Rb + Rc;

U = 0.8*(1+R1./R2);

plot(tap,U,'x ')
title(sprintf('Output voltage steps (Rc = %.1fk\\Omega ; U_{max} = %3.2fV)', Rc/1e3, max(U)))
xlabel('Taps')
ylabel('Output voltage [V]')
axis tight

pause
end