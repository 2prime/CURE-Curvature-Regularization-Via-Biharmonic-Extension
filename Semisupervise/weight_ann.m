function y=weight_ann(data)
% the function to compute the weight matrix using kdtree


[m,n]=size(data);

num_s=50; % number of neighbors



kdtree = vl_kdtreebuild(data);
[idx, dist] = vl_kdtreequery(kdtree, data, data, 'NumNeighbors', num_s, 'MaxComparisons', min(n,2^10));


sigma=sparse([1:n],[1:n],1./max(dist(21,:),1e-2),n,n);

id_row=repmat([1:n],num_s,1);
id_col=double(idx);
w=exp(-(dist*sigma).^2);
y=sparse(id_row,id_col,w,n,n);

    