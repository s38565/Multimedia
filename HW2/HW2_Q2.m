%%% HW2_Q2.m - bit reduction -> audio dithering -> noise shaping -> low-pass filter -> audio limiting -> normalization
%%% Follow the instructions (hints) and you can finish the homework

%% Clean variables and screen
clear all;
close all;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 8;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
[input, fs] = audioread('Tempest.wav');

%%% Plot the shape of input audio

plot(input, 'LineWidth', LineWidth);
title('Input shpape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)

%%% Plot the spectrum of input audio
[frequency, magnitude] = makeSpectrum(input, fs);
figure;
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('Input spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
xlim([0 3900])
ylim([0 3500])

%% 2. Bit reduction
% (Hint) The input audio signal is double (-1 ~ 1) 

% 16 bits - 8 bits

input2 = round(input*(2^7))/(2^7);
[s1,s2] = size(input2);

%%% Save audio (audiowrite) Tempest_8bit.wav
audiowrite('Tempest_8bit.wav', input2, fs);

%% 3. Audio dithering
% (Hint) add random noise


%matrix = input2;
%my_pdf = makedist('Uniform','lower',-1,'upper',1);

random = (rand(size(input2))*2-1) / (2^7);
matrix = input2 + random * (2^3);

%%% Plot the spectrum of the dithered result
[frequency1, magnitude1] = makeSpectrum(matrix, fs);

figure;
plot(frequency1, magnitude1, 'LineWidth', LineWidth); 
title('spectrum after dithering', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([0,3900]);

figure;
plot(matrix); 
title('shape  after dithering', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%% 4. First-order feedback loop for Noise shaping
% (Hint) Check the signal val/ue. How do I quantize the dithered signal? maybe scale up first?

matrix1 = matrix * (2^7);
input2 = input2 * (2^7); 
[s3, s4] = size(matrix1);

for j = 1:2
    for i=1:s3
        if i == 1
            Ei = 0;
            matrix1(i, j) = round(matrix1(i, j));
        else    
            matrix1(i, j) = round(matrix1(i, j) + 0.9 * Ei);
            Ei = input2(i, j) - matrix1(i, j);
        end
    end
end

matrix1 = matrix1/(2^7);

%%% Plot the spectrum of noise shaping

[frequency2, magnitude2] = makeSpectrum(matrix1, fs);

figure;
plot(frequency2, magnitude2, 'LineWidth', LineWidth); 
title('spectrum after shaping', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
ylim([0 3500]);

figure;
plot(matrix1); 
title('shape  after shaping', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
%% 5. Implement Low-pass filter

[matrix1(:,1)] = myFilter(matrix1(:,1) , fs, 999, 'Blackmann', 'low-pass', 1500);
[matrix1(:,2)] = myFilter(matrix1(:,2) , fs, 999, 'Blackmann', 'low-pass', 1500);

%% 6. Audio limiting

input2 = input2 / 128;

value_min = -0.45;
value_max =  0.45;

for i = 1:s1
	for j = 1:s2
        if matrix1(i,j) > value_max
			matrix1(i,j) = value_max;
        end
		if matrix1(i,j) < value_min
			matrix1(i,j) = value_min;
        end 
	end
end

%% 7. Normalization

matrix1 = matrix1 * (max(input2) / max(matrix1));

%% 6. Save audio (audiowrite) Tempest_Recover.wav

audiowrite('Tempest_Recover.wav', matrix1, fs);

%%% Plot the spectrum of output audio
[frequency, magnitude] = makeSpectrum(matrix1, fs);
figure;
plot(frequency, magnitude, 'LineWidth', LineWidth); 
title('output spectrum', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);
xlim([0,3900]);

%%% Plot the shape of output audio
figure;
plot(matrix1); 
title('output shape', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);