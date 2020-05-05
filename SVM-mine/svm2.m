tr = csvread('train.csv',1,0);
trSz = size(tr);
trD = tr(:,2:trSz(2));
trLb = tr(:,1);

tstD = csvread('test.csv',1,0);
tstLb = zeros(size(tstD,1),1);
addpath('libsvm-3.21/matlab');

% added on April 30th
% trD = extractFeature(trD);
tstD = extractFeature2(tstD);

[sampleTrD,sampleTrLb] = sampling(trD,trLb,1000);
sampleTrD = extractFeature2(sampleTrD);

%% PCA
% added on May 4
% pcaCoeff = pca([sampleTrD;tstD]);
% pcaCoeff = pcaCoeff(1:500,:);
% sampleTrD = sampleTrD*pcaCoeff';
% tstD = tstD*pcaCoeff';

[samp_N,samp_D] = size(sampleTrD);

%% Tune C and Gamma for linear kernel
[bestC,bestGamma,maxAcc] = tuneCandGamma (sampleTrLb,sampleTrD);
% results of this part:

% best C and gamma for Corners
%bestGamma = 2^(-15);
%bestC = 2^(15);

% best C and gamma for [hog,canny,hough] features
% bestGamma = 2^(-13);
% bestC = 2^(5);

model = svmtrain(sampleTrLb, sampleTrD, sprintf('-s 0 -t 2 -c %f -g %f',bestC, bestGamma));
[predictLb, ~, ~] = svmpredict(tstLb, tstD, model);
csvwrite('result11may_v2.csv',[[1:28000]',predictLb]);