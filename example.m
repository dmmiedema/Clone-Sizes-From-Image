%% Example for usage of 'clone_sizes_from_image.m'

% Download 'clone_sizes_from_image.m' in download folder.
download_folder = 'D:\Downloads\';     % path to folder where 'clone_sizes_from_image' is saved

% load and show image
file = 'D:\images\test_image.tif';      % complete path to image to analyze
image = imread(file);                   % load image
figure(1); imshow(image);               % show image

% determine minum value of positive pixels (threshold) and the size of an
% average cell in pixels (cell_size_pix) manually from the image
threshold = 50;
cell_size_pix = 30;

d_max = 5;                              % maximum distance between cells in a clone (unit: cell diameters).

cd download_folder                      % navigate to download folder
% call 'clone_sizes_from_image'.
clone_sizes = clone_sizes_from_image(image, threshold, cell_size_pix, d_max);
