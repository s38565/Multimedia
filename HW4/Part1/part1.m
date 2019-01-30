clear all; close all; clc;

rbImage = im2double(imread('img.png'));
[h, w, ~] = size(rbImage);
imshow(rbImage);

%% Mouse input
xlabel ('Select at most 36 points along the outline', 'FontName', '微軟正黑體', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(72);
ctrlPointList = [ctrlPointX ctrlPointY];

clicked_N = size(ctrlPointList, 1);

promptStr = sprintf('%d points selected', clicked_N);

xlabel (promptStr, 'FontName', '微軟正黑體', 'FontSize', 14);

%% Calculate Bazier Curve (Your efforts here)
%outlineVertexList = ctrlPointList; %Enrich outlineVertexList

[x,y] = size(ctrlPointList);  

LoD_low = 0:0.2:1;
LoD_high = 0:0.01:1;

pt_low = zeros(length(LoD_low), 2);
pt_high = zeros(length(LoD_high), 2);  

out_low = [];
out_high = [];

for i = 0: 3: x
       
    p0 = ctrlPointList(mod(i, x) + 1,:);
    p1 = ctrlPointList(mod(i+1, x) + 1,:);
    p2 = ctrlPointList(mod(i+2, x) + 1,:);
    p3 = ctrlPointList(mod(i+3, x) + 1,:);
    
    pt_low(:,1) = ((1-LoD_low).^3) * p0(1) + 3 * LoD_low.*(1-LoD_low).^2 * p1(1) + 3 * (LoD_low.^2).*(1-LoD_low) * p2(1) + LoD_low.^3 * p3(1);
    pt_high(:,1) = ((1-LoD_high).^3) * p0(1) + 3 * LoD_high.*(1-LoD_high).^2 * p1(1) + 3 * (LoD_high.^2).*(1-LoD_high) * p2(1) + LoD_high.^3 * p3(1);
    pt_low(:,2) = ((1-LoD_low).^3) * p0(2) + 3 * LoD_low.*(1-LoD_low).^2 * p1(2) + 3 * (LoD_low.^2).*(1-LoD_low) * p2(2) + LoD_low.^3 * p3(2);  
    pt_high(:,2) = ((1-LoD_high).^3) * p0(2) + 3 * LoD_high.*(1-LoD_high).^2 * p1(2) + 3 * (LoD_high.^2).*(1-LoD_high) * p2(2) + LoD_high.^3 * p3(2);
    
	out_low = [out_low; pt_low];
    out_high = [out_high; pt_high];
    
    pt_low = zeros(length(LoD_low), 2);
    pt_high = zeros(length(LoD_high), 2);
    
end

outlineVertexList_low = out_low;
outlineVertexList_high = out_high;

%% Draw and fill the polygon  Last 3 input arguments: (ctrlPointScattered, polygonPlotted, filled)
%figure; result = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList, true, true, true );
%imwrite(result, 'result.png');

result = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList_low, true, true, true );

if clicked_N == 36
    figure('name', 'LowLoD');
    imshow(result);
    imwrite(result, 'LowLoD_36_points.png');
    title('LowLoD 36 points');
end

if clicked_N == 72
    figure('name', 'LowLoD');
    imshow(result);
    imwrite(result, 'LowLoD_72_points.png');
    title('LowLoD for 72 points');
end

figure('name', 'HighLoD');
result1 = drawAndFillPolygon( rbImage, ctrlPointList, outlineVertexList_high, true, true, true );
imshow(result1);

if clicked_N == 36
    imwrite(result1, 'HighLoD_36_points.png');
    title('HighLoD for 36 points');
end

if clicked_N == 72
    imwrite(result1, 'HighLoD_72_points.png');
    title('HighLoDfor 72 points');
end


%% part b
if clicked_N == 72
    
    times = 4;
    
    % Nearest-neighbor interpolation
    image_nn = imresize(result1, times, 'nearest');
    
    % Scale the sampled control points by times = 4
    ctrlPointList_nn = times * ctrlPointList;
    outlineVertexList_nn = times * outlineVertexList_high;
    image = drawAndFillPolygon(image_nn, ctrlPointList_nn, outlineVertexList_nn, true, true, true );
    
    % draw the image
    figure('name', 'Nearest-neighbor');
    imshow(image_nn);
    title('Nearest-neighbor interpolation by 4 times');
    imwrite(image_nn,'image_4X_nearest_neighbor.png');
    
    figure('name', 'Scaling sampled control points');
    imshow(image);
    title('Scaling sampled control points by 4 times');
    imwrite(image,'sampled _control_points_4X.png');
end