function y = NNregress(TrainX,TrainY)

% TrainX = table2array(TrainX);
% TrainY = TrainY.wp1;

% CVNum=3;
% CV=cvpartition(size(TrainX,1),'kfold',CVNum);
% RMSE=[];
% 

% for t=1:1:1
    
    %
% X1=TrainX(training(CV,t),:);
% Y1=TrainY(training(CV,t),:);
        
% X2=TrainX(test(CV,t),:);    
% Y2=TrainY(test(CV,t),:);

    P=TrainX';
    T=TrainY';
    
    %% Parameter 
    NNSize=40;                      % < 100
    NNTestRatio=0.1;
    NNValNum=30;
    
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
    net.trainFcn='trainscg';  %'trainbr'  trainscg  trainlm traingdx trainrp traingdm trainbfg traincgp traincgb
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
    % net.trainParam.mu_dec=0.8; % 0.8
    % net.trainParam.mu_inc= 1.5;
    % net.trainParam.mu_max = 1e10;
    % net.trainParam.show=Command.NNValNum;
    % net.trainParam.showWindow=1;
    % net.trainParam.min_grad=1e-10;
    %net.trainParam.sigma=5e-5;
    %net.trainParam.lambda=5e-7;
    % net.trainParam.minstep=0.0001;
    
    %% Training
    net = configure(net,P,T);
    [y,~] = train(net,P,T,'ShowResources','yes');
%        ,'useParallel','yes','useGPU','yes'
    %% Forecasting
%     y = sim(net,X2')';  
%    E=bsxfun(@minus,SubTestOutput,Y2);
%     RMSE=[RMSE sqrt(mean(E.^2))];  
%     TrainOutput = [TrainOutput SubTestOutput]; 
end
% end
