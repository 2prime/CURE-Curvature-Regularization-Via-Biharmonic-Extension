function uf=weighted_BiH(W,g,id,id_c)

n=size(W,1);
uf=zeros(n,1);
uf(id)=g;
u=uf(id_c);

%reg=100;
gamma=n/(length(id));
%gamma=0;


d=zeros(n,1);
d(id)=gamma;%gamma^2  sqrt(gamma)
d(id_c)=1;

W_Laplace_full=W+(W');
W_Laplace=W_Laplace_full(id_c,id_c);
W_Ls=W(id,id_c)';
LAP = diag(sum(W_Laplace_full,2))-W_Laplace_full;
x=1:1:n;
A = LAP(id_c,x);

coe = (diag(sum(W_Laplace_full(id_c,:),2)+gamma*sum(W_Ls,2))-W_Laplace);
g1 = zeros(size(W_Laplace_full,1),1);
g1(id) = g;
rhs = -Regularization(g1);
%rhs = reg*rhs + (W_Laplace_full(id_c,id)+gamma*W_Ls)*g;

L = ichol(coe);
Lt=L';

u=pcg(@BiH,rhs,1e-4,100,L,Lt,u);
uf(id_c)=u;


function y=Regularization(u)
 y = A*(d.*(LAP*u));
end

function y = BiH(u)
    u1 = zeros(size(LAP,1),1);
    u1(id_c) = u;
    y = Regularization(u1);
  %  y = reg*y + coe*u;
end

end