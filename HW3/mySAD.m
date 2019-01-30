function value = mySAD(Tar,Ref)
    value = abs(Tar(:) - Ref(:));
    value = sum(value);
end

