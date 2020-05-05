%% find the centers based on the training data with their lables
% trD is the n*d train Data
% trLb is n*1 lables for train data
% k = 10 number of cluster
% centers is a 10*d for centroids
function [centers] = findCenters(trD, trLb, k)
    
    centers = zeros(k,size(trD,2));
    num = zeros(k,1);
    for i=1:size(trD,1)
       centers(trLb(i)+1,:) = centers(trLb(i)+1,:) + trD(i,:);
       num(trLb(i)+1) = num(trLb(i)+1)+1;
    end
    for i=1:k
        centers(i,:) = centers(i,:)./num(i);
    end
end