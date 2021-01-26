Img = imread('lines.jpg');
[r,c,h] = size(Img);

Img = Img(:,:,1);

Img = double(Img);
h = fspecial('disk',3);

b = imfilter(Img,h);
n = 0.1*randn(r);

b = b + n;

figure,imshow(uint8(b));

lambda = 5000;
rho = 140;

% Have to find C from the image
C = fft2(h);

x = zeros(r,c);
z = zeros(r,c,2);
u = zeros(r,c,2);
v = zeros(r,c,2);


dx = [0,0,0;0,-1,1;0,0,0];
dy = [0,0,0;0,-1,0;0,1,0];

maxIters = 100;
I = eye(r);

alpha = imfilter(imfilter(I,c),c') + rho * (imfilter(imfilter(I,dx),dx') + imfilter(imfilter(I,dy),dy'));
%alpha = fft2(c) .* fft2(c) .* fft2(I) + rho * (fft2(dx) .* fft2(dx) .* fft2(I) + fft2(dy) .* fft2(dy) .* fft2(I));

for k=1:maxIters
   
    v = z-u;
    v1 = v(:,:,1);
    v2 = v(:,:,2);
    
    beta = imfilter(b,c') + rho * (imfilter(v(:,:,1),dx') + imfilter(v(:,:,2),dy'));
    
    gamma = beta/alpha;
    
    x = (gamma);
    
    max = findMax(x);
    
    for i=1:r
        for j=1:c

            x(i,j) = (x(i,j) / max) * 255;

        end
    end

    
    p = zeros(r,c,2);
    p(:,:,1) = imfilter(x,dx);
    p(:,:,2) = imfilter(x,dy);
    
    z = thres(p+u,lambda,rho);
    u = u + p - z;
    
end

x = abs(x);
max = findMax(x);
    
    for i=1:r
        for j=1:c

            x(i,j) = (x(i,j) / max) * 255;

        end
    end

figure,imshow(uint8(x));

function A = findMax(x)

    max = 0;
    [r,c] = size(x);
    
    for i=1:r
        for j=1:c
            
            if(x(i,j)>max) 
                max=x(i,j);
            end
            
        end
    end
        
    A = max;

end

function B = thres(A,lambda,rho)
    
    kappa = lambda/rho;

    [r,c,h] = size(A);
    
    for i=1:r
        for j=1:c
            for k=1:h
                
                if(A(i,j,k)>kappa) 
                    A(i,j,k) = A(i,j,k) - kappa;
                elseif (A(i,j,k) < -kappa)
                    A(i,j,k) = A(i,j,k) + kappa;
                else 
                    A(i,j,k) = 0;
                end
                
            end
        end
    end

    B = A;
end