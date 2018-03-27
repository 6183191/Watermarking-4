clear all
close all
[a, map]=imread('D:\VIT\6TH SEMESTER\CYBER SECURITY(CSE4003)\Project\panda.jpg');
[wa, map1]=imread('D:\VIT\6TH SEMESTER\CYBER SECURITY(CSE4003)\Project\vit.jpg');
%ORIGINAL IMAGE
i=a(:, :, 2);
sXi=size(i);

figure(1);imshow(i);title('ORIGINAL IMAGE');
[LL1,LH1,HL1,HH1]=dwt2(i,'db1');
[LL2,LH2,HL2,HH2]=dwt2(LL1,'db1');
[LL3,LH3,HL3,HH3]=dwt2(LL2,'db1');
%WATERMARK IMAGE
wm=wa(:, :, 2);
wm1=im2double(wm);
sXw=size(wm);
figure(2);imshow(wm);title('WATERMARK');
wm=arnoldTest(wm,1);
wm1=arnoldTest(wm1,1);
figure(3);imshow(wm1);title(' SCRAMBLED WATERMARK');
 
[WLL1,WLH1,WHL1,WHH1]=dwt2(wm,'db1');
[WLL2,WLH2,WHL2,WHH2]=dwt2(WLL1,'db1');
[WLL3,WLH3,WHL3,WHH3]=dwt2(WLL2,'db1');
%Alpha blending process
k=0.99;
q=0.009;
WMLL=k*(LL3) + q*(WLL3);
WMLH=k*(LH3) + q*(WLH3);
WMHL=k*(HL3) + q*(WHL3);
WMHH=k*(HH3) + q*(WHH3);
X = idwt2(WMLL,WMLH,WMHL,WMHH,'db1');
X1 = idwt2(X,[],[],[],'db1');
X2 = idwt2(X1,[],[],[],'db1');
figure(4)
imshow(uint8(X2));title('Watermarked Image');
 
[WM1,WM2,WM3,WM4]=dwt2(X2,'db1');
[WM11,WM22,WM33,WM44]=dwt2(WM1,'db1');
[WM1,WM2,WM3,WM4]=dwt2(WM11,'db1');
RMLL=(WM1-(k*LL3))/q;
RMLH=(WM2-(k*LH3))/q;
RMHL=(WM3-(k*HL3))/q;
RMHH=(WM4-(k*HH3))/q;
Y = idwt2(RMLL,RMLH,RMHL,RMHH,'db1');
Y1 = idwt2(Y,[],[],[],'db1');
Y2 = idwt2(Y1,[],[],[],'db1');
Y2=iarnoldTest(Y2,1);
figure(5)
imshow(uint8(Y2));title('Extracted Watermark');
 
%PSNR AND MSE COVER IMAGE
M=sXi(1);
N=sXi(2);
SEI=(double(i)-double(X2)).^2;
MSE = sum(sum(SEI))/(M*N);
PSNR = 10*log10(256*256/MSE);
fprintf('\nMSE: %7.2f ', MSE);
fprintf('\nPSNR: %9.7f dB', PSNR);
 
%PSNR AND MSE FOR RECOVERED WATERMARK
M1=sXw(1);
N1=sXw(2);
SEI1=(double(wm)-double(Y2)).^2;
MSE1 = sum(sum(SEI1))/(M*N);
PSNR1 = 10*log10(256*256/MSE1);
fprintf('\nMSE: %7.2f ', MSE1);
fprintf('\nPSNR: %9.7f dB', PSNR1);
