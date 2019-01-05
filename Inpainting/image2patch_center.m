function y=image2patch_center(f,x1,x2,px_h,py_h)

n=length(x1);
pad_f=padarray(f,[px_h,py_h],'symmetric','both');

[nx,ny]=size(pad_f);

px=2*px_h+1;
py=2*py_h+1;

k=px*py;
y=zeros(n,k);

for j=1:px
    for jj=1:py
        y(:,(j-1)*py+jj)=pad_f((x2+jj-2)*nx+(x1+j-1));
    end
end

