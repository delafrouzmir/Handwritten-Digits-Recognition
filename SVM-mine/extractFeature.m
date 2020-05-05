function [feat] = extractFeature(data)
    
    % many different features were tested here:
    % 1- the number of white pixels in each row, column, 4*4 square, and 15 degree angle
    % 2- HOG features
    % 3- HOUGH features
    % 4- Canny edge detector
    % 5- Harris and Shi corner detectors
    % 6- Hough line detector
    
    addpath('./hog_feature_vector');
    
    [n,d] = size(data);
    
    %feat_num = (28+28+16+28*28+144+28*28);
    %feat_num = 67*121+144;
    feat_num = 24*24+144+67*121;
    feat = zeros(n,feat_num);
    % hog = zeros(n,28*28+144);
    
    %data = data ./ 255;
    
    %[tr,coeff] = triangled();
    %each_tr = zeros(28,28);
    for i=1:n
        
        feat_idx = 0;
        
        sample = zeros(28,28);
        sample(:) = data(i,:);
        sample = sample';
        sample = sample(3:26,3:26);
        sample = imrotate(sample,33,'crop');
%         feat(i,:) = sample(:);
        
        
%         for j=1:28
%             feat(i,feat_idx+j) = sum(sample(j,:))/255;
%         end
%         
%         feat_idx = feat_idx+28;
%         
%         for j=1:28
%             feat(i,feat_idx+j) = sum(sample(:,j))/255;
%         end
%         
%         feat_idx = feat_idx+28;
%         for j=1:4
%             for k=1:4
%                 feat(i,feat_idx+(j-1)*4+k) = sum(sum(sample ( (j-1)*4+1:j*4 , (k-1)*4+1:k*4 )))/255;
%             end
%         end
%         
%         feat_idx = feat_idx+16;
%         
        ho = hog_feature_vector(sample);
        BW = edge(sample,'canny');
%         
        feat( i,feat_idx+1 : feat_idx+24*24 ) = BW(:);
%         
        feat_idx = feat_idx + 24*24;
        feat( i,feat_idx+1 : feat_idx+144 ) = ho;
        
        feat_idx = feat_idx+144;
        %feat( i,feat_idx+1 : feat_idx+28*28 ) = data(i,:);
        
        %feat_idx = feat_idx+28*28;

        [H,T,R] = hough(BW,'RhoResolution',1,'Theta',-60:1:60);
        feat(i, feat_idx+1 : feat_idx+67*121) = H(:);

        %feat(i,feat_idx:feat_num) = hog_feature_vector(sample);
%         feat_idx = feat_idx+16;
%         for j=1:24
%             
%             for k=1:(28*28)
%                 each_tr(k) = sum(tr{k}==j);
%             end
%             
%             feat(i,feat_idx+j) = sum(sum( sample.*each_tr.*coeff ));
%         end
        
    end
    
    %feat = [feat,ho];
end