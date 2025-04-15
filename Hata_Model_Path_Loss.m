clc;
clear;

disp('--- Hata Model Path Loss Calculator (Urban Area) ---');

% --- Fixed Inputs for Urban Area ---
fc = 900e6;              % Carrier frequency in Hz (e.g., 900 MHz)
htx = 50;                % Transmitter height in meters
hrx = 1.5;               % Receiver height in meters
Etype = 'urban';         % Environment type

% --- Frequency Conversion ---
fc_MHz = fc / 1e6;

% --- Distance Vector (from 100m to 10 km) ---
d = linspace(100, 10000, 1000); % in meters

% --- Receiver Antenna Correction Factor ---
if fc_MHz >= 150 && fc_MHz <= 200
    C_Rx = 8.29 * (log10(1.54 * hrx))^2 - 1.1;
elseif fc_MHz > 200
    C_Rx = 3.2 * (log10(11.75 * hrx))^2 - 4.97;
else
    C_Rx = 0.8 + (1.1 * log10(fc_MHz) - 0.7) * hrx - 1.56 * log10(fc_MHz);
end

% --- Path Loss Calculation (Urban) ---
PL = 69.55 + 26.16 * log10(fc_MHz) - 13.82 * log10(htx) - C_Rx ...
     + (44.9 - 6.55 * log10(htx)) * log10(d / 1000);

% --- Plotting ---
figure;
plot(d / 1000, PL, 'r', 'LineWidth', 2);  % Convert distance to km
xlabel('Distance (km)');
ylabel('Path Loss (dB)');
title('Hata Model Path Loss (Urban Environment)');
grid on;
xlim([min(d)/1000, max(d)/1000]);

% --- Final Message ---
fprintf('\nPath loss plot generated for Urban environment (100 m to 10 km).\n');
