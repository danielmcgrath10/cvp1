% directory = uigetdir(pwd, 'Select a Folder');
% filePattern = fullfile(directory, '*.jpg');
filePattern = '/Users/danielmcgrath/Documents/fifth-year-northeastern/Fall/computer-vision/Project 1/cvp1/Office/*.jpg';
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

