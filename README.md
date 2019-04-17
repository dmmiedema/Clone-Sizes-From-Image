# Clone-Sizes-From-Image: Quantify clone sizes from image
Object / cell recognition. Groups of positive pixels (pixel value above user definded threshold value) with a (user defined) minimum size are identied as 'patches'. Patches can contain multiple cells/objects. Proximite clusters of patches (with distance below user defined value) are grouped into clones. Clone sizes are calculated from the total area of positive pixels in a clone, divided by the (user defined) area of a cell/object.

Applicable for: clone size quantification from images.

Input of function: image, threshold for positive pixels, maximum distance between patches of positive clones to be grouped into the same clone, area of cell/object. 

Output of function: list with clone sizes.

More info on the input and output of the function can be found in the header lines of the 'clone_sizes_from_image.m' file.

'example.m' is an example of how to use and run 'clone_sizes_from_image.m'.
