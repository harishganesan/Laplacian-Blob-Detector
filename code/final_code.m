tic
img1 = imread('../output/animals.jpg');
img1 = rgb2gray(img1);
img1 = im2double(img1);
[h w] = size(img1);
n=15;
k = 1.18;
thresh = 0.003;
scale_space1 = zeros(size(img1,1),size(img1,2),n);

for i = 1:n
    sigma = 2;
    sigma = sigma * k^(i-1);
    hsize = 2*ceil(3*sigma)+1;
    log_f1 = sigma^2 * fspecial('log',hsize,sigma);
    img2 = imfilter(img1, log_f1,'same','replicate');
    img2 = img2.^2;
    scale_space1(: ,: , i) = img2;
    B(:,:,i) = ordfilt2(scale_space1(: ,: , i),25,true(5));
end


    [M, I] = max(B,[],3);
    
    
    M = repmat(M,1,1,n);

    XYZ=  scale_space1 .* ( scale_space1 == M);
    
    
    Indices = find(XYZ >= thresh);
    [x1, y1, z1] = ind2sub(size(XYZ),Indices);
    rad = zeros(size(x1,1),1);
    
    
    for m = 1:size(x1,1)
            ind = I(x1(m),y1(m));
            sigma = 2;
            sigma = sigma * k^(ind-1);
            radius = sigma*sqrt(2);
            rad(m)=radius;
    end
    

toc   
    
    show_all_circles(img1,y1,x1,rad);
 
