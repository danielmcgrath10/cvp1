directory = uigetdir(pwd, 'Select a Folder');
filePattern = fullfile(directory, '*.jpg');
officeFiles = dir(filePattern);
numOfficeFiles = length(officeFiles);

images = zeros(240,320,1070);
for i = 1:numOfficeFiles
   file = officeFiles(i);
   images(:,:,i) = rgb2gray(imread(strcat(file.folder,'/',file.name)));
end

file = images(:,:,200);
figure;
colormap gray;
image(file, 'CDataMapping', 'scaled');

temporal_d = zeros(240, 320, 1069);
for i = 1:(numOfficeFiles - 1)
    img_0 = images(:,:,i);
    img_1 = images(:,:,i + 1);
    diff = img_1 - img_0;
    temporal_d(:,:,i) = diff;
end



    