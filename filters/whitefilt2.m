%
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Image Whitening Filter
%     Takes and image input
%           Filters it using whitening
%
%     Steven Munn
%           from https://github.com/stevenjlm/Dataparse_PMPF

function [X,F] = whitefilt2(X)
    a=mean(mean(X));
    X = bsxfun(@minus, X, a);
    A = X*X';
    [U,S,V] = svd(A,0);
    F=U*diag(diag(S).^(-1/2))*V';
    X = F*X;
    X=bsxfun(@plus, X, abs(min(min(X))));
    X=bsxfun(@rdivide, X, max(max(X)));
end