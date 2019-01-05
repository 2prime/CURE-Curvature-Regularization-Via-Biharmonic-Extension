function y=image2patch(f,x1,x2,px,py)

n=length(x1);
pad_f=padarray(f,[px,py],'symmetric','post');

[nx,ny]=size(pad_f);

k=px*py;
y=zeros(n,k);

for j=1:px
    for jj=1:py
        y(:,(j-1)*py+jj)=pad_f((x2+jj-2)*nx+(x1+j-1));
    end
end

