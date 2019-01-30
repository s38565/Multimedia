function image_b = bilinear(image)

[w, h, z] = size(image);
scale_w = 4*w;
scale_h = 4*h;

for i = 4: scale_w - 4
	for j = 4: scale_h - 4
		a = i/4;
        b = j/4;
		x = floor(a);
        y = floor(b);
		distance_a = a - x;
		distance_b = b - y;
        
		output(i, j, :) = ...
			(image(x, y, :) * (1 - distance_a) * (1 - distance_b) ...
            + image(x, y + 1, :) * (1 - distance_a) * (distance_b) ...
			+ image(x + 1, y, :) * (distance_a) * (1 - distance_b) ... 			
			+ image(x + 1, y + 1, :) * (distance_a) * (distance_b));
	end
end

for i = 1:scale_w - 12
    for j = 1:scale_h - 12
        image_b(i, j, :) = output(i + 3, j + 3, :);
    end
end

image_b = padarray(image_b, [12,12], 'replicate', 'post');

end
