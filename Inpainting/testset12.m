clear;clc;

imgPath = 'Set12/';        % 图像库路径
imgDir  = dir([imgPath '*.png']); % 遍历所有jpg格式文件


% PSNR and SSIM
PSNRs_1 = zeros(1,length(imgDir));
SSIMs_1 = zeros(1,length(imgDir));
PSNRs_2 = zeros(1,length(imgDir));
SSIMs_2 = zeros(1,length(imgDir));
PSNRs_3 = zeros(1,length(imgDir));
SSIMs_3 = zeros(1,length(imgDir));
PSNRs_4 = zeros(1,length(imgDir));
SSIMs_4 = zeros(1,length(imgDir));


for index = 1:length(imgDir)          % 遍历结构体就可以一一处理图片了
fi = imread([imgPath imgDir(index).name]); %读取每张图片


%run vlfeat-0.9.21/toolbox/vl_setup;
%fi=imread('barbara_256by256.png');rng(48);
%fi = imread('10.png');
%fi=rgb2gray(fi);
f=double(fi);



[m,n,B] = size(f);
rate = 15e-2;
id_matrix_v=zeros(m,n,B);
for j=1:B
    id1 = randperm(m*n);%6553*1
    id = id1(1:floor(m*n*rate));%1*6553
    id_matrix=zeros(m,n);%256*256
    id_matrix(id)=1;
    id_matrix_v(:,:,j)=id_matrix;
end
id_matrix_v=(id_matrix_v>1/2);

fw=zeros(m*n,B);
for j=1:B
    id1=find(id_matrix_v(:,:,j));%6553*1
    id0=find(~id_matrix_v(:,:,j));%58983*1
    fw(id1+(j-1)*m*n)=f(id1+(j-1)*m*n);
    fw(id0+(j-1)*m*n)=mean(f(id1+(j-1)*m*n))+std(f(id1+(j-1)*m*n))*randn(size(id0));
end
fw=reshape(fw,m,n,B);

local_scale=3;
px_h=5;
py_h=5;

imwrite(uint8(f.*id_matrix),['res20/' 'i' imgDir(index).name]);

tic
uwi=inpaint_weight_GL2(fw,id_matrix,local_scale,px_h,py_h,f,1);
ug=inpaint_WCUBE(uwi,id_matrix,local_scale,px_h,py_h,f,0.05);
toc
PSNRs_1(index)=psnr(ug,f,255);
SSIMs_1(index)=ssim(ug,f);
imwrite(uint8(ug),['res20/' 'wbh' imgDir(index).name]);

tic
ug2=inpaint_CUBE(uwi,id_matrix,local_scale,px_h,py_h,f);
toc
PSNRs_2(index)=psnr(ug2,f,255);
SSIMs_2(index)=ssim(ug2,f);
imwrite(uint8(ug2),['res20/' 'bh' imgDir(index).name]);

tic
uw=inpaint_weight_GL(fw,id_matrix,local_scale,px_h,py_h,f,0);
toc
PSNRs_3(index)=psnr(uw,f,255);
SSIMs_3(index)=ssim(uw,f);
imwrite(uint8(uw),['res20/' 'gl' imgDir(index).name]);

tic
uw2=inpaint_weight_GL(fw,id_matrix,local_scale,px_h,py_h,f,1);
toc
PSNRs_4(index)=psnr(uw2,f,255);
SSIMs_4(index)=ssim(uw2,f);
imwrite(uint8(uw2),['res20/' 'wnll' imgDir(index).name]);



%tic
%uw=inpaint_weight_GL(fw,id_matrix,local_scale,px_h,py_h,f,0);
%toc





figure()
subplot(2,2,1);
imshow(f,[])
subplot(2,2,2);
imshow(uw2,[])
title(['WNLL PSNR:' num2str(psnr(uw2,f,255)) ';SSIM:' num2str(ssim(uw2,f))])
subplot(2,2,3);
imshow(ug,[])
title(['Weighted Biharmonic PSNR:' num2str(psnr(ug,f,255)) ';SSIM:' num2str(ssim(ug,f))])
subplot(2,2,4);
imshow(ug2,[])
title(['BiHarmonic PSNR:' num2str(psnr(ug2,f,255)) ';SSIM:' num2str(ssim(ug2,f))])
figure();

end;

