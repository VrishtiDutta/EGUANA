function [velocity, ampl, velo1,dur, stiffness, cvalue, xtime, percent,...
 ampl2, velo2 ,dur2, stiff2, cvalue2, xtime2, percent2, val000,val2000,...
 allind10_90,velocity10_90]=...
 stiffness_90_10_rh(signal,rate,peaknumber,valleynumber,peakinsample,...
 valleyinsample, peak, valley)
 % This program is to calculate stiffness and other parameters using the 
 % part of the segment between 90 t0 10 percent of amplitude
 
 % Date: 21/07/10, by Rafael H 
 %-------------------------------------------------------------------------
  
 %velocity of all signal
 [velocity]=afgeleid(signal,rate);
  
 %variable inicialization
 if (peakinsample(1)>valleyinsample(1))
 c=valleynumber-1;
 else
 c=peaknumber-1;
 end
 
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
 indvalue10_1=zeros(1,c);
 indvalue90_1=zeros(1,c);
 indvalue10_2=zeros(1,c);
 indvalue90_2=zeros(1,c);
 
if (peakinsample(1)>valleyinsample(1))
%The valley appears earlier than peak does.

    for i=1:c
     
  %1st movement (velley to peak)-----  
  
    totalampl= peak(i)-valley(i); % total amplitude
    ampl(i)=0.80*totalampl;% 10 -90 amplitude
    
    pervalue10=valley(i)+0.10*totalampl;
    pervalue90=peak(i)-0.10*totalampl;
    
    indvalue10_1(i)=find(signal(valleyinsample(i):peakinsample(i)) > pervalue10,1, 'first')+valleyinsample(i);
    indvalue90_1(i)=find(signal(valleyinsample(i):peakinsample(i)) < pervalue90,1, 'last')+valleyinsample(i);
    
    
    %velocity of each segment of the signal  (use the max velocity) 
    [maxvel,maxvelind]=max(velocity(indvalue10_1(i):indvalue90_1(i)));
    velo1(i)=maxvel;% 10 - 90 velocity  
    
    dur(i)=(indvalue90_1(i)-indvalue10_1(i))/rate;% 10 - 90 duration
    stiffness(i)=velo1(i)/ampl(i);% 10 - 90 stiffness
    cvalue(i)=stiffness(i)*dur(i);% 10 - 90 cvalue
    xtime=maxvelind/rate; percent(i)=100*xtime/dur(i);% 90 - 10 percent
    
  %2nd movement (peak to valley)------
  
    totalampl= peak(i)-valley(i+1); % total amplitude
    ampl2(i)=0.80*totalampl;% 90 -10 amplitude
    
    pervalue10=valley(i+1)+0.10*totalampl;
    pervalue90=peak(i)-0.10*totalampl;
    
    indvalue90_2(i)=find(signal(peakinsample(i):valleyinsample(i+1)) < pervalue90,1, 'first')+peakinsample(i);
    indvalue10_2(i)=find(signal(peakinsample(i):valleyinsample(i+1)) > pervalue10,1, 'last')+peakinsample(i);
    
    
    %velocity of each segment of the signal %(use the min velocity because 
    %velocities in thise path have negative values) 
    [minvel,minvelind]=min(velocity(indvalue90_2(i):indvalue10_2(i)));
    velo2(i)=minvel;% 90 - 10 velocity  
    
    dur2(i)=(indvalue10_2(i)-indvalue90_2(i))/rate;% 90 - 10 duration
    stiff2(i)=abs(velo2(i))/ampl2(i);% 90 - 10 stiffness
    cvalue2(i)=stiff2(i)*dur2(i);% 90 - 10 cvalue
    xtime2=minvelind/rate; percent2(i)=100*xtime2/dur2(i);% 90 - 10 percent
         
    end
    
else
%The peak appears earlier than valley does.
       
    for i=1:c
        
%1st movement (peak to valley)-----        
        
    totalampl= peak(i)-valley(i); % total amplitude
    ampl(i)=0.80*totalampl;% 90 -10 amplitude
    
    pervalue10=valley(i)+0.10*totalampl;
    pervalue90=peak(i)-0.10*totalampl;
    
    indvalue90_1(i)=find(signal(peakinsample(i):valleyinsample(i)) < pervalue90, 1,'first')+peakinsample(i);
    indvalue10_1(i)=find(signal(peakinsample(i):valleyinsample(i)) > pervalue10, 1,'last')+peakinsample(i);
    
    %velocity of each segment of the signal %(use the min velocity because 
    %velocities in thise path have negative values) 
    [minvel,minvelind]=min(velocity(indvalue90_1(i):indvalue10_1(i)));
    velo1(i)=minvel;% 90 - 10 velocity  
    
    dur(i)=(indvalue10_1(i)-indvalue90_1(i))/rate;% 90 - 10 duration
    stiffness(i)=abs(velo1(i))/ampl(i);% 90 - 10 stiffness
    cvalue(i)=stiffness(i)*dur(i);% 90 - 10 cvalue
    xtime=minvelind/rate; percent(i)=100*xtime/dur(i);% 90 - 10 percent
    
    
%2st movement (valley to peak)

    totalampl= peak(i+1)-valley(i); % total amplitude
    ampl2(i)=0.80*totalampl;% 10 -90 amplitude
    
    pervalue10=valley(i)+0.10*totalampl;
    pervalue90=peak(i+1)-0.10*totalampl;
    
    indvalue10_2(i)=find(signal(valleyinsample(i):peakinsample(i+1)) > pervalue10,1, 'first')+valleyinsample(i);
    indvalue90_2(i)=find(signal(valleyinsample(i):peakinsample(i+1)) < pervalue90,1, 'last')+valleyinsample(i);
    
    
    %velocity of each segment of the signal  (use the max velocity) 
    [maxvel,maxvelind]=max(velocity(indvalue10_2(i):indvalue90_2(i)));
    velo2(i)=maxvel;% 10 - 90 velocity  
    
    dur2(i)=(indvalue90_2(i)-indvalue10_2(i))/rate;% 10 - 90 duration
    stiff2(i)=velo2(i)/ampl2(i);% 10 - 90 stiffness
    cvalue2(i)=stiff2(i)*dur2(i);% 10 - 90 cvalue
    xtime2=maxvelind/rate; percent2(i)=100*xtime2/dur2(i);% 90 - 10 percent
			 
    end        
end

%number of cicles of the signal
val2000=num2str(c); 


%Calculates the RMS value. First select 90-10 velocity amplitude then 
%square 90-10 velocity values, then take their mean, then take square 
%of mean
ind1090=sort([indvalue10_1,indvalue90_1,indvalue10_2,indvalue90_2]);

allind10_90=[];

for i=1:2:4*c
    indseg=ind1090(i):ind1090(i+1);
    allind10_90=[allind10_90, indseg];
end

velocity10_90=velocity(allind10_90);

rmsvalue=power((mean(power(velocity10_90,2))),0.5);
val000=num2str(rmsvalue);   

% figure
% subplot(2,1,1),
% plot(signal)
% line(allind10_90,signal(allind10_90),'LineStyle','none','Color','r','Marker','.')
% subplot(2,1,2),plot(velocity)
% line(allind10_90,velocity10_90,'LineStyle','none','Color','r','Marker','.')

end