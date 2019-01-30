function value = myPSNR(x,y)
   
   s = size(x);
   x = im2double(x);
   y = im2double(y);
   
   mse_R = 1/(s(1)*s(2)) * sum(sum((x(:,:,1) - y(:,:,1)).^2));
   mse_G = 1/(s(1)*s(2)) * sum(sum((x(:,:,2) - y(:,:,2)).^2));
   mse_B = 1/(s(1)*s(2)) * sum(sum((x(:,:,3) - y(:,:,3)).^2));
   
   total = mse_R + mse_G + mse_B;
   mse = total / 3;
   value = 10 * log10(1/mse);
end

