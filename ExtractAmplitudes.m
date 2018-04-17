%% Extract amplitude averages over electrodes and time bins per participant

function GetAmplitudes(minval,maxval,elec)
min = 251+minval/2; % convert miliseconds to timepoints
max = 251+maxval/2;

if isempty(elec)
    elec = 1: length(Condition1.label{:});
end

Average = zeros(27,122);
for i = 1:27
   Average(i,1) = subjects(i);
   for k = 1:length(elec)
       l = elec(k);
       extract = mean(Condition1{i}.avg(l,min:max));
       average = mean(extract);
       Average(i,k) = mean(average);
       extract2 = mean(Condition2{i}.avg(l,min:max));
       average2 = mean(extract2);
       Average(i,k+61) = mean(average2);
   end
end

dlmwrite('ConditionAverages.txt',Average,'delimiter','\t');