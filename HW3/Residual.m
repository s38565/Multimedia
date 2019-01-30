function residual_image = Residual(Tar, Ref)
   total = 0;
    for i = 1 : 3
        temp = abs(Tar(:,:,i)-Ref(:,:,i));
        total = total + temp;
    end
   residual_image = total;
end

