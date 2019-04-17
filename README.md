# Clone-Sizes-From-Image

# Quantify clone sizes from greyscale image
Object / cell recignition by groups of positive cells (pixel value above user definded threshold value).
Cluster patches of positive object/cells into clones.
Calculates and returns clone sizes.

# Input
gray_scale_image  -   Gray scale image (2 dimensional array). If a 3D
                      array is given as input (multi-channel image), the first layer is taken (assumed to correspond to color = red).  
threshold         -   Minimum grey scale value of positive pixels
cell_size_pix     -   Size of a cell in pixels
d_max             -   Maximum distance between cells within a clone in
                      cell diameters.

# Output
clone_sizes       -   List with the size of each clone identified in the image.


# Example
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
