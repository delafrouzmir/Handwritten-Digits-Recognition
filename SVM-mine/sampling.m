function [sampleTrD,sampleTrLb] = sampling(trD,trLb,k)

    [n,d] = size(trD);
    sampleTrD = zeros(10*k,d);
    sampleTrLb = zeros(10*k,1);
    
    for i=0:9
        snum = 0;
        j=1;
        while snum < k && j < n
            if trLb(j) == i
                snum = snum+1;
                sampleTrD(i*k+snum,:) = trD(j,:);
                sampleTrLb(i*k+snum) = trLb(j);
            end
            j = j+1;
        end
    end
end