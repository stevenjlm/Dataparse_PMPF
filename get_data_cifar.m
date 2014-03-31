% 
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Learning Data Preprossessing
%     Reads image data from the CIFAR-10 set for Matlab.
%           Takes a smaller piece of the image, whitens it
%           and creates a set of training images
%
%     Steven Munn
%           from https://github.com/stevenjlm/Dataparse_PMPF

addpath filters
addpath img_processing

%% Training Data parameters,
ImageSubsetSz = 8^2; % number of pixels in training data (needs to have a integer sqrt)
Dim=sqrt(ImageSubsetSz); % dimensions of the training pictures
OriginalSz=32^2; % number of pixels in the CIFAR-10 images
OriginalDim=32; % Dimensions of the original CIFAR-10 images
nSamples = 2^10; 
DataDir = 'C:\Users\stevenjlm\Documents\biophysics\dat\cifar\data_batch_1.mat'; %Where to get the training data from
WhiteningFilter=@whitefilt; % choose the whitening filter you want to use
%% Get Training Data
fprintf( 'Extracting %d training samples\n', nSamples );
tSamp = tic();
%Memory preallocating:
Dall=zeros(3*ImageSubsetSz,nSamples); % Contains all the training data
Dall_NotWhitened=zeros(3*ImageSubsetSz,nSamples); % Contains all the training data non-whitened
Wall=zeros(3*ImageSubsetSz,nSamples); % Contains all the whitining filters for the data

% Open the entire image file
load(DataDir);
data=data'; %buffer with all the images
fclose('all');

%% Process the Data
for iSample=1:nSamples
    Continue=1;
    while Continue
        % Find the random image number
        ImageNumber=round((rand(1)*9999)+1);
        % Parse RGB
        Red=double(reshape(data(1:OriginalSz,ImageNumber),OriginalDim,OriginalDim)')/255;
        Green=double(reshape(data(OriginalSz+1:2*OriginalSz,ImageNumber),OriginalDim,OriginalDim)')/255;
        Blue=double(reshape(data(2*OriginalSz+1:3*OriginalSz,ImageNumber),OriginalDim,OriginalDim)')/255;


        [Red,Green,Blue]=justreadrgb(Dim,Dim,Red,Green,Blue,0);
        % Reads a subset of the original data

        [WhRed,RedFilter]=WhiteningFilter(Red,1E-1);
        [WhGreen,GreenFilter]=WhiteningFilter(Green,1E-1);
        [WhBlue,BleuFilter]=WhiteningFilter(Blue,1E-1);
        
        % Whitened sub image
        WhSubImg=cat(2,WhRed,WhGreen,WhBlue);
        % Non-whitened sub image
        NonWhSubImg=cat(2,Red,Green,Blue);
        % Checking for NaN errors
        if (sum(sum(isnan(WhSubImg))) > 0)
            % No Error continue to next image
            Continue=1;
        else
            % Error, repeat the while loop
            Continue=0;
        end
    end
    Filter=cat(2,RedFilter,GreenFilter,BleuFilter);
    Dall(:,iSample) = WhSubImg(:);
    Dall_NotWhitened(:,iSample) = NonWhSubImg(:);
    Wall(:,iSample) = Filter(:);
    Progress=iSample/nSamples;
    waitbar(Progress);
end


tSamp=toc(tSamp);
if (sum(sum(isnan(Dall))) > 0)
	error('Found NaN.');
end
save('8by8data_W1neg3.mat', 'Dall');
save('8by8data_raw.mat', 'Dall_NotWhitened');
save('8by8filters_W1neg3.mat', 'Wall');
fprintf( 'Extracted and saved training samples in %d seconds\n', tSamp );