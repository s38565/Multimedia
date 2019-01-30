%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure

titlefont = 15;
fontsize = 8;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.

[frequency, magnitude] = makeSpectrum(y_input, fs);
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])

%% 2. Filtering 
% (Hint) Implement my_filter here
% [...] = myFilter(...);


[low_pass,fs_low] = myFilter(y_input,fs, 999,'Blackmann','low-pass',400);
[bandpass,fs_band] = myFilter(y_input,fs, 999,'Blackmann','bandpass',[500,750]);
[high_pass,fs_high] = myFilter(y_input,fs, 999,'Blackmann','high-pass',900);

%%% Plot the shape of filters in Time domain

figure;
subplot(1,3,1);
plot(fs_low);
title('low-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

subplot(1,3,2);
plot(fs_band);
title('bandpass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

subplot(1,3,3);
plot(fs_high);
title('high-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
%%% Plot the spectrum of filters (Frequency Analysis)

[frequency1, magnitude1] = makeSpectrum(fs_low,fs);
[frequency2, magnitude2] = makeSpectrum(fs_band,fs);
[frequency3, magnitude3] = makeSpectrum(fs_high,fs);

figure;
subplot(1,3,1);
plot(frequency1,magnitude1, 'LineWidth', LineWidth);
title('low-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])
ylim([0 1.2])

subplot(1,3,2);
plot(frequency2,magnitude2, 'LineWidth', LineWidth);
title('bandpass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])
ylim([0 1.2])

subplot(1,3,3);
plot(frequency3,magnitude3, 'LineWidth', LineWidth);
title('high-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])
ylim([0 1.2])

%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter

% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);

audiowrite('Lowpass_400.wav',low_pass,fs);
audiowrite('Bandpass_500_750.wav',bandpass,fs);
audiowrite('Highpass_900.wav',high_pass,fs);

%%% Plot the spectrum of filtered signals

[frequency4, magnitude4] = makeSpectrum(low_pass,fs);
[frequency5, magnitude5] = makeSpectrum(bandpass,fs);
[frequency6, magnitude6] = makeSpectrum(high_pass,fs);

figure;
subplot(1,3,1);
plot(frequency4,magnitude4, 'LineWidth', LineWidth);
title('low-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])

subplot(1,3,2);
plot(frequency5,magnitude5, 'LineWidth', LineWidth);
title('bandpass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])

subplot(1,3,3);
plot(frequency6,magnitude6, 'LineWidth', LineWidth);
title('high-pass', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 2000])

%% 4. one-fold echo and multiple-fold echo (slide #69)
[x,y] = audioread('Lowpass_400.wav');

echo_one = zeros(length(x),1);
echo_mul = zeros(length(x),1);

% one-fold
for i = 1:length(x)
    if i<=3200
        echo_one(i) = x(i);
    else
        echo_one(i) = x(i) + 0.8 * x(i-3200);
    end
end

% multiple
for i = 1:length(x)
    if i<=3200
        echo_mul(i) = x(i);
    else
        echo_mul(i) = x(i) + 0.8 * echo_mul(i-3200);
        
    end
end

%% 5. Save the echo audios  'Echo_one.wav' and 'Echo_multiple.wav'

audiowrite('Echo_one.wav',echo_one,y);
audiowrite('Echo_multiple.wav',echo_mul,y);
