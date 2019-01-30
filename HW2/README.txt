Q1:

操作說明:

執行 HW2_Q1.m，按下Run即可獲得結果。
執行完畢後，會產生五個音訊檔(.wav)與4個figures

Lowpass_400.wav : low-pass filter完畢的結果
Bandpass_500_750.wav : band-pass filter完畢的結果
Highpass_900.wav : high-pass filter完畢的結果
Echo_one.wav : low-pass filter完畢又apply one-fold echo的結果
Echo_multiple.wav : low-pass filter完畢又apply multiple-fold echo的結果

Figure 1: The spectrum of the input signal
Figure 2: The shapes of the filters (time domain)
Figure 3: The spectrums of the filters(frequency domain)
Figure 4: The spectrums of the output signals. (before echo)

檔案說明:

HW2_Q1.m :呼叫myFilter與makeSpectrum這兩個function，完成輸出音訊檔與figures(如上述說明)的目的，為Q1的main。
myFilter.m : 實作Blackmann window function、 3 different FIR filters
makeSpectrum.m : 輸出成為題目所需的spectrums


Q2:

操作說明:

執行 HW2_Q2.m，按下Run即可獲得結果。
執行完畢後，會產生2個音訊檔(.wav)與8個figures

Tempest_8bit.wav : The result of Bit reduction
Tempest_Recover.wav : The final output audio signal 

Figure1 & Figure2: The shape and spectrum of input signals
Figure3 & Figure4: The spectrum and shape after audio dithering 
Figure5 & Figure6: The spectrum and shape after audio shaping
Figure7 & Figure8: The spectrum and shape of output signals

檔案說明:

HW2_Q2.m : 實作 bit reduction、Audio dithering、Noise shaping、Low-pass filter、audio limiting、Normalization這六個步驟，
           並輸出音訊檔與figures(如上述說明)