# Clone-Sizes-From-Image

# Quantify clone sizes from greyscale image
Object / cell recignition by groups of positive cells (pixel value above user definded threshold value). Cluster patches of positive object/cells into clones. Calculates and returns clone sizes.

# Input
gray_scale_image  -   Gray scale image (2 dimensional array). If a 3D
                      array is given as input (multi-channel image), the first layer is taken (assumed to correspond to color = red). 
threshold         -   Minimum grey scale value of positive pixels.
cell_size_pix     -   Size of a cell in pixels.
d_max             -   Maximum distance between cells within a clone in
                      cell diameters.

# Output
clone_sizes       -   List with the size of each clone identified in the image.
