% 
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Returns subimage of data it is given
%
%     Steven Munn
%           from https://github.com/stevenjlm/Dataparse_PMPF

function [red,green,blue]= justreadrgb(sizex,sizey,r,g,b,display)

    w=size(r,2);
    h=size(r,1);

    %Selected random part of image
    %Random Coordinates can be a random
    %number between 0 and width or hieght - size x or size y
    x=round((w-sizex-1)*rand(1,1))+1;
    y=round((h-sizey-1)*rand(1,1))+1;
    red=r(y:(y+sizey-1),x:(x+sizex-1)); %Takes picture from buffer
    green=g(y:(y+sizey-1),x:(x+sizex-1));
    blue=b(y:(y+sizey-1),x:(x+sizex-1));
    
    if display
        figure;
        colormap(gray);
        imagesc(image);
    end

end