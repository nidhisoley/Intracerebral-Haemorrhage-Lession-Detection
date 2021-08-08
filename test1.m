clc;
close all;
clear all;
fontSize = 15;

%===========================================================================================================
ctImage = imread('BrainH1.jpg'); 

[rows, columns, numberOfColorChannels] = size(ctImage);
if numberOfColorChannels > 1
	% Convert it to gray scale
	grayImage = rgb2gray(ctImage); 
end
% Display the image.
subplot(2, 3, 1);
imshow(grayImage);
caption = sprintf('Original Grayscale Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%===========================================================================================================
% Display the histogram so we can see what gray level we need to threshold it at.
subplot(2, 3, 2:3);

[pixelCounts, grayLevels] = imhist(grayImage, 256);
faceColor = [0, 60, 190]/255; % Our custom color - a bluish color.
bar(grayLevels, pixelCounts, 'BarWidth', 1, 'FaceColor', faceColor);
% Find the last gray level and set up the x axis to be that range.
lastGL = find(pixelCounts>0, 1, 'last');
xlim([0, lastGL]);
grid on;
% Set up tick marks every 50 gray levels.
ax = gca;
ax.XTick = 0 : 50 : lastGL;
title('Histogram of Non-Black Pixels', 'FontSize', fontSize, 'Interpreter', 'None', 'Color', faceColor);
xlabel('Gray Level', 'FontSize', fontSize);
ylabel('Pixel Counts', 'FontSize', fontSize);


%===========================================================================================================
% Threshold the image to make a binary image.
thresholdValue = 145;
binaryImage = grayImage < thresholdValue;

binaryImage = imclearborder(binaryImage);

% Display the image.
subplot(2, 3, 4);
imshow(binaryImage, []);
caption = sprintf('Initial Binary Image\nThresholded at %d Gray Levels', thresholdValue);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

%===========================================================================================================
% Extract the two largest blobs, which will either be the skull and brain,
% or the skull/brain (if they are connected) and small noise blob.
binaryImage = bwareafilt(binaryImage, 2);		% Extract 2 largest blobs.
% Erode it a little with imdilate().
binaryImage = imopen(binaryImage, true(5));
% Now brain should be disconnected from skull, if it ever was.
% So extract the brain only - it's the largest blob.
binaryImage = bwareafilt(binaryImage, 1);		% Extract largest blob.
% Fill any holes in the brain.
binaryImage = imfill(binaryImage, 'holes');
% Dilate mask out a bit in case we've chopped out a little bit of brain.
binaryImage = imdilate(binaryImage, true(5));

% Display the final binary image.
subplot(2, 3, 5);
imshow(binaryImage, []);
caption = sprintf('Final Binary Image\nof Skull Alone');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

%===========================================================================================================
% Mask out the skull from the original gray scale image.
skullFreeImage = grayImage; % Initialize
skullFreeImage(~binaryImage) = 0; % Mask out.
% Display the image.
subplot(2, 3, 6);
imshow(skullFreeImage);
caption = sprintf('Gray Scale Image\nwith Skull Stripped Away');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');


%===========================================================================================================
% Median filter to reduce noise

skullFreeImage_Median1 = medfilt2(skullFreeImage);
skullFreeImage_Median2 = medfilt2(skullFreeImage_Median1);
skullFreeImage_Median3 = medfilt2(skullFreeImage_Median2);

figure;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,2,1);
imshow(skullFreeImage);
title('Skull tripped Image');

subplot(2,2,2);
imshow(skullFreeImage_Median3);
title('Median Filtered Image');

%===========================================================================================================
% Smoothen the Object

seD = strel('diamond',1);
skullFreeImage_Median3 = imerode(skullFreeImage_Median3,seD);
skullFreeImage_Median3 = imerode(skullFreeImage_Median3,seD);

%===========================================================================================================
% Thresholding of Hemorrage Lesion Area


[m n]=size(skullFreeImage_Median3);

for i=1:m
   for j=1:n
       if (skullFreeImage_Median3(i,j)>=170)
           Hemorrage_Lesion(i,j)=255;
       else
           Hemorrage_Lesion(i,j)=0;
   end
end
end

Hemorrage_Lesion = imclearborder(Hemorrage_Lesion, 4);

subplot(2,2,3);
imshow(Hemorrage_Lesion);
title('Hemorrage Region Detected');


%===========================================================================================================
% Pseudo Color Image Result

a=imread('BrainH1.jpg');
red=a(:,:,1), green=a(:,:,2), blue=a(:,:,3);

for i = 1:m
    for j = 1:n
        if(Hemorrage_Lesion(i,j)==255)
            red(i,j)=255;
            green(i,j)=255;
            blue(i,j)=0;
        end
    end
end

Hemorrage_Lesion_mapped = cat(3,red,green,blue);
subplot(2,2,4);
imshow(Hemorrage_Lesion_mapped);
title('Hemorrage Region Highlighted in Original Image');