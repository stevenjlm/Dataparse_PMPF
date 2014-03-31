%Online source
%http://xcorr.net/2011/05/27/whiten-a-matrix-matlab-code/

%
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Image Whitening Filter
%     Takes and image input
%           Filters it using whitening and
%           Includes a damping factor to produce
%           Human readable images
%
%      dampening_factor << 1 but greater than 0

function [X,F] = whitefilt(X,dampening_factor)
    a=mean(mean(X));
    X = bsxfun(@minus, X, a);
    A = X'*X;
    [V,D] = eig(A);
    F=V*diag(1./(diag(D)+dampening_factor).^(1/2))*V';
    X = X*F;
    X=bsxfun(@plus, X, abs(min(min(X))));
    X=bsxfun(@rdivide, X, max(max(X)));
end