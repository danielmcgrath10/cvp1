% directory = uigetdir(pwd, 'Select a Folder');
% filePattern = fullfile(directory, '*.jpg');
filePattern = '/Users/danielmcgrath/Documents/fifth-year-northeastern/Fall/computer-vision/Project 1/cvp1/Office/*.jpg';
files = dir(filePattern);
numFiles = length(files);
threshold = 3;
tsigma = 1;

images = zeros(240,320,1070);
for i = 1:numFiles
   file = files(i);
   images(:,:,i) = rgb2gray(imread(strcat(file.folder,'/',file.name)));
end

file = images(:,:,200);
figure;
colormap gray;
image(file, 'CDataMapping', 'scaled');

temporal_d = simple_filter(images, numFiles, threshold);


function [temporal_d] = simple_filter(images, numFiles, threshold)
    temporal_d(:,:,1) = zeros(240, 320);
    temporal_d(:,:,numFiles) = zeros(240, 320);
    for i = 2:(numFiles - 2)
        img_0 = images(:,:,i-1);
        img_1 = images(:,:,i);
        img_2 = images(:,:,i + 1);
        diff = 0.5 * ((img_0 .* -1) + (img_1 .* 0) + (img_2 .* 1));
        zeroindices = find(abs(diff) < threshold);
        oneindices = find(abs(diff) >= threshold);
        maskedDiff = diff; 
        maskedDiff(zeroindices) = 0;
        maskedDiff(oneindices) = 1;
        temporal_d(:,:,i) = maskedDiff;
    end
end





    