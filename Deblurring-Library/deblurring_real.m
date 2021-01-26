Img = imread('Orig2.png');
[r,c,~] = size(Img);

Img = Img(:,1:r,:);
%figure, imshow(Img);

%{

kernel = ones(6);
% Must be odd size so padd it
kernel = padarray(kernel, [1, 1], 'post');
sdImage = stdfilt(grayImage, kernel);
% Subsample since he wanted by 6-by6 block
sdImage = sdImage(1:6:end, 1:6:end,:);

subplot(2,2,1);
histogram(sdImage(:,:,:));
grid on;
title('Histogram of Standard Deviation Image');


subplot(2,2,2);
histogram(sdImage(:,:,1));
grid on;
title('Histogram of Standard Deviation Image: R');

subplot(2,2,3);
histogram(sdImage(:,:,2));
grid on;
title('Histogram of Standard Deviation Image: G');

subplot(2,2,4);
histogram(sdImage(:,:,3));
grid on;
title('Histogram of Standard Deviation Image: B');

% Threshold to find
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off');

%}



n = 2.5*randn(r);

% 4,80

h = fspecial('motion',4,80);
b = double(Img);

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

F2 = fft2(x1);

kerFreq2 = zeros(rh,ch);

[temp2,SNR2] = psnr(F2+N,F2);


for i=1:rh
    for j=1:ch
        
        kerFreq2(i,j) = (1/H(i,j)) * (((abs(H(i,j)))^2)/(((abs(H(i,j))^2)) + (1/SNR2)));
        
    end
end

g2 = real(ifft2(kerFreq2));

x2 = imfilter(b,g2);

x2 = uint8(x2);

    
figure,imshow(x2);
