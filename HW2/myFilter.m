function [outputSignal, outputFilter] = myFilter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input 
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop' 
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element         
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter 

%% 1. Normalization
f = fcutoff / fsample;
%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here
% if strcmp(filterName,'?') == 1
% ...
% end

mid = floor(N/2);
mid1 = ceil(-N/2);
%low-pass
if strcmp(filterName,'low-pass') == 1
    for i = mid1:mid
        if i ~= 0 
            tmp = 2*i*pi;
            outputFilter(i + 1 + mid) = sin(tmp*f)/(pi*i);       
        else
            outputFilter(mid + 1) = 1;
        end
    end
    outputFilter(mid + 1) = 2*f(1);
    
%bandpass
elseif strcmp(filterName,'bandpass') == 1
    for i = mid1:mid
        if i ~= 0 
            tmp = 2 * i * pi;
            outputFilter(i+1+mid) = (sin(f(2)*tmp)/(pi*i)) - (sin(f(1)*tmp)/(pi*i));
        else
            outputFilter(mid+1) = 1;
        end
    end
    outputFilter(mid+1) = 2*(f(2)-f(1));
    
%high-pass
elseif strcmp(filterName,'high-pass') == 1
    for i = mid1:mid
        if i ~= 0 
            tmp = 2 * i * pi;
            outputFilter(i+1+mid) = (-1) * sin(tmp*f)/(pi*i);  
        else
            outputFilter(mid+1) = 1;
        end
    end
    outputFilter(mid+1) = 1-2*f(1);
    
%bandstop
else
    for i = mid1:mid
        if i ~= 0
            tmp = 2 * i * pi;
            outputFilter(i+mid+1) = sin(f(1)*tmp)/(pi*i) - sin(f(2)*tmp)/(pi*i);
        else
            outputFilter(mid+1) = 1;
        end
    end
    outputFilter(mid) = 1 - 2*(f(2)-f(1));
end

%% 3. Create the windowing function (slide #79) and Get the realistic filter
% if strcmp(windowName,'Blackman') == 1 
%     % do it here
% end

if strcmp(windowName,'Blackmann') == 1
    for i = 1:N
        outputFilter(i) = outputFilter(i)*(0.42-0.5*cos((2*i*pi)/(N-1))+0.08*cos((4*i*pi)/(N-1)));
    end
end

%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'
len = length(inputSignal);
outputSignal = zeros(len, 1);

% 1D convolution
for i = 1:len
	for j = 1:N
		if i-j >= 1
            result = inputSignal(i-j);
        else	
            result = 0;
		end
		outputSignal(i) = outputFilter(j)*result + outputSignal(i);
	end
end



