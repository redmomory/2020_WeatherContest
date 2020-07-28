function y = Resolution(x, plant,loc)

Boryeong = [];
%%
for j = 1:2

plant = j;
load Plant1Train
load Plant2Train
load Weather1Train_boryeong
load Weather2Train_boryeong
%%
t1 = datetime(2016,4,1,0,0,0);
t2 = datetime(2019,3,31,23,50,0);
t = t1:minutes(10):t2';
Time = datevec(t);
Time(:,end) = [];
if plant == 1
    Train = Plant1Train;
    Weather = Weather1Train_boryeong;
else 
    Train = Plant2Train;
    Weather = Weather2Train_boryeong;
end
name  = Train.Properties.VariableNames;

%%
Train = table2array(Train);
for i = 1:length(Train(:,1))
    logical = Time(:,1:5) == Train(i,1:5);
    idx = find(sum(logical,2) == 5);
    data = Train(i,6:end);
    Time(idx,6:19) = data;
    Idx(i,:) = idx;
end
%%
Time = array2table(Time);
Time.Properties.VariableNames = name;

%%
for i = 1:length(Idx)-1
    A = Time(Idx(i),6:end);
    B = repmat(A,Idx(i+1)-Idx(i),1);
    Time(Idx(i):Idx(i+1)-1,6:end) = B;
end

Boryeong = setfield(Boryeong, ['Plant',num2str(j),'TrainBig'],Time);
end

