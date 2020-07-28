function y = SavetoCSV(Stage1Results)
%%
for plant = 1:1
    for loc = 1:3
        %%
        T24 = getfield(Stage1Results, ['Mdl1',day],['Plant',num2str(plant),'Loc',num2str(loc)],'H24'); 
        D1 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
        T24 = [D1(:,1:5) T24];
        T24.Properties.VariableNames = {'Year','Month','Day','Hour','Minute','temp_in','hum_in','temp_coil','temp_out','hum_out'};
        name = ['Test_P',num2str(plant),'_L',num2str(loc),'_24.csv'];
        writetable(T24, name)
        %%
        T48 = getfield(Stage1Results, ['Mdl1',day],['Plant',num2str(plant),'Loc',num2str(loc)],'H48'); 
        D2 = readtable(['P',num2str(plant),'_L',num2str(loc),'_W24.csv']);
        T48 = [D2(:,1:5) T48];
        T48.Properties.VariableNames = {'Year','Month','Day','Hour','Minute','temp_in','hum_in','temp_coil','temp_out','hum_out'};
        name = ['Test_P',num2str(plant),'_L',num2str(loc),'_48.csv'];
        writetable(T48, name)
    end
end