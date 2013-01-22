clear all
clc

disp('------------------------ HSE --------------------')

% 1.) Check g_m critical

% STM32F102 oscillator inverter parameter
g_m = 25e-3; % A/V

% ECX-2236-160 rystal parameters
ESR = 100; % Ohm
C_0 = 5e-12; % F
f = 16e6; % Hz

C_L = 8e-12; % F
R_ext = 0; % Ohm

g_mcrit = 4*(ESR+R_ext)*(2*pi*f)^2*(C_0*C_L);
gain_margin = g_m / g_mcrit

if gain_margin > 5
    disp('Gain margin OK - the oscillator is likely to start up')
else
    disp('Warning: the oscillator may not start up')
    disp('Choose a crystal with lower ESR and/or C_L')
end

% 2.) External load capacitor (C_L) value

% 3.) Drive level (DL) check

% STM32F102 oscillator inverter parameter
I_qmax = 1e-3; % A

% ECX-2236-160 rystal parameters
% ESR = 100; % Ohm
DL = 100e-6; % W

if I_qmax^2 * ESR < DL
    disp('Drive level OK - the crystal is unlikely to overheat')
else
    disp('Warning: to much power dissipated on the crystal')
    [DL I_qmax^2 * ESR];
    disp('Add or increase R_ext')    
end

pause
clear all

disp('------------------------ LSE ------------------------')

% 1.) Check g_m critical

% STM32F102 ELS oscillator inverter parameter
g_m = 5e-6; % A/V

% ECX-.327-7-31B rystal parameters
ESR = 70e3; % Ohm
C_0 = 1.05e-12; % F
C_L = 7e-12; % F
f = 32.768e3; % Hz

R_ext = 0; % Ohm

g_mcrit = 4*(ESR+R_ext)*(2*pi*f)^2*(C_0*C_L);
gain_margin = g_m / g_mcrit

if gain_margin > 5
    disp('Gain margin OK - the oscillator is likely to start up')
else
    disp('Warning: the oscillator may not start up')
    disp('Choose a crystal with lower ESR and/or C_L')
end

% 2.) External load capacitor (C_L) value

% 3.) Drive level (DL) check

% STM32F102 oscillator inverter parameter
I_qmax = 1.4e-6; % A

% ECX-2236-160 rystal parameters
% ESR = 100; % Ohm
DL = 1e-6; % W

if I_qmax^2 * ESR < DL
    disp('Drive level OK - the crystal is unlikely to overheat')
else
    disp('Warning: to much power dissipated on the crystal')
    [DL I_qmax^2 * ESR];
    disp('Add or increase R_ext')    
end