function uf=weight_BiH(W,g,id,id_c);

n=size(W,1);
uf=zeros(n,1);
uf(id)=g;
u=uf(id_c);

reg=10;
gamma=n/length(id);

W_Laplace_full=W+(W');
W_Laplace=W_Laplace_full(id_c,id_c);
W_Ls=W(id,id_c)';
coe_matrix=diag(sum(W_Laplace_full(id_c,:),2)+gamma*sum(W_Ls,2))-W_Laplace;
LAP = diag(sum(W_Laplace_full,2))-W_Laplace_full;

g1 = zeros(size(W_Laplace_full,1),1);
g1(id) = g;
g1 = -LAP*(LAP*g1);
rhs = g1(id_c);
rhs = reg*rhs + (W_Laplace_full(id_c,id)+gamma*W_Ls)*g;

L = ichol(coe_matrix);
Lt=L';

u=pcg(@BiH,rhs,1e-4,100,L,Lt,u);
uf(id_c)=u;




function y = BiH(u)
    u1 = zeros(size(LAP,1),1);
    u1(id_c) = u;
    u1 = LAP*(LAP*u1);
    y = u1(id_c);
    y = reg*y + coe_matrix*u;
end
end