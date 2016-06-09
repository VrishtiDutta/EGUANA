function [peaktime, valleytime] = update_pv_rh(Data, peak, valley)
% update the peaktime and valleytime after deleting and adding points on
% the figure
peaktime=[]; valleytime=[];
i=1;
N=1;
length1 = size(Data,1);
length3=size(peak, 1);
length2=size(valley, 1);
 
 
 while N <= length1 & i<=length3 % find the peaktime from Data
    if peak(i) == Data(N,1)
         peaktime=[peaktime; Data(N, 2)];
         i=i+1;
     end
     N=N+1;
 end
 
 i=1;
 N=1;
 while N <= length1 & i<=length2 % find the valleytime from Data
    if valley(i) == Data(N,1)
        valleytime=[valleytime;Data(N, 2)];
        i=i+1;
    end
        N=N+1;
 end
