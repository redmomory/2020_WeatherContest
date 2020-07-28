function [FinalModel] = Function(Weather, target, maxnumsplits, learningrate, treenums)

%%

t = templateTree('Surrogate','on',...   
    'NumVariablesToSample','all', ...    
    'MinLeafSize',2,...
    'MaxNumSplits',maxnumsplits,...     
    'Prune','off'); 
%
%'MinParentSize',5,...
% 'MinLeafSize',2,...
%'MaxNumSplits', 5,...    % if only the same weekday is anlayzed, please use 2 or 3
%  'QuadraticErrorTolerance',1e-4

FinalModel = fitrensemble(Weather,target,...
    'Method','LSBoost', ... % Bag
    'NumLearningCycles',treenums,...
    'Learners',t,...
    'LearnRate',learningrate, ...
    'CrossVal','off',...
    'NPrint',100,...
    'Resample','on', ...
    'FResample',1,...
    'Replace','off',...    % Must Off
    'CategoricalPredictors',[1,2,3],... % 5: Hour 7: Weekday
    'OptimizeHyperparameters','none'...
    );