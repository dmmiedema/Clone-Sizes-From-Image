%% Quantify clone sizes from greyscale image
% Object / cell recignition by groups of positive cells (pixel value above user definded
% threshold value)
% Cluster patches of positive object/cells into clones 
% Calculates and returns clone sizes

%% Input
% gray_scale_image  -   Gray scale image (2 dimensional array). If a 3D
%                       array is given as input (multi-channel image), the first layer is taken (assumed to correspond to color = red).  
% threshold         -   Minimum grey scale value of positive pixels
% cell_size_pix     -   Size of a cell in pixels
% d_max             -   Maximum distance between cells within a clone in
%                       cell diameters.

%% Output
% clone_sizes       -   List with the size of each clone identified in the image.

%% Main Function

function clone_sizes = clone_sizes_from_image(grey_scale_image, threshold, cell_size_pix, d_max)
    % Reduce dimensions of image to 1 if 3.
    if numel(size(grey_scale_image))==3
        grey_scale_image=grey_scale_image(:,:,1); % select first channel: red
    end        
    
    % Parameters derived from input
    cell_diameter_pix = 2 * sqrt(cell_size_pix/pi);
    d_max_pix = d_max * cell_diameter_pix;
    
    % Create binary image of positive and negative pixels
    binary_image = grey_scale_image> threshold;
    
    % Find number of rows in image
    Nrows = size(binary_image,1); 
    
    % Find patches of positive pixels
    con_comp=bwconncomp(binary_image,4);
    Npatches=con_comp.NumObjects;
    patch_pix_x=[];
    patch_pix_y=[];
    patch_sizes=[];
    cc=0;
    for i=1:Npatches
        patch_pix=con_comp.PixelIdxList{i};
        NPix=numel(patch_pix);
        % Select patches with at least the size of a (half) cell. (filters
        % noise)
        if NPix>= cell_size_pix/2                  
            cc=cc+1;
            patch_pix_x{cc}=mod(patch_pix - 1, Nrows) + 1;
            patch_pix_y{cc}=floor((patch_pix - 1)/Nrows)+1;
            patch_sizes(cc)=round(NPix/cell_size_pix);
        end
    end
    Npatches = numel(patch_sizes);
    
    % Find distance between positive patches
    Distances=zeros(Npatches);
    for i=1:Npatches-1
        xx_i=patch_pix_x{i};
        yy_i=patch_pix_y{i};
        for j=i+1:Npatches
            xx_j=patch_pix_x{j};
            yy_j=patch_pix_y{j};
            NPix=numel(xx_j);
            for i2=1:NPix
                x2=xx_j(i2);
                y2=yy_j(i2);
                D1=sqrt((xx_i - x2).^2 + (yy_i - y2).^2);
                if i2==1
                    D1min=min(D1);
                end
                D1min=min(min(D1),D1min);
            end
            Distances(i,j)=D1min;
        end
    end
    
    % Identify neirest neighbors of patches (those closer than d_max)
    Distances(Distances==0) = Nrows;    
    MergeDist=(Distances>0 & Distances<d_max_pix);
    PatchNN=cell(Npatches,1);
    for i=1:Npatches
        PatchNN{i}=find(MergeDist(:,i)==1)';
        PatchNN{i}=[PatchNN{i} find(MergeDist(i,:)==1)];
    end
    
    % Cluster neirest neighbor patches into clones
    PatchBi=ones(1,Npatches);
    PatchClones=[];
    cc=0;
    while sum(PatchBi)>0
        cc=cc+1;
        id=find(PatchBi==1,1);
        NN=PatchNN{id};

        if isempty(NN)
            PatchClones{cc}=id;     % Isolated patches
            PatchBi(id)=0;
        else
            PatchGrow=1;
            PatchClones{cc}=NN;
            NNnew=[];
            while PatchGrow==1
                PatchGrow=0;
                for i2=1:numel(NN)
                    if PatchBi(NN(i2))==1
                        NNnew=[NNnew PatchNN{NN(i2)}];
                        PatchBi(NN(i2))=0;
                        PatchGrow=1;
                    end
                end
                if PatchGrow==1
                    PatchClones{cc}=[PatchClones{cc} NNnew];
                    NN=NNnew;
                    NNnew=[];
                end
            end
        end
    end    
    
    % Get clone sizes from clustered patches
    Nclones=numel(PatchClones);
    clone_sizes=zeros(Nclones,1);
    for i=1:Nclones
        clone_sizes(i) = sum(patch_sizes(PatchClones{i}));
    end    
end