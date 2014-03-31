% 
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Learning Data Preprossessing Verification
%     Reads the training image data
%           Displays figure with all the images
%
%     Steven Munn
%           from https://github.com/stevenjlm/Dataparse_PMPF

clf;
if exist('Dall','var')
    ImgDim=sqrt(size(Dall,1)/3);
    
    nFigures=1;
    nSubPlots=5^2;
    FigureDim=sqrt(nSubPlots);
    if mod(FigureDim,1)
        error('The total number of images displayed must have an integer square root');
    end
    
    nImages=size(Dall,2);
    for j=1:nFigures
        if ~(j==1)
            figure;
        end
        for i=1:nSubPlots
            % Pick a random iImage number from the nImage available
            iImage=round((nImages-1)*rand(1,1)+1);
            
            subplot(FigureDim,FigureDim,i);
            
            red=reshape(Dall(1:ImgDim^2,iImage),ImgDim,ImgDim);
            green=reshape(Dall(ImgDim^2+1:2*ImgDim^2,iImage),ImgDim,ImgDim);
            blue=reshape(Dall(2*ImgDim^2+1:3*ImgDim^2,iImage),ImgDim,ImgDim);

            image(cat(3,red,green,blue));
            axis off;
        end
        SuperTitle=['Gathered Data for ', num2str(ImgDim), ' x ', num2str(ImgDim), ' images.'];
        suptitle(SuperTitle);
    end
    
else
    error('Either run get_data_cifar.m or load a .mat file first');
end