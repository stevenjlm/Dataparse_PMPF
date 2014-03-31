%
%     Gaussian-Bernoulli Restricted Boltzmann Machine Using
%           Minimum Probability Flow Learning
%     Image Whitening Filter
%     Takes and image input
%           Filters it using whitening
%
%     Steven Munn
%           from https://github.com/stevenjlm/Dataparse_PMPF

function [X,F] = whitefilt3(Xrl)
a=mean(mean(Xrl));
Xrl = bsxfun(@minus, Xrl, a);
A = Xrl*Xrl';
[V,D] = eigs(A,size(Xrl,1)-1);
X=V'*Xrl;
X=diag(sqrt(1./diag(D))) * X;
X=bsxfun(@plus, X, abs(min(min(X))));
X=bsxfun(@rdivide, X, max(max(X)));
F=V*diag(sqrt(diag(D)));
end