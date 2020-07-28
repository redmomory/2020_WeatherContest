function Stage1_Mdl = Stage1_Training_V2(Weather, Observed, targetlist, Goodfactors, numtree)


Stage1_Mdl = {};
parfor i = 1:length(targetlist)
    target = Observed(:, targetlist{:,i});
    mdl = Function(Weather(:,getfield(Goodfactors, targetlist{:,i})), target,10,0.01,numtree);
    Stage1_Mdl{i} = mdl;
end
