Img = imread('barbara.png');
[r,c] = size(Img);

%figure,imshow(Img);
Img = double(Img);
h = fspecial('disk',1);

b = imfilter(Img,h);
%figure,imshow(uint8(b));
n = 5*randn(r);

b = b + n;
%figure,imshow(uint8(b));

H = fft2(h);

B = fft2(b);
N = fft2(n);

[rh,ch] = size(H);

kerFreq1 = zeros(rh,ch);

for i=1:rh
    for j=1:ch
        
        kerFreq1(i,j) = (1/H(i,j));
        
    end
end

g1 = ifft2(kerFreq1);

x1 = imfilter(b,g1);

% Without using the normalization terms
%figure,imshow(uint8(x1));
%6000 gives the best output
F2 = zeros(r,c);

%3,2,20,10,1
alpha = 2;

for i=1:r
    for j=1:c
        
        F2(i,j) = 0.1*(sqrt(i^2 + j^2))^alpha;
        
    end
end

kerFreq2 = zeros(rh,ch);

[temp2,SNR2] = psnr(F2+N,F2);


for i=1:rh
    for j=1:ch
        
        kerFreq2(i,j) = (1/H(i,j)) * (((abs(H(i,j)))^2)/(((abs(H(i,j))^2)) + (1/SNR2)));
        
    end
end

g2 = real(ifft2(kerFreq2));

x2 = imfilter(b,g2);

% For the Ground Truth spectrum
figure,imshow(uint8(x2));
