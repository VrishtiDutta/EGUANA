function [velocity, ampl, velo1,dur, stiffness, cvalue, xtime, percent,...
 ampl2, velo2 ,dur2, stiff2, cvalue2, xtime2, percent2, val000,val2000,...
 peakinsample,peak,peaknumber]=...
 stiffness_var_rhv2(signal,rate,peaknumber,valleynumber,peakinsample,...
 valleyinsample, peak, valley)
 % This program is to calculate stiffness and other parameters.
 % the version 2 it is obriged that the valley appears first that the peak
 % so if a peak appears earlier than valley does, it is ignored.
 % If you want to count with thise first peak, use vertion 1 
 % (stiffness_var_rh.m) 

 % Last update: 22/07/10 by Rafael H 
 %-------------------------------------------------------------------------
  
 %velocity of all signal
 [velocity]=AFGELEID(signal,rate);
 
 %Calculates the RMS value. First square velocity values,
 %then take their mean, then take square of mean
 rmsvalue=power((mean(power(velocity,2))),0.5);
 val000=num2str(rmsvalue);

 
 %The valley have to appear earlier than peak does.
 if (peakinsample(1)<valleyinsample(1))
 peakinsample=peakinsample(2:end);
 peak=peak(2:end);
 peaknumber=peaknumber-1;
 end
 
 %variable inicialization
 c=valleynumber-1;
 velo1=zeros(1,c);
 ampl=zeros(1,c);
 dur=zeros(1,c);
 stiffness=zeros(1,c);
 cvalue=zeros(1,c);
 percent=zeros(1,c);
 velo2=zeros(1,c);
 ampl2=zeros(1,c);
 dur2=zeros(1,c);
 stiff2=zeros(1,c);
 cvalue2=zeros(1,c);
 percent2=zeros(1,c);
 

for i=1:c
     
%1st movement (velley to peak)-----        
        
    %velocity of each segment of the signal  (use the max velocity) 
    [maxvel,maxvelind]=max(velocity(valleyinsample(i):peakinsample(i)));
    
    
    velo1(i)=maxvel;% velocity  
    ampl(i)= peak(i)-valley(i);%amplitude
    dur(i)=(peakinsample(i)-valleyinsample(i))/rate;%duration
    stiffness(i)=velo1(i)/ampl(i);%stiffness
    cvalue(i)=stiffness(i)*dur(i);%cvalue
    xtime=maxvelind/rate; percent(i)=100*xtime/dur(i);%percent
    
%2nd movement (peak to valley)------

    %velocity of each segment of the signal %(use the min velocity because 
    %velocities in thise path have negative values)    
    [minvel,minvelind]=min(velocity(peakinsample(i):valleyinsample(i+1)));
    velo2(i)=minvel;% velocity  
    ampl2(i)= peak(i)-valley(i+1);%amplitude
    dur2(i)=(valleyinsample(i+1)-peakinsample(i))/rate; %duration
    stiff2(i)=abs(velo2(i))/ampl2(i);%stiffness
    cvalue2(i)=stiff2(i)*dur2(i);%cvalue
    xtime2=minvelind/rate; percent2(i)=100*xtime2/dur2(i);%percent    
             
end
    
%number of cicles of the signal
cycle=length(ampl);
val2000=num2str(cycle);      