% M = csvread(filename,R1,C1)

tr = csvread('train.csv',1,0);
trSz = size(tr);
trD = tr(:,2:trSz(2));
trLb = tr(:,1);

tstD = csvread('test.csv',1,0);
tstLb = zeros(size(tstD,1),1);

k = max(trLb)-min(trLb)+1;
MAX_ITER = 20;

centers = findCenters(trD, trLb, k);

newTrLb = trLb;
tstLb = lableTest(tstD,centers);

trAcc = zeros(MAX_ITER,1);
tstLbChange = zeros(MAX_ITER,1);

for i=1:MAX_ITER
    oldTstLb = tstLb;
    centers = updateCenters(trD,newTrLb,tstD,tstLb,k);
    [newTrLb,tstLb] = lableTrainAndTest(trD,tstD,centers);
    trAcc(i) = sum(newTrLb==trLb)/size(trLb,1);
    tstLbChange(i) = sum(oldTstLb==tstLb)/size(tstLb,1);
end
figure();
plot((1:20),trAcc);
figure();
plot((1:20),tstLbChange);
