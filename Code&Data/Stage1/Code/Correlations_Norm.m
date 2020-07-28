function Correlation = Correlations_Norm(Observed, TotalWeather, TotalWeatherList, targetlist)
%%
% 'TempOut','HumOut','Precipitation', 'WindDirection', 'WindSpeed','LocalPressure','Radiation','Sunlight'
% weatherlist = {'TempOut','HumOut','Precipitation', 'WindDirection', 'WindSpeed','LocalPressure','Radiation','Sunlight'};
% targetlist = {'TempIn','HumIn', 'CoilTemp','TempFac','HumFac'};


% [Observed, Weather,Condition] = Stage1_Preprocessing(plant, loc, weatherlist1,weatherlist2,add);
Observed = Observed(:,targetlist);
Observed_list = Observed.Properties.VariableNames;
Observed = table2array(Observed)';
Weather = TotalWeather(:,TotalWeatherList);

% if add == 0
%     Weather = Weather(:,weatherlist1);
% else
%     Weather = [Weather(:,weatherlist1) Weather(:,weatherlist2)];
% end
Weather_list = Weather.Properties.VariableNames;
Weather = table2array(Weather)';
Weather = normr(Weather);
Observed = normr(Observed);

%%
net = feedforwardnet(20);
net = configure(net, Weather, Observed);
net = init(net);
[net,tr] = train(net,Weather,Observed);

%% weights
w1 = net.IW{1}; %the input-to-hidden layer weights
w2 = net.LW{2}; %the hidden-to-output layer weights
b1 = net.b{1}; %the input-to-hidden layer bias
b2 = net.b{2}; %the hidden-to-output layer bias

Correlation = w2*w1;
Correlation = abs(Correlation);
Correlation = array2table(Correlation);
Correlation.Properties.VariableNames = Weather_list;
Correlation.Properties.RowNames = Observed_list;
