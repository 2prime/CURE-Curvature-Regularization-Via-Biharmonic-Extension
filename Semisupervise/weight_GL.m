function uf=weight_GL(W,g,id,id_c,flag)

% W:       weight matrix;
% g:       labeled value;
% id:      index of labeled points;
% id_c:    index of unlabeled points;
% max_ite: number of iterations.
% flag:    flag=1, weight GL; flag=0 GL

n=size(W,1);
uf=zeros(n,1);
uf(id)=g;
u=uf(id_c);




W_Laplace_full=W+(W');

if flag==0
    gamma=0;% standard GL
else
    gamma=n/length(id);% weight GL
end


W_Laplace=W_Laplace_full(id_c,id_c);
W_Ls=W(id,id_c)';
coe_matrix=diag(sum(W_Laplace_full(id_c,:),2)+gamma*sum(W_Ls,2))-W_Laplace;

rhs=(W_Laplace_full(id_c,id)+gamma*W_Ls)*g;




L = ichol(coe_matrix);
Lt=L';

u=pcg(coe_matrix,rhs,1e-4,100,L,Lt,u);
uf(id_c)=u;
