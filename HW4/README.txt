Part1:

操作說明:

執行 part1.m，按下Run即可獲得結果。

sampling rate = 36 points 的輸出結果 :

執行完畢後，會產生3個figures

Figure 1: A picture for users to determine 36 points to generte curves.
Figure 2: Low sampling rate of 36 points with low LoD
Figure 3: Low sampling rate of 36 points with high LoD

sampling rate = 72 points 的輸出結果 :

執行完畢後，會產生5個figures

Figure 1: A picture for users to determine 36 points to generte curves.
Figure 2: High sampling rate of 72 points with low LoD
Figure 3: High sampling rate of 72 points with high LoD
Figure 4: Nearest-neighbor interpolation to scale by 4 times
Figure 5: Scale the sampled control points by 4 times


檔案說明:

part1.m :呼叫drawAndFillPolygon.m，完成Bézier curve的實作並輸出figures(如上述說明)，為Part1的main。
drawAndFillPolygon.m : 被part1.m呼叫的funtcion，可畫出完成實作的結果圖。

Part2:

操作說明:

執行 part2_makeRGBCube.m，按下Run即可獲得a小題之結果。
執行完畢後，會產生1個figure。

Figure 1: a complete RGB color cube

執行 part2_readOBJFile.m，按下Run即可獲得其他小題(b~f)之結果。
執行完畢後，會產生7個figure

Figure 1: both models(trump and HSV color hexagonal prism ) in the same world space 
Figure 2 & Figure 3: both models with different lighting sources (position and direction light)
Figure 4 to figure 7 are results of adjusting lighting variables of ambient ka, diffuse kd and specular ks.
Figure 4: (ka , kd , ks) = (1.0, 0.0, 0.0)
Figure 5: (ka , kd , ks) = (0.1, 1.0, 0.0)
Figure 6: (ka , kd , ks) = (0.1, 0.1, 1.0)
Figure 7: (ka , kd , ks) = (0.1, 0.8, 1.0)

檔案說明:

readObj.m : Read an obj file.
display_obj.m : Display the picture color on the object readed with readObj() function .
part2_makeRGBCube.m : 實作完整的RGB color cube，並輸出一個figure(如上述說明)
part2_readOBJFile.m : 根據spec的敘述完成HSV color hexagonal prism的實作，並將模型共同顯示於同一個空間，並調控相關lighting，完成輸出figures(如上述說明)的目的。
