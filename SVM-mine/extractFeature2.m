function [feat] = extractFeature2(data)
    % the used features here are:
    % 3 lines per picture,
    % 6 corners per picture (3 found by Harris method, 3 found by Shi method)
    % 144 HOG feature
    
    addpath('./hog_feature_vector');
    
    [n,d] = size(data);
    
    % number of lines, corners and ho features
    feat_num = 3*6+2*6+144;
    feat = zeros(n,feat_num);
    
    for i=1:n
        
        %feat_idx = 0;
        
        sample = zeros(28,28);
        sample(:) = data(i,:);
        sample = sample';
        sample = sample(3:26,3:26);
        sample = imrotate(sample,33,'crop');
        
       
        BW = edge(sample,'canny');
        [H,T,R] = hough(BW,'RhoResolution',1,'Theta',-60:1:60);
        P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
        lines = houghlines(BW,T,R,P,'FillGap',2,'MinLength',9);
        
        max_num_of_lines = 3;
        num_of_lines = size(lines,2);
        feat_idx = 0;
        
        for i=1:max_num_of_lines
            if i>num_of_lines
                feat(i,feat_idx+1:feat_idx+6) = 0;
            else
                feat(i,feat_idx+1:feat_idx+2) = lines(i).point1(:);
                feat(feat_idx+3:feat_idx+4) = lines(i).point2(:);
                feat(feat_idx+5) = lines(i).theta;
                feat(feat_idx+6) = lines(i).rho;
            end
            feat_idx = feat_idx + 6;
        end
        
        ho = hog_feature_vector(sample);
        
        C1 = corner(sample,'MinimumEigenvalue',3);
        if size(C1,1) < 3
            while size(C1,1) < 3
                C1 = [C1;[0,0]];
            end
        end
        
        C2 = corner(sample,'Harris',3);
        if size(C2,1) < 3
            while size(C2,1) < 3
                C2 = [C2;[0,0]];
            end
        end
        
        
        feat(i,feat_idx+1:feat_idx+6) = C1(:);
        
        feat_idx = feat_idx+6;
        feat(i,feat_idx+1:feat_idx+6) = C2(:);
        
        feat_idx = feat_idx+6;
        feat(i,feat_idx+1:feat_idx+144) = ho(:);
    end
    
    %feat = [feat,ho];
end