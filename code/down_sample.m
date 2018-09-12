tic
img1 = imread('../output/animals.jpg');
img1 = rgb2gray(img1);
img1 = im2double(img1);
[h w] = size(img1);
n=15;
k = 1.18;
thresh = 0.003;



for i = 1:n
    img3 = imresize(img1,  1/(k^(i-1)));
    filt_size = 2*ceil(3*2)+1;
    log_f2 = 2^2 * fspecial('log',filt_size,2);
    img4 = imfilter(img3, log_f2,'same','replicate');
    img4 = img4.^2;
    scale_space2(:,:,i) = imresize(img4, [h w]);
end


for i = 1:n
    B4(:,:,i) = ordfilt2(scale_space2(:,:,i),9,true(3));
end

[M3, I2] = max(B4,[],3);
    
    
    M2 = repmat(M3,1,1,n);
    
    XYZ2=  scale_space2 .* ( scale_space2 == M2);
    
    
    Indices2 = find(XYZ2 >= thresh);
    [x2, y2, z2] = ind2sub(size(XYZ2),Indices2);
    rad2 = zeros(size(x2,1),1);
    
    
    for m = 1:size(x2,1)
            ind2 = I2(x2(m),y2(m));
            sigma2 = 2;
            sigma2 = sigma2 * k^(ind2-1);
            radius2 = sigma2*sqrt(2);
            rad2(m)=radius2;
    end
   toc
     
    
    show_all_circles(img1,y2,x2,rad2);
    
        

        




