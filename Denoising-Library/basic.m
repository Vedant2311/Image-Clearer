Img = imread('barbara.png');
[r,c] = size(Img);


%{

G = randn(r);
ImgNoisy = double(Img) + 100*G;
figure,imshow(uint8(ImgNoisy));

h1= 1/3*ones(3,1);
h2 = 1/5*ones(5,1);
h3 = 1/7*ones(7,1);
h4 = 1/9 * ones(9,1);
h5 = 1/11 * ones(11,1);

mean3 = h1*h1';
mean5 = h2 *h2';
mean7 = h3 * h3';
mean9 = h4 * h4';
mean11= h5 * h5';

imfilt1 = filter2(mean3,ImgNoisy);
imfilt2 = filter2(mean5,ImgNoisy);
imfilt3 = filter2(mean7,ImgNoisy);
imfilt4 = filter2(mean9,ImgNoisy);
imfilt5 = filter2(mean11,ImgNoisy);


psnr_mean3 = psnr(uint8(imfilt1),(Img));
psnr_mean5 = psnr(uint8(imfilt2),(Img));
psnr_mean7 = psnr(uint8(imfilt3),(Img));
psnr_mean9 = psnr(uint8(imfilt4),(Img));
psnr_mean11 = psnr(uint8(imfilt5),(Img));


figure,  imshow(uint8(imfilt4));
%figure,  imshow(uint8(imfilt2));
%figure,  imshow(uint8(imfilt3));

imfiltMed1 = medfilt2(ImgNoisy,[3,3]);
imfiltMed2 = medfilt2(ImgNoisy,[5,5]);
imfiltMed3 = medfilt2(ImgNoisy,[7,7]);
imfiltMed4 = medfilt2(ImgNoisy,[9,9]);
imfiltMed5 = medfilt2(ImgNoisy,[11,11]);

psnr_med3 = psnr(uint8(imfiltMed1),(Img));
psnr_med5 = psnr(uint8(imfiltMed2),(Img));
psnr_med7 = psnr(uint8(imfiltMed3),(Img));
psnr_med9 = psnr(uint8(imfiltMed4),(Img));
psnr_med11 = psnr(uint8(imfiltMed5),(Img));


figure,  imshow(uint8(imfiltMed4));
%figure,  imshow(uint8(imfiltMed2));
%figure,  imshow(uint8(imfiltMed3));
%}

%{
ImgNoisy = imnoise(Img,'salt & pepper',0.3);
figure, imshow(uint8(imnoise(Img,'salt & pepper',0.3)));

h1= 1/3*ones(3,1);
h2 = 1/5*ones(5,1);
h3 = 1/7*ones(7,1);
h4 = 1/9 * ones(9,1);
h5 = 1/11 * ones(11,1);

mean3 = h1*h1';
mean5 = h2 *h2';
mean7 = h3 * h3';
mean9 = h4 * h4';
mean11= h5 * h5';

imfilt1 = filter2(mean3,ImgNoisy);
imfilt2 = filter2(mean5,ImgNoisy);
imfilt3 = filter2(mean7,ImgNoisy);
imfilt4 = filter2(mean9,ImgNoisy);
imfilt5 = filter2(mean11,ImgNoisy);


psnr_mean3 = psnr(uint8(imfilt1),(Img));
psnr_mean5 = psnr(uint8(imfilt2),(Img));
psnr_mean7 = psnr(uint8(imfilt3),(Img));
psnr_mean9 = psnr(uint8(imfilt4),(Img));
psnr_mean11 = psnr(uint8(imfilt5),(Img));


%figure,  imshow(uint8(imfilt1));
%figure,  imshow(uint8(imfilt2));
figure,  imshow(uint8(imfilt3));

imfiltMed1 = medfilt2(ImgNoisy,[3,3]);
imfiltMed2 = medfilt2(ImgNoisy,[5,5]);
imfiltMed3 = medfilt2(ImgNoisy,[7,7]);
imfiltMed4 = medfilt2(ImgNoisy,[9,9]);
imfiltMed5 = medfilt2(ImgNoisy,[11,11]);

psnr_med3 = psnr(uint8(imfiltMed1),(Img));
psnr_med5 = psnr(uint8(imfiltMed2),(Img));
psnr_med7 = psnr(uint8(imfiltMed3),(Img));
psnr_med9 = psnr(uint8(imfiltMed4),(Img));
psnr_med11 = psnr(uint8(imfiltMed5),(Img));


%figure,  imshow(uint8(imfiltMed1));
%figure,  imshow(uint8(imfiltMed2));
figure,  imshow(uint8(imfiltMed3));

%}