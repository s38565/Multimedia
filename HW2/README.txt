Q1:

�ާ@����:

���� HW2_Q1.m�A���URun�Y�i��o���G�C
���槹����A�|���ͤ��ӭ��T��(.wav)�P4��figures

Lowpass_400.wav : low-pass filter���������G
Bandpass_500_750.wav : band-pass filter���������G
Highpass_900.wav : high-pass filter���������G
Echo_one.wav : low-pass filter�����Sapply one-fold echo�����G
Echo_multiple.wav : low-pass filter�����Sapply multiple-fold echo�����G

Figure 1: The spectrum of the input signal
Figure 2: The shapes of the filters (time domain)
Figure 3: The spectrums of the filters(frequency domain)
Figure 4: The spectrums of the output signals. (before echo)

�ɮ׻���:

HW2_Q1.m :�I�smyFilter�PmakeSpectrum�o���function�A������X���T�ɻPfigures(�p�W�z����)���ت��A��Q1��main�C
myFilter.m : ��@Blackmann window function�B 3 different FIR filters
makeSpectrum.m : ��X�����D�ةһݪ�spectrums


Q2:

�ާ@����:

���� HW2_Q2.m�A���URun�Y�i��o���G�C
���槹����A�|����2�ӭ��T��(.wav)�P8��figures

Tempest_8bit.wav : The result of Bit reduction
Tempest_Recover.wav : The final output audio signal 

Figure1 & Figure2: The shape and spectrum of input signals
Figure3 & Figure4: The spectrum and shape after audio dithering 
Figure5 & Figure6: The spectrum and shape after audio shaping
Figure7 & Figure8: The spectrum and shape of output signals

�ɮ׻���:

HW2_Q2.m : ��@ bit reduction�BAudio dithering�BNoise shaping�BLow-pass filter�Baudio limiting�BNormalization�o���ӨB�J�A
           �ÿ�X���T�ɻPfigures(�p�W�z����)