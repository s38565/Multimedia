操作說明:

執行 HW3_main.m，按下Run即可獲得結果。
執行完畢後，會產生8個figures(後兩張為折線圖)，command window上前四行會顯示第三小題需要的執行時間、後兩行為第二小題需要的兩個PSNR值(for Q1、for Q2)。

Figure 1: predicted images for full search
Figure 2: predicted images for 2D logarithmic search
Figure 3: motion vectors images for full search
Figure 4: motion vectors images for 2D logarithmic search
Figure 5: residual images for full search
Figure 6: residual images for 2D logarithmic search
Figure 7: SAD values for both methods(full search or 2D logarithmic search) with p = 8 or 16、N = 8 or 16
Figure 8: PSNR for both methods(full search or 2D logarithmic search) with p = 8 or 16、N = 8 or 16

檔案說明:

HW3_main.m :呼叫MotionEstimation、Residual、myPSNR、mySAD四個function，完成輸出figures與相關數值(如上述說明)的目的，為此次作業的main。
MotionEstimation.m: 利用讀入的參數為"full_search"或"log"來決定呼叫 FullSearch 或 TwodLogSearch 哪個function，實作motion estimation。
FullSearch.m: 實作full search method，並存入 motion vector。
TwodLogSearch.m: 實作2D logarithmic search method，並存入 motion vector。
Residual.m : 將讀入的image產生residual images。
myPSNR.m: 計算 PSNR 。
mySAD.m: 計算 SAD 。