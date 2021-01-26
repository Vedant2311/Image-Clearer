%{
Img = imread('barbara.png');

Img=Img(50:150,350:450);
[r,c] = size(Img);


figure,imshow(Img);

ImgNoisy = imnoise(Img,'salt & pepper',0.3);

figure,imshow(uint8(ImgNoisy));
Img = double(Img); 
%}

maxRGB = max(max(ImgOut));
minRGB = min(min(ImgOut));
s=21;
k=7;
max = max(max(Img));

ImgOutSimple = zeros(r-s-k,c-s-k);

for i=1:r-s-k
    for j = 1:c-s-k
            ImgOutSimple(i,j) = ((ImgOut(i,j)- minRGB)/(maxRGB-minRGB))*max;
    end
end

figure,imshow(uint8(ImgOutSimple));

%{
ImgOut = xlsread('Img_100.xlsx');


figure, imshow(uint8(ImgOut));

%}

%{
sigma = 20.0;
h = 10.0 * sigma;
a=2;
k=7;
s=21;

ImgOut = zeros(r-s-k,c-s-k);

for i=((s+k+2)/2) : (r - ((s+k)/2))
      i
    for j=((s+k+2)/2) : (c - ((s+k)/2))
           
           
           ImgOut((i-((s+k+2)/2)+1),(j-((s+k+2)/2)+1)) = addSum(Img,i,j,k,h,s);
           
    end
end

figure,imshow(uint8(ImgOut));

function D = addSum(Img,x,y,k,h,s)
    sum = 0.0;

    for i=(x - ((s-1)/2)) : (x + ((s-1)/2))

           for j= (y - ((s-1)/2)) : (y + ((s-1)/2))
                
                  sum = sum + weight(x,y,i,j,Img,h,k,s) * (double(Img(i,j)));
               
           end

    end
  
    D = sum;  

end

function C = euclDist(Img,x,y,i,j,k)

   
    A1 = takeNeighbour(x,y,Img,k);
    A2 = takeNeighbour(i,j,Img,k);
    
    A = A1 - A2;
    
    D = A' * A;
    C = max(eig(D)); 
  


end

function B = takeNeighbour(x,y,Img,k)
    
   C = zeros(k,k);
   
   for i =(x-((k-1)/2)) : (x+((k-1)/2))
       
       for j= (y-((k-1)/2)) : (y+((k-1)/2))
   
           
           C(i-((x-((k-1)/2)))+1,j-((y-((k-1)/2)))+1)= Img(i,j);
           
       end
       
   end
   
   B = C;

end

function B = weight(x,y,i,j,Img,h,k,s)
    
    B = (1.0/calZ(x,y,Img,h,k,s)) * (exp((euclDist(Img,x,y,i,j,k))/(-h*h)));
    
end

function A = calZ(x,y,Img,h,k,s)

    sum = 0.0;


    for i= (x - ((s-1)/2)) : (x + ((s-1)/2))

           for j=(y - ((s-1)/2)) : (y + ((s-1)/2))
                
               sum = sum + exp((euclDist(Img,x,y,i,j,k))/(-h*h));
               
           end

    end

    
    A = sum;
    
end

%}