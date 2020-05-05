%% finds the nearest center to each test data and lables it
function [tstLb] = lableTest(tstD,centers)
    
    tstLb = zeros(size(tstD,1),1);
    for i=1:size(tstD,1)
        dist = zeros(size(centers,1),1);
        for j=1:size(centers,1)
            dist(j) = (tstD(i,:)-centers(j,:))*(tstD(i,:)-centers(j,:))';
        end
        [minDist,tstLb(i)] = min(dist);
    end
    tstLb = tstLb-1;
end