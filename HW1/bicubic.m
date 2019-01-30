function out = bicubic(image, scale)

[w, h, z] = size(image);
scale_w = floor(scale * w);
scale_h = floor(scale * h);
s = scale;

out = cast(zeros(scale_w, scale_h, z), 'uint8');

img = zeros(w+4,h+4,z);
img(2:w+1, 2:h+1, :) = image;
img = cast(img,'double');

for i = 1:scale_w
    
    x1 = ceil(i/s);
    x2 = x1 + 1;
    x3 = x2 + 1;
    
    a = cast(x1,'uint16');
    
    if(s > 1)
       m1 = ceil(s * (x1-1));
       m2 = ceil(s * (x1));
       m3 = ceil(s * (x2));
       m4 = ceil(s * (x3));
    else
       m1 = (s * (x1-1));
       m2 = (s * (x1));
       m3 = (s * (x2));
       m4 = (s * (x3));
    end
    
    Matrix = [  (i-m2)*(i-m3)*(i-m4)/((m1-m2)*(m1-m3)*(m1-m4)) ...
                (i-m1)*(i-m3)*(i-m4)/((m2-m1)*(m2-m3)*(m2-m4)) ...
                (i-m1)*(i-m2)*(i-m4)/((m3-m1)*(m3-m2)*(m3-m4)) ...
                (i-m1)*(i-m2)*(i-m3)/((m4-m1)*(m4-m2)*(m4-m3))];
    
    for j = 1:scale_h
        
        y1 = ceil(j/s); 
        y2 = y1 + 1; 
        y3 = y2 + 1;
        if (s > 1)
           n1 = ceil(s * (y1-1));
           n2 = ceil(s * (y1));
           n3 = ceil(s * (y2));
           n4 = ceil(s * (y3));
        else
           n1 = (s * (y1-1));
           n2 = (s * (y1));
           n3 = (s * (y2));
           n4 = (s * (y3));
        end
        
        Matrix_1 = [ (j-n2)*(j-n3)*(j-n4)/((n1-n2)*(n1-n3)*(n1-n4));...
              (j-n1)*(j-n3)*(j-n4)/((n2-n1)*(n2-n3)*(n2-n4));...
              (j-n1)*(j-n2)*(j-n4)/((n3-n1)*(n3-n2)*(n3-n4));...
              (j-n1)*(j-n2)*(j-n3)/((n4-n1)*(n4-n2)*(n4-n3))];
          
        b = cast(y1,'uint16');
        sample = img(a:a+3, b:b+3, :);
        
        out(i,j,1) = Matrix * sample(:,:,1) * Matrix_1;
        
        if(z~=1)
              out(i,j,2) = Matrix * sample(:,:,2) * Matrix_1;
              out(i,j,3) = Matrix * sample(:,:,3) * Matrix_1;
        end
    end
    
end
    out = cast(out,'uint8');
end