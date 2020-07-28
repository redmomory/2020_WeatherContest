function y=NN(TrainX,TrainY)

TrainX = table2array(TrainX);
TrainY = TrainY.wp1;

%% Cross validation

CVNum=3;
CV=cvpartition(size(TrainX,1),'kfold',CVNum);
RMSE=[];

for t=1:1:CVNum

X1=TrainX(training(CV,t),:);
Y1=TrainY(training(CV,t),:);
        
X2=TrainX(test(CV,t),:);    
Y2=TrainY(test(CV,t),:);
        
%% Parameter 

NNSize=1000;                      % < 100
NNTestRatio=0.3;
NNValNum=30;
% NNFunction='trainlm';

%% Data Ratio
TrainRatio=1-NNTestRatio;
ValRatio=NNTestRatio;
TestRatio=0;
    
%% Setting the NN
    Number=NNSize; % ceil(Command.NNSize/size(TrainX,2));
    Number=round(Number);
    net = feedforwardnet(Number); % 40 is good
    
    %% initialization
    net.initFcn='initlay';
    net.layers{1}.transferFcn='tansig';  % tansig
    net.layers{1}.initFcn='initnw';
    net.layers{2}.transferFcn='purelin';
    net.layers{2}.initFcn='initnw';
    %% Training Mode
    % traincgp trainscg trainlm
    net.trainFcn='trainlm';  %'trainbr'  trainscg  trainlm traingdx trainrp traingdm trainbfg traincgp traincgb
    net.divideMode = 'sample';  % sample none
    net.divideFcn='dividerand';  %'divideblock'; dividerand divideind 'divideint',
    net.performFcn= 'msereg';
    %% Training, Varlidation, Test
    net.divideParam.trainRatio=TrainRatio;
    net.divideParam.valRatio=ValRatio;
    net.divideParam.testRatio=TestRatio;
    %net.performParam.ratio = 0.5;
    
    net.trainParam.epochs = 3000;
    net.trainParam.time=10*60;      % Second
    net.trainParam.goal =0.001;
    net.trainParam.max_fail=NNValNum;
    net.trainParam.mu = 1;
    %% Training
    net = configure(net,X1,Y1);
    [net,~] = train(net,X1,Y1);
    
    
    %% Train
    TrainOutput= sim(net,TrainX')';
    TrainSave(:,t)=TrainOutput;
    
    
    %% Forecasting
    SubTestOutput = sim(net,X2)';
    TestSave(:,t)=TestOutput;
   
E=bsxfun(@minus,SubTestOutput,Y2);
RMSE=[RMSE sqrt(mean(E.^2))];  

end
y=RMSE;
end

