clc;clear;
load mnist;
f = 35;% number of labeled data
k = 10;% number of classes

[n, d] = size(fea);

disp('=== MNIST ===');
gnd(gnd == 0) = 10;

idx_fidelity = randperm(n, f)';
fidelity = [idx_fidelity, gnd(idx_fidelity)];


ug = zeros(n,k);
uw = zeros(n,k);
ub = zeros(n,k);
uwb = zeros(n, k);
%W=weight_ann(fea'); %Compute the weight matrix by ann   
for i = 1 : k
    g=zeros(size(fidelity,1),1);
    subset = find(fidelity(:, 2) == i);
    g(subset)=1;
    idx_fidelity=fidelity(:,1);
   
    ug(:, i) = weight_GL(W, g, idx_fidelity, setdiff(1:n, idx_fidelity),0);
    uw(:, i) = weight_GL(W, g, idx_fidelity, setdiff(1:n, idx_fidelity),1);
    ub(:, i) = CUBE(W, g, idx_fidelity, setdiff(1:n, idx_fidelity));
    uwb(:, i) = WCUBE(W, g, idx_fidelity, setdiff(1:n, idx_fidelity));
end

[~, clustering_g] = max(ug');
[~, clustering_w] = max(uw');
[~, clustering_b] = max(ub');
[~, clustering_wb] = max(uwb');


fprintf('Accuracy of GL: %g, ', length(find(gnd==clustering_g')) / n);
fprintf('Accuracy of WGL: %g, ', length(find(gnd==clustering_w')) / n);
fprintf('Accuracy of BiH: %g, ', length(find(gnd==clustering_b')) / n);
fprintf('Accuracy of WBiH: %g, ', length(find(gnd==clustering_wb')) / n);