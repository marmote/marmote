% CrystalSimulation

clear all
close all
clc

% STM32F102 oscillator inverter parameter
g_m = 25e-3; % mA/V

% ECX-2236-160 rystal parameters
R_m = 100; % Ohm (ESR)
R_ext = 0; % Ohm
C_0 = 5e-12; % F
C_L = 8e-12; % F
f = 16e6; % Hz

% From another crystal
C_m = 0.027e-12; % F motional capacitance - elasticity of the crystal
L_m = 14.7e-3; % H motional inductance - vibrating mass of the crystal
R_m = 100; % ohm motinal resistance - circuit losses (ESR)

w = (7.9e6 : 100 : 8.1e6)*2*pi;

Z = (1./(j*w*C_0).*(1./(j*w*C_m)+R_m+j*w*L_m)) ./ ...
    (1./(j*w*C_0)+1./(j*w*C_m)+R_m+j*w*L_m);
Z2 = (1./(j*w*(C_0+C_L)).*(1./(j*w*C_m)+R_m+j*w*L_m)) ./ ...
     (1./(j*w*(C_0+C_L))+1./(j*w*C_m)+R_m+j*w*L_m);


Fs = 1/(2*pi*(L_m*C_m)^.5)
Fa = Fs * (1+C_m/C_0)^.5
Fp = Fs * (1+C_m/(2*(C_0)))
Fp2 = Fs * (1+C_m/(2*(C_0+C_L)))

f = w/2/pi;

subplot(2,1,1)
plot(f,imag(Z), f,imag(Z2),'g');
hold on
% plot(f,abs(Z),'m', f,real(Z),'c');
plot([Fs Fs],[min(imag(Z)),max(imag(Z))],'r-.')
plot([Fa Fa],[min(imag(Z)),max(imag(Z))],'r-.')
plot([Fp Fp],[min(imag(Z)),max(imag(Z))],'--')
plot([Fp2 Fp2],[min(imag(Z)),max(imag(Z))],'g--')
% set(gca, 'xtick', [Fs Fa])
grid on
xlabel('Frequency [Hz]')
ylabel('\Im\{Z\}')
axis tight
legend('w/o C_L', 'w/ C_L')

subplot(2,1,2)
plot(f,angle(Z)/pi*180, f,angle(Z2)/pi*180,'g')
hold on
plot([Fs Fs],[min(angle(Z)),max(angle(Z))]/pi*180,'r-.')
plot([Fa Fa],[min(angle(Z)),max(angle(Z))]/pi*180,'r-.')
plot([Fp Fp],[min(angle(Z)),max(angle(Z))]/pi*180,'--')
plot([Fp2 Fp2],[min(angle(Z)),max(angle(Z))]/pi*180,'g--')
set(gca, 'ytick', [-90 0 90])
grid on
xlabel('Frequency [Hz]')
ylabel('Angle [deg]')
legend('w/o C_L', 'w/ C_L')
axis tight

return

%--------------------------------------------------------------------------

w = (1e4 : 10 : 9e5)*2*pi;
f = w/2/pi;

C = C_0 + C_L/2;
L = L_m;

A = 1./(1-w.^2*L*C);

figure
plot(f, A)

