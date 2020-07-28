function RMSE = Stage1_CrossVal(Weather, Observed, Goodfactors, targetlist)



%%

idx = Observed.Year == 2018;
ValidatedY = Observed(idx,:);
Observed(idx,:) = [];
ValidatedX = Weather(idx,:);
Weather(idx,:) = [];
%%

parfor i = 1:length(targetlist)
    %%
    target = Observed(:, targetlist{:,i});
    %%
    mdl = Function(Weather(:,getfield(Goodfactors, targetlist{:,i})), target,10,0.01,3000);
    %%
    For = predict(mdl,ValidatedX(:,getfield(Goodfactors, targetlist{:,i})));
    Sol = ValidatedY(:,targetlist{:,i});
    Sol = table2array(Sol);
    idx = isnan(Sol);
    For(idx) = [];
    Sol(idx) = [];
    RMSE(i) =sqrt(sum(For - Sol).^2)/length(For);
end
    
