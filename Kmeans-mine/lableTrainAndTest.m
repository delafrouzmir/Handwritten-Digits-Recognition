function [trLb,tstLb] = lableTrainAndTest(trD,tstD,centers)
    
    trLb = zeros(size(trD,1),1);
    tstLb = zeros(size(tstD,1),1);
    for i=1:size(trD,1)
        dist = zeros(size(centers,1),1);
        for j=1:size(centers,1)
            dist(j) = (trD(i,:)-centers(j,:))*(trD(i,:)-centers(j,:))';
        end
        [minDist,trLb(i)] = min(dist);
    end
    for i=1:size(tstD,1)
        dist = zeros(size(centers,1),1);
        for j=1:size(centers,1)
            dist(j) = (tstD(i,:)-centers(j,:))*(tstD(i,:)-centers(j,:))';
        end
        [minDist,tstLb(i)] = min(dist);
    end
    trLb = trLb-1;
    tstLb = tstLb-1;
end