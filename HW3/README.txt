�ާ@����:

���� HW3_main.m�A���URun�Y�i��o���G�C
���槹����A�|����8��figures(���i����u��)�Acommand window�W�e�|��|��ܲĤT�p�D�ݭn������ɶ��B���欰�ĤG�p�D�ݭn�����PSNR��(for Q1�Bfor Q2)�C

Figure 1: predicted images for full search
Figure 2: predicted images for 2D logarithmic search
Figure 3: motion vectors images for full search
Figure 4: motion vectors images for 2D logarithmic search
Figure 5: residual images for full search
Figure 6: residual images for 2D logarithmic search
Figure 7: SAD values for both methods(full search or 2D logarithmic search) with p = 8 or 16�BN = 8 or 16
Figure 8: PSNR for both methods(full search or 2D logarithmic search) with p = 8 or 16�BN = 8 or 16

�ɮ׻���:

HW3_main.m :�I�sMotionEstimation�BResidual�BmyPSNR�BmySAD�|��function�A������Xfigures�P�����ƭ�(�p�W�z����)���ت��A�������@�~��main�C
MotionEstimation.m: �Q��Ū�J���ѼƬ�"full_search"��"log"�ӨM�w�I�s FullSearch �� TwodLogSearch ����function�A��@motion estimation�C
FullSearch.m: ��@full search method�A�æs�J motion vector�C
TwodLogSearch.m: ��@2D logarithmic search method�A�æs�J motion vector�C
Residual.m : �NŪ�J��image����residual images�C
myPSNR.m: �p�� PSNR �C
mySAD.m: �p�� SAD �C