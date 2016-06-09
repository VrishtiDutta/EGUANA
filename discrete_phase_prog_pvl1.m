function discrete_phase_prog_pvl1(signal1,signal2,signal3,signal4,signal5,signal6,signal7,signal8,name1,name2,name3,name4,name5,name6,name7); 
% script file discrete_phase_prog_pvl1

% This script provides automated discrete phase analysis (with option to
% correct segmentation of reference signal), displaying both speech and
% kinematic signals and with the option to play audio for each segmented
% part
% Signal1 = first signal x; signal2 = first signal y; signal3 = second
% signal x; signal4 = second signal y; signal5 = third signal x; signal6 =
% third signal y; signal7 = segmentation signal; signal8 = acoustic signal
% Version: 1.0; Date:23/2/2011 (PvL)
clear fid* len* time* zero* sti* kinsig* kinseg* diff* vectorsig Pp1n Pp2n Ff1 Ff2 Cxy F minPp* maxPp* minCxy maxCxy winsize winover in* end* rel* mean* sd* lo* fre* x1cur y1cur x2cur y2cur iirel intrus* reduc*;

machineType = input('Press 1 for AG500 and 2 for AG501: ','s');

if str2num(machineType) == 1
    sprate = 16000; %not sure
    kinRate = 200; %not sure
else
    sprate = 48000;
    kinRate = 250;
end

tempeax1=(1:length(signal8))/sprate;

R2=input('3D or 2D data? Answer 3 or 2: ','s');
R3=str2num(R2);

if R2==2
    tempeax2=(1:length(signal7))/400;
else
    tempeax2=(1:length(signal7))/kinRate;
end
tempav1=mean(abs(signal8));
tempav2=mean(abs(signal7));
tempav3=tempav1/tempav2;
tempsignal1=tempav3*(signal7);
tempsignal2=tempav3*(signal2);
tempsignal3=tempav3*(signal4);
figure(400);
plot(tempeax1,signal8,'y',tempeax2,tempsignal1,'r',tempeax2,tempsignal2,'g--',tempeax2,tempsignal3,'b--');
xlabel('yellow = acoustic signal; red solid = segmentation signal; green dotted = first signal; black dotted = second signal');
R = input('Type CONTINUE to continue','s');

defaults = {'0.1','1.5','0','0','200','c:\temp\'};
p={'Enter the relative criterion (e.g. 0.1):',...
    'Enter the time-interval (e.g. 1.5):',...
    'Enter the start time (in sec), otherwise 0:'...
    'Enter the end time (in sec), otherwise 0:',...
    'Enter the rate of the movement signals:',...
    'Enter the path for the output file:'};

      t='Signal crossvector';
      n=1;
      r=inputdlg(p,t,1,defaults);
      if ~isempty(r)

         rc=eval(r{1})
         rc_int=eval(r{2})
         starttem1=eval(r{3})
         stoptem1=eval(r{4})
         rate = eval(r{5});
         phiname=r{6};
      end
      phiname1=strcat(phiname,'multisegment_data_auto.dat');
      %fd = fopen('C:\pvl_defaults_mavismultisegment_auto.ini', 'w');
      %  for i = 1:13
      %      fprintf(fd,'%s\n',r{i});
      %  end
      %fclose(fd);

      p1={'Enter subject code:',...
          'Enter trial number:',...
          'Enter stimulus:',...
          'Enter condition (e.g., fast rate):'};
      t1='Analysis parameters';

%clear len* time* zero* sig* sti* kinsig* kinseg* diff* vectorsig Pp1n Pp2n Ff1 Ff2 Cxy F minPp* maxPp* minCxy maxCxy winsize winover rate in* end* rel* mean* sd* lo* fre* x1cur y1cur x2cur y2cur iirel;

%fd = fopen('C:\pvl_defaults_mavismultisegment_auto.ini', 'r');
%if fd~=-1
%   for i = 1:13
%       defaults{i} = fscanf(fd,'%s', [1]);
%   end
%   fclose(fd);
%else
 %  defaults = {'','','','','','','','','','','','',''};
%end


% p={'Enter the name of x-trajectory of 1st signal',...
%    'Enter the name of y-trajectory of 1st signal',...
%    'Enter the name of x-trajectory of 2nd signal',...
%    'Enter the name of y-trajectory of 2nd signal',...
%    'Enter the name of x-trajectory of 3rd signal (typically related to coda)',...
%    'Enter the name of y-trajectory of 3rd signal (typically related to coda)',...
%    'Enter the name of y trajectory for the reference signal (e.g., jaw)',...
%     'Enter the name of the speech signal (ac)',...
%    'Enter the relative criterion (e.g. 0.1):',...
%     'Enter the time-interval (e.g. 0.05):',...
%     'Enter the start time (in sec), otherwise 0:'...
%     'Enter the end time (in sec), otherwise 0:',...
%     'Enter the rate of the movement signals:'};
% 
%       t='Signal crossvector';
%       n=1;
%       r=inputdlg(p,t,1,defaults);
%       if ~isempty(r)
%          signal1=eval(r{1});
%          signal2=eval(r{2});
%          signal3=eval(r{3});
%          signal4=eval(r{4});
%          signal5=eval(r{5});
%          signal6=eval(r{6});
%          signal7=eval(r{7});
%          signal8=eval(r{8});
%          name1=r{1};
%          name2=r{2};
%          name3=r{3};
%          name4=r{4};
%          name5=r{5};
%          name6=r{6};
%          name7=r{7};
%          rc=eval(r{9})
%          rc_int=eval(r{10})
%          starttem1=eval(r{11})
%          stoptem1=eval(r{12})
%          rate = eval(r{13});
%       end
%       fd = fopen('C:\pvl_defaults_mavismultisegment_auto.ini', 'w');
%         for i = 1:13
%             fprintf(fd,'%s\n',r{i});
%         end
%       fclose(fd);
% 
%       p1={'Enter subject code:',...
%           'Enter trial number:',...
%           'Enter stimulus:',...
%           'Enter condition (e.g., fast rate):'};
%       t1='Analysis parameters';

      r1=inputdlg(p1,t1,1);
      if ~isempty(r1)
         subj=r1{1};
         trial=r1{2};
         stim=r1{3};
         stimnum=r1{4};
      end
      %sprate=16000; %speech sampling rate, change here if different from default 16000 Hz
      
      %Check if signals are equal size, if not, cut off parts from acoustic
      %signal
      temp11=length(signal8)/sprate;
      temp21=length(signal7)/rate;
      if temp11~=temp21
          difftemp1=temp11-temp21;
          %difftemp2=difftemp1*16000;
          temp31=length(signal8);
          temp41=fix(difftemp1*sprate);
          temp51=(temp31-temp41)+1;
          signal8(temp51:temp31)=[];
      else
          warndlg('Speech & Kinematic signals equal');
      end
          

      signal1=filter_array(signal1,rate,6,0.5);
      signal2=filter_array(signal2,rate,6,0.5);
      signal3=filter_array(signal3,rate,6,0.5);
      signal4=filter_array(signal4,rate,6,0.5);
      signal5=filter_array(signal5,rate,6,0.5);
      signal6=filter_array(signal6,rate,6,0.5);
      signal7=filter_array(signal7,rate,6,0.5);
      %signal8=filter_array(signal8,16000,5000,50);
     
      lengthsig1=length(signal7);
      lengthsigsp=length(signal8);
      if (starttem1~=0 & stoptem1~=0)
         endpoint1=lengthsig1;
         startpoint1=fix(starttem1*rate)-1;
         stoppoint1=fix(stoptem1*rate)+1;
         endpointsp=lengthsigsp;
         startpointsp=fix(starttem1*sprate)-1;
         stoppointsp=fix(stoptem1*sprate)+1;
         signal1(stoppoint1:endpoint1)=[];
         signal2(stoppoint1:endpoint1)=[];
         signal1(1:startpoint1)=[];
         signal2(1:startpoint1)=[];
         signal3(stoppoint1:endpoint1)=[];
         signal4(stoppoint1:endpoint1)=[];
         signal3(1:startpoint1)=[];
         signal4(1:startpoint1)=[];
         signal5(stoppoint1:endpoint1)=[];
         signal6(stoppoint1:endpoint1)=[];
         signal5(1:startpoint1)=[];
         signal6(1:startpoint1)=[];
         signal7(stoppoint1:endpoint1)=[];
         signal7(1:startpoint1)=[];
         signal8(stoppointsp:endpointsp)=[];
         signal8(1:startpointsp)=[];
   	  else
         signal1=signal1;
         signal2=signal2;
         signal3=signal3;
         signal4=signal4;
         signal5=signal5;
         signal6=signal6;
         signal7=signal7;
         signal8=signal8;
      end
timetemp1=(1:length(signal7))/rate;
timetempsp=(1:length(signal8))/sprate;

%Amplitude normalization
%signal1norm=(signal1-(mean(signal1)))/std(signal1);
%signal2norm=(signal2-(mean(signal2)))/std(signal2);
%signal3norm=(signal3-(mean(signal3)))/std(signal3);
%signal4norm=(signal4-(mean(signal4)))/std(signal4);
%signal5norm=(signal5-(mean(signal5)))/std(signal5);
%signal6norm=(signal6-(mean(signal6)))/std(signal6);
%signal7norm=(signal7-(mean(signal7)))/std(signal7);
signal1new=signal1+abs(min(signal1));
signal2new=signal2+abs(min(signal2));
signal3new=signal3+abs(min(signal3));
signal4new=signal4+abs(min(signal4));
signal5new=signal5+abs(min(signal5));
signal6new=signal6+abs(min(signal6));
signal7new=signal7+abs(min(signal7));
%Determine range for normalization
signal1range=(max(signal1new)-min(signal1new));
signal2range=(max(signal2new)-min(signal2new));
signal3range=(max(signal3new)-min(signal3new));
signal4range=(max(signal4new)-min(signal4new));
signal5range=(max(signal5new)-min(signal5new));
signal6range=(max(signal6new)-min(signal6new));
signal7range=(max(signal7new)-min(signal7new));
%Amplitude normalization
signal1norm=(signal1new/signal1range)*100;
signal2norm=(signal2new/signal2range)*100;
signal3norm=(signal3new/signal3range)*100;
signal4norm=(signal4new/signal4range)*100;
signal5norm=(signal5new/signal5range)*100;
signal6norm=(signal6new/signal6range)*100;
signal7norm=(signal7new/signal7range)*100;
% filter speech signal between 50 and 2500 Hz
fnorm=[2500/(sprate/2)];
[b,a]=butter(10,fnorm,'low');
signal8fin=filtfilt(b,a,signal8);
pvltemp=length(signal8fin)/sprate

    
% This section plots raw data, min & max, & normalized data for reference
% signal = signal7
tempsigmax=max(signal7new);
tempsigmin=min(signal7new);

figure(20);
subplot(3,1,1);
plot(timetemp1,signal7);
subplot(3,1,2);
plot(timetemp1,signal7new,'b',timetemp1,tempsigmax,'r',timetemp1,tempsigmin,'g');
subplot(3,1,3);
plot(timetemp1,signal7norm);

% Continue with normalized signals

dt=1/rate;
mnew=length(signal7norm);
t=(1:mnew)/rate;

Data=[signal7norm t'];
        
[peak,peaktime,valley,valleytime]=pickextr(Data,rc,rc_int,dt);
valleynumber=length(valleytime);
valleyindex=round(valleytime*rate);            
x1_pt=[valleyindex];y1_pt=[valley];
%PLOT segmentation SIGNAL and AUTO PEAKS; LET USER ADJUST
figure(9);
%maximize(gcf);
clf;
whitebg(9,'white');
CLR = 0;
%Plot speech signal together with reference signal marked by valleys    
%
timax1=(1:length(signal8fin))/sprate
timax2=(1:length(signal7norm))/rate
subplot(2,1,1);
plot(timax1,signal8fin,'b');
subplot(2,1,2);
plot(signal7norm,'b')
index=1;
while index<=valleynumber 
   line(valleyindex(index),valley(index),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
   index=index+1;
end
set(gcf,'DoubleBuffer','on');   
title(strcat('Original segmentation signal.. ', name7),'FontSize',8,'Color','black')
ylabel('Position');
% call function to delete and add the points
[new_x1_pt, new_y1_pt]=myrinput(x1_pt, y1_pt);
fig1_pts=[new_x1_pt, new_y1_pt];
% sort the points array and put the points into two arrays that are
% valleyindex and valley
[valleyindexn, valleyn]=sort(fig1_pts,1,'ascend')
%fig1_pv = [peakindex1, valleyindex1];
objects = findobj(gcf, 'Tag', 'Dot');
set(objects, 'HandleVisibility', 'Off');

%CONTINUE ANALYSIS WITH CORRECTED PEAKS and VALLEYS
%Update the peaknumber and valleynumber
valleynumber1=length(valleyn);
ii11=1;
numwav11=valleynumber1-1;
iii1=0;
%Valley based segmentation reference signal aka signal7
for i11=1:numwav11;
    if ((i11+ii11-1)<=numwav11)
        iii1=iii1+1;
        seg11(iii1).x1=valleyindexn(i11);
        seg11(iii1).x2=valleyindexn(i11+ii11);
    end
end
%Valley based segments for all signals as determined by approved marker
%positions in reference signal aka signal7

for t11=1:iii1; %cycles the number of times specified above
    p_start11=seg11(t11).x1; %x1 gives the starting point
    p_end11=seg11(t11).x2; %x2 gives the end point of the segment
    kinseg1=signal1norm(p_start11:p_end11); %cuts from the smoothed disp record
    kinseg2=signal2norm(p_start11:p_end11);
    kinseg3=signal3norm(p_start11:p_end11);
    kinseg4=signal4norm(p_start11:p_end11);
    kinseg5=signal5norm(p_start11:p_end11);
    kinseg6=signal6norm(p_start11:p_end11);
    % Segment speech signal as well based on assumption that sr = 16000 Hz
    % for speech
    if rate==400
        startpointspseg=p_start11*40;
        stoppointspseg=p_end11*40;
    else
        startpointspseg=p_start11*(sprate/rate);
        stoppointspseg=p_end11*(sprate/rate);
    end
    spsegment=signal8fin(startpointspseg:stoppointspseg);
    
    %
    raw1(t11)={kinseg1}; %puts the record into a cell array
    raw2(t11)={kinseg2};
    raw3(t11)={kinseg3};
    raw4(t11)={kinseg4};
    raw5(t11)={kinseg5};
    raw6(t11)={kinseg6};
    spseg(t11)={spsegment};
   % Figure to check correct alignment of markers in reference signal
   %timeax11=(1:length(signal8fin))/sprate;
   %timeax21=(1:length(signal7norm))/rate;
   markertxt1= strcat(' ',num2str(t11+40)); 
%   upperlim=3*(round(max(signal8fin)));
%   lowerlim=-3*(round(min(signal8fin)));
   upperlim=max(signal8fin);
   lowerlim=min(signal8fin);
   %linestartsp=round(stoppointspseg/ratespms);
   %linestartkin= round(p_start11/ratems);
   %linestopkin=round(p_end11/ratems);
   figure(100);
    subplot(2,1,1);
    xlim([0 length(signal8fin)]);
    plot(signal8fin,'b');
    line([stoppointspseg stoppointspseg],[lowerlim upperlim],'color','r');
    text(stoppointspseg,upperlim,markertxt1,'Fontsize',7,'color','red');
    hold on
    subplot(2,1,2);
    xlim([0 length(signal7norm)]);
    markertxt2= strcat(' ',num2str(t11+40));
    plot(signal7norm,'k');
    line(p_start11,signal7norm(p_start11),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
    line(p_end11,signal7norm(p_end11),...
      'Color','g', 'Marker', 'x', 'Tag', 'Dot','LineStyle','none')
    line([p_end11 p_end11],[5 95],'color','r');
    text(p_end11,96,markertxt2,'FontSize',7,'color','red');
    hold on
end
% Plot normalized trajectors for 3 signals + reference in vertical
% dimension (y in 2D or z in 3D)
figure(200);
temptimeax=(1:length(signal1norm))/rate;
subplot(4,1,1);
plot(temptimeax,signal2norm);
subplot(4,1,2);
plot(temptimeax,signal4norm);
subplot(4,1,3);
plot(temptimeax,signal6norm);
subplot(4,1,4);
plot(temptimeax,signal7norm);
xlabel('1st panel = 1st y/z; 2nd panel = 2nd y/z; 3rd panel = 3rd y/z; 4th panel = reference');
% Do it combined too
figure(201);
plot(temptimeax,signal1norm,'b',temptimeax,signal4norm,'r',temptimeax,signal6norm,'g',temptimeax,signal7norm,'ko');
xlabel('blue = 1st y/z; red = 2nd y/z; green = 3rd y/z; black circle = reference');
% 
% Now process individual cycles for deriving measures and store these
for s11=1:iii1;      
     tempseg1=raw1{s11};
     tempseg2=raw2{s11};
     tempseg3=raw3{s11};
     tempseg4=raw4{s11};
     tempseg5=raw5{s11};
     tempseg6=raw6{s11};
     tempspsig=spseg{s11};
     sizetemp1=length(tempseg1);
     sizetemp2=length(tempspsig);
    lengthseg=length(tempseg1);
     refdur=(lengthseg/rate)*1000;
     lengthsegb=lengthseg-20;
     [max1,maxindex1]=max(tempseg1);
     [min1,minindex1]=min(tempseg1);
     maxindtime1=maxindex1/rate;
     minindtime1=minindex1/rate;
     [max2,maxindex2]=max(tempseg2);
     [min2,minindex2]=min(tempseg2);
     maxindtime2=maxindex2/rate;
     minindtime2=minindex2/rate;
     [max3,maxindex3]=max(tempseg3);
     [min3,minindex3]=min(tempseg3);
     maxindtime3=maxindex3/rate;
     minindtime3=minindex3/rate;
     [max4,maxindex4]=max(tempseg4);
     [min4,minindex4]=min(tempseg4);
     maxindtime4=maxindex4/rate;
     minindtime4=minindex4/rate;
     [max5,maxindex5]=max(tempseg5);
     [min5,minindex5]=min(tempseg5);
     maxindtime5=maxindex5/rate;
     minindtime5=minindex5/rate;
     [max6,maxindex6]=max(tempseg6);
     [min6,minindex6]=min(tempseg6);
     maxindtime6=maxindex6/rate;
     minindtime6=minindex6/rate;
     figure(s11+40);
     
     timeax1=(1:sizetemp1)/rate;
     timeax2=(1:sizetemp2)/sprate;
     % plot individual segments
     subplot(3,1,1);
     plot(timeax2,tempspsig);
     subplot(3,1,2);
     plot(timeax1,tempseg1,'b',maxindtime1,max1,'bx',minindtime1,min1,'bo',timeax1,tempseg3,'r',maxindtime3,max3,'rx',minindtime3,min3,'ro',timeax1,tempseg5,'g',maxindtime5,max5,'gx',minindtime5,min5,'go');
     xlabel('blue = 1st x; red = 2nd x; green = 3rd x');
     ylim([0 100]);
     subplot(3,1,3);
     plot(timeax1,tempseg2,'b',maxindtime2,max2,'bx',minindtime2,min2,'bo',timeax1,tempseg4,'r',maxindtime4,max4,'rx',minindtime4,min4,'ro',  timeax1,tempseg6,'g',maxindtime6,max6,'gx',minindtime6,min6,'go');
     xlabel('blue = 1st y/z; red = 2nd y/z; green = 3rd y/z');
     ylim([0 100]);
     %measures for segment 1
     
     onset1=tempseg1(1);
     temp1=length(tempseg1);
     offset1=tempseg1(temp1);
     if(onset1 < max1 && offset1 < max1)
         peak1=max1;
         peak1ind=maxindtime1;
     else
         peak1=min1;
         peak1ind=minindtime1;
     end
     temp1=temp1/rate;
     offsetdif1=(temp1-peak1ind);
%measures for segment 2
    
     onset2=tempseg2(1);
     temp2=length(tempseg2);
     offset2=tempseg2(temp2);
     if(onset2 < max2 && offset2 < max2)
         peak2=max2;
         peak2ind=maxindtime2;
     else
         peak2=min2;
         peak2ind=minindtime2;
     end
     temp2=temp2/rate;
     offsetdif2=(temp2-peak2ind);
%measures for segment 3
     
     onset3=tempseg3(1);
     temp3=length(tempseg3);
     offset3=tempseg3(temp3);
     if(onset3 < max3 && offset3 < max3)
         peak3=max3;
         peak3ind=maxindtime3;
     else
         peak3=min3;
         peak3ind=minindtime3;
     end
     temp3=temp3/rate;
     offsetdif3=(temp3-peak3ind);
%measures for segment 4
     
     onset4=tempseg4(1);
     temp4=length(tempseg4);
     offset4=tempseg4(temp4);
     if(onset4 < max4 && offset4 < max4)
         peak4=max4;
         peak4ind=maxindtime4;
     else
         peak4=min4;
         peak4ind=minindtime4;
     end
     temp4=temp4/rate;
     offsetdif4=(temp4-peak4ind);
%measures for segment 5
     
     onset5=tempseg5(1);
     temp5=length(tempseg5);
     offset5=tempseg5(temp5);
     if(onset5 < max5 && offset5 < max5)
         peak5=max5;
         peak5ind=maxindtime5;
     else
         peak5=min5;
         peak5ind=minindtime5;
     end
     temp5=temp5/rate;
     offsetdif5=(temp5-peak5ind);
%measures for segment 6

     onset6=tempseg6(1);
     temp6=length(tempseg6);
     offset6=tempseg6(temp6);
     if(onset6 < max6 && offset6 < max6)
         peak6=max6;
         peak6ind=maxindtime6;
     else
         peak6=min6;
         peak6ind=minindtime6;
     end
     temp6=temp6/rate;
     offsetdif6=(temp6-peak6ind);
     
     %Determine time lags between peaks x signals
     diffpeak13=(peak1ind-peak3ind);
     diffpeak35=(peak3ind-peak5ind);
     diffpeak15=(peak1ind-peak5ind);
     
     %Determine time lags between peaks y signals
     diffpeak24=(peak2ind-peak4ind);
     diffpeak46=(peak4ind-peak6ind);
     diffpeak26=(peak2ind-peak6ind);
     
    
     % write values for copy & paste in msec units
     
     offsetdif1=offsetdif1*1000;
     peak1ind=peak1ind*1000;
     diffpeak13=diffpeak13*1000;
     maxindtime1=maxindtime1*1000;
     minindtime1=minindtime1*1000;
     
     offsetdif2=offsetdif2*1000;
     peak2ind=peak2ind*1000;
     diffpeak35=diffpeak35*1000;
     maxindtime2=maxindtime2*1000;
     minindtime2=minindtime2*1000;
     
     
     offsetdif3=offsetdif3*1000;
     peak3ind=peak3ind*1000;
     diffpeak15=diffpeak15*1000;
     maxindtime3=maxindtime3*1000;
     minindtime3=minindtime3*1000;
     
     
     offsetdif4=offsetdif4*1000;
     peak4ind=peak4ind*1000;
     diffpeak24=diffpeak24*1000;
     maxindtime4=maxindtime4*1000;
     minindtime4=minindtime4*1000;
     
     
     offsetdif5=offsetdif5*1000;
     peak5ind=peak5ind*1000;
     diffpeak46=diffpeak46*1000;
     maxindtime5=maxindtime5*1000;
     minindtime5=minindtime5*1000;
     
     
     offsetdif6=offsetdif6*1000;
     peak6ind=peak6ind*1000;
     diffpeak26=diffpeak26*1000;
     maxindtime6=maxindtime6*1000;
     minindtime6=minindtime6*1000;
     
     % determine corresponding values for 2 other y-signals at each of the
     % peaks of signal 2, 4 and 6 (y)
     ampsig21=max2;
     ampsig22=tempseg4(maxindex2);
     ampsig23=tempseg6(maxindex2);
     
     ampsig41=max4;
     ampsig42=tempseg2(maxindex4);
     ampsig43=tempseg6(maxindex4);
     
     ampsig61=max6;
     ampsig62=tempseg2(maxindex6);
     ampsig63=tempseg4(maxindex6);
     
     ampsig21t=strcat(name2);
     ampsig22t=strcat(name2,'_',name4);
     ampsig23t=strcat(name2,'_',name6);
     ampsig41t=strcat(name4);
     ampsig42t=strcat(name4,'_',name2);
     ampsig43t=strcat(name4,'_',name6);
     ampsig61t=strcat(name6);
     ampsig62t=strcat(name6,'_',name2);
     ampsig63t=strcat(name6,'_',name4);
     % Discrete relative phase values
     phasesigx1=360*(maxindtime1/refdur);
     phasesigx2=360*(maxindtime3/refdur);
     phasesigx3=360*(maxindtime5/refdur);
     phasesigy1=360*(maxindtime2/refdur);
     phasesigy2=360*(maxindtime4/refdur);
     phasesigy3=360*(maxindtime6/refdur);
     phasesigx1t='phasesigx1';
     phasesigx2t='phasesigx2';
     phasesigx3t='phasesigx3';
     phasesigy1t='phasesigy1';
     phasesigy2t='phasesigy2';
     phasesigy3t='phasesigy3';
     phasedify12=phasesigy1-phasesigy2;
     phasedify13=phasesigy1-phasesigy3;
     phasedify23=phasesigy2-phasesigy3;
     phasedify12t='phasedify12';
     phasedify13t='phasedify13';
     phasedify23t='phasedify23';
     itemcodt=num2str(s11);
     %phiname='d:\results\multisegment_data_auto.dat';
     fid20=fopen(phiname1,'a');
     %fprintf(fid20,'%s %s %s %s\n',subj,trial,stim,stimnum);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f\n',subj,trial,stim,stimnum,itemcodt,'Range_sig1x_1y_2x_2y_3x_3y_refy',signal1range,signal2range,signal3range,signal4range,signal5range,signal6range,signal7range);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name1,itemcodt,offsetdif1,peak1ind,onset1,offset1,peak1,max1,maxindtime1,min1,minindtime1,'1st_2nd_x',diffpeak13);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name3,itemcodt,offsetdif3,peak3ind,onset3,offset3,peak3,max3,maxindtime3,min3,minindtime3,'2nd_3rd_x',diffpeak35);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name5,itemcodt,offsetdif5,peak5ind,onset5,offset5,peak5,max5,maxindtime5,min5,minindtime5,'1st_3rd_x',diffpeak15);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name2,itemcodt,offsetdif2,peak2ind,onset2,offset2,peak2,max2,maxindtime2,min2,minindtime2,'1st_2nd_y',diffpeak24,ampsig21t,ampsig21,ampsig22t,ampsig22,ampsig23t,ampsig23,phasesigy1t,phasesigy1,phasedify12t,phasedify12);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name4,itemcodt,offsetdif4,peak4ind,onset4,offset4,peak4,max4,maxindtime4,min4,minindtime4,'2nd_3rd_y',diffpeak46,ampsig41t,ampsig41,ampsig42t,ampsig42,ampsig43t,ampsig43,phasesigy2t,phasesigy2,phasedify13t,phasedify13);
     fprintf(fid20,'%s %s %s %s %s %s %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f %s %8.4f\n',subj,trial,stim,stimnum,name6,itemcodt,offsetdif6,peak6ind,onset6,offset6,peak6,max6,maxindtime6,min6,minindtime6,'1st_3rd_y',diffpeak26,ampsig61t,ampsig61,ampsig62t,ampsig62,ampsig63t,ampsig63,phasesigy3t,phasesigy3,phasedify23t,phasedify23);
     fclose(fid20);
%      figure(300);
%      plot(ampsig21,ampsig22);
%      xlabel('Max amplitude y-values signal 1');
%      ylabel('Amplitude y-values signal 2 at max signal 1');
%      hold on
%      figure(301);
%      plot(ampsig41,ampsig42);
%      xlabel('Max amplitude y-values signal 2');
%      ylabel('Amplitude y-values signal 1 at max signal 2');
%      hold on
     maxampsignal2(s11)=ampsig21; %maximum for y-amplitude first signal
     maxampsignal4(s11)=ampsig41; %maximum for y-amplitude second signal (assuming third signal is always coda signal)     
     ampsignal4at2(s11)=ampsig22; %y-amplitude second signal at max first signal
     ampsignal2at4(s11)=ampsig42; %y-amplitude first signal at max second signal     
     indexparameter(s11)=s11+40;
end
% Calculate correlations between first and second and across positions in a
% word on the assumption that segments are based on coda consonants so each
% segment relates to one word specfic consonant onset
warndlg('See command line for input requirement!');
R = input('Correlations, Yes = 1 or No = 0 =>  ');
if R == 1;
    s121=1;
    for s12=1:2:s11
        maxampyfirstsignalword1(s121)=maxampsignal2(s12);
        maxampysecondsignalword1(s121)=maxampsignal4(s12);
        ampysecondsignalatmaxfirstword1(s121)=ampsignal4at2(s12);
        ampyfirstsignalatmaxsecondword1(s121)=ampsignal2at4(s12);
        s121=s121+1;
    end
%
    s122=1;
    for s13=2:2:s11
        maxampyfirstsignalword2(s122)=maxampsignal2(s13);
        maxampysecondsignalword2(s122)=maxampsignal4(s13);
        ampysecondsignalatmaxfirstword2(s122)=ampsignal4at2(s13);
        ampyfirstsignalatmaxsecondword2(s122)=ampsignal2at4(s13);
        s122=s122+1;
    end
    s123=s121-1;
    s124=s122-1;
% put proper values in matrix
    maxamp1vsmaxamp2word1=[maxampyfirstsignalword1' maxampysecondsignalword1']
    maxamp1vsamp2word1=[maxampyfirstsignalword1' ampysecondsignalatmaxfirstword1'];
    maxamp2vsamp1word1=[maxampysecondsignalword1' ampyfirstsignalatmaxsecondword1'];
%
    maxamp1vsmaxamp2word2=[maxampyfirstsignalword2' maxampysecondsignalword2'];
    maxamp1vsamp2word2=[maxampyfirstsignalword2' ampysecondsignalatmaxfirstword2'];
    maxamp2vsamp1word2=[maxampysecondsignalword2' ampyfirstsignalatmaxsecondword2'];
%
    if s123==s124
        s125=s123
    else
        s125=(min(s123,s124));
    end
    for s16=1:s125
        maxampyfirstsignalword11(s16)= maxampyfirstsignalword1(s16); 
        maxampyfirstsignalword21(s16)= maxampyfirstsignalword2(s16);
        maxampysecondsignalword11(s16)=maxampysecondsignalword1(s16); 
        maxampysecondsignalword21(s16)=maxampysecondsignalword2(s16);
    end
    maxamp1word1vsmaxamp1word2=[maxampyfirstsignalword11' maxampyfirstsignalword21'];
    maxamp2word1vsmaxamp2word2=[maxampysecondsignalword11' maxampysecondsignalword21'];
%
% Now calculate correlations
%
    [r1,p1]=corrcoef(maxamp1vsmaxamp2word1) % max amp 1st signal vs max amp 2nd signal word 1
    [r2,p2]=corrcoef(maxamp1vsamp2word1) % max amp 1st signal vs amp 2nd signal at same time word 1
    [r3,p3]=corrcoef(maxamp2vsamp1word1) % max amp 2nd signal vs amp 1st signal at same time word 1
    [r4,p4]=corrcoef(maxamp1vsmaxamp2word2) %max amp 1st signal vs max amp 2nd signal word 2
    [r5,p5]=corrcoef(maxamp1vsamp2word2)% max amp 1st signal vs amp 2nd signal at same time word 2
    [r6,p6]=corrcoef(maxamp2vsamp1word2)% max amp 2nd signal vs amp 1st signal at same time word 2
    [r7,p7]=corrcoef(maxamp1word1vsmaxamp1word2)% max amp 1st signal in word 1 vs max amp 1st signal word 2
    [r8,p8]=corrcoef(maxamp2word1vsmaxamp2word2)% max amp 2nd signal in word 1 vs max amp 2nd signal word 2
%
% Extract correlation and p-values
%
    r1n=r1(2)
    p1n=p1(2)
    r2n=r2(2)
    p2n=p2(2)
    r3n=r3(2)
    p3n=p3(2)
    r4n=r4(2)
    p4n=p4(2)
    r5n=r5(2)
    p5n=p5(2)
    r6n=r6(2)
    p6n=p6(2)
    r7n=r7(2)
    p7n=p7(2)
    r8n=r8(2)
    p8n=p8(2)
%
%write to file
%
    %phiname2='d:\results\multisegment_data_auto.dat';
    fid25=fopen(phiname1,'a');
    fprintf(fid25,'%s %8.4f %s %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %s %8.4f %8.4f %s %8.4f %8.4f\n','N-observations',s125,'Correlations_wrd1_max1vsmax2_amp2atmax1_amp1atmax2',r1n,r2n,r3n,'P-values',p1n,p2n,p3n,'Correlations_wrd2_max1vsmax2_amp2atmax1_amp1atmax2',r4n,r5n,r6n,'P-values',p4n,p5n,p6n,'Correlations_across_words_max1wrd1vsmax1wrd2_max2wrd1vsmax2wrd2',r7n,r8n,'P-values',p7n,p8n);
    fclose(fid25);
%fid25=fopen(phiname,'a');
%
else
    warndlg('No correlations have been calculated');
end
indexparameterstr=num2str(indexparameter);
maxindext=max(indexparameter);
minindext=min(indexparameter);
figure(300);
meanfirst=mean(maxampsignal2)
sdfirst=std(maxampsignal2)
meansecond=mean(maxampsignal4)
sdsecond=std(maxampsignal4)
medianfirst=median(maxampsignal2)
temp1=abs(maxampsignal2-medianfirst);
temp2=median(temp1);
madfirst=median(temp2);
mediansecond=median(maxampsignal4)
temp11=abs(maxampsignal4-mediansecond);
temp21=median(temp1);
meanthird=mean(ampsignal4at2)
meanfourth=mean(ampsignal2at4)
medianthird=median(ampsignal4at2)
medianfourth=median(ampsignal2at4)
%first plot comparing max first with amplitude 2nd at max 
plot(indexparameter,maxampsignal2,'-ok','markeredgecolor','k','markerfacecolor','b','markersize',10);hold on;
plot(indexparameter,maxampsignal4,'-ob','markeredgecolor','k','markerfacecolor','r','markersize',10);hold on;
plot(indexparameter,ampsignal4at2,'db','markeredgecolor','k','markerfacecolor','r','markersize',6);hold on;
plot(indexparameter,ampsignal2at4,'dk','markeredgecolor','k','markerfacecolor','b','markersize',6);hold on;
line([minindext maxindext],[meanfirst meanfirst],'color','b','linewidth',3);hold on;
line([minindext maxindext],[meansecond meansecond],'color','r','linewidth',3);hold on;
line([minindext maxindext],[meanthird meanthird],'color','r','linestyle','--','linewidth',2);hold on;
line([minindext maxindext],[meanfourth meanfourth],'color','b','linestyle','--','linewidth',2);
xlabel('Segment #');
ylabel('Normalized amplitude %');
legend('Max amp 1st','Max amp 2nd','Amp 2nd at max 1st','Amp 1st at max 2nd','Mean max amp 1st','Mean max amp 2nd','Mean amp 2nd at max 1st','Mean amp 1st at max 2nd','Location','NorthEastOutside');
maxindt=max(indexparameter);
axis([40 maxindt 0 100]);
% Second plot comparing ratio of amplitudes displayed in first plot
for xx1=1:s11;
ratiomaxamps2and4(xx1)=(maxampsignal2(xx1)/(maxampsignal2(xx1)+maxampsignal4(xx1)))*100;
ratiomaxamp2vsamp4at2(xx1)=(maxampsignal2(xx1)/(maxampsignal2(xx1)+ampsignal4at2(xx1)))*100;
ratiomaxamp4vsamp2at4(xx1)=(maxampsignal4(xx1)/(maxampsignal4(xx1)+ampsignal2at4(xx1)))*100;
ratioamps2and4atmaxs(xx1)=(ratiomaxamp2vsamp4at2(xx1)/(ratiomaxamp2vsamp4at2(xx1)+ratiomaxamp4vsamp2at4(xx1)))*100;
end
figure(301);
plot(indexparameter,ratiomaxamps2and4,'ok','markeredgecolor','k','markerfacecolor','green','markersize',10);hold on;
plot(indexparameter,ratiomaxamp2vsamp4at2,'^b','markeredgecolor','k','markerfacecolor','magenta','markersize',10);hold on;
plot(indexparameter,ratiomaxamp4vsamp2at4,'vb','markeredgecolor','k','markerfacecolor','yellow','markersize',10);hold on;
plot(indexparameter,ratioamps2and4atmaxs,'-xr','markeredgecolor','r','markerfacecolor','yellow','markersize',14);hold on;
xlabel('Segment #');
ylabel('Ratio amplitudes %');
legend('(1) Ratio max amp 1st vs 2nd','(2) Ratio max amp 1st vs. 2nd at max 1st','(3) Ratio max amp 2nd vs. 1st at max 2nd','(4) Ratio amps at max locations (2/3)','Location','NorthEastOutside');
axis([40 maxindt 0 100]);
grid on;
% Third plot to plot segments on top of each other
figure(302);
for btemp=1:s11
    markertxt3= strcat(' ',num2str(btemp+40));
    rawtimenorm1{btemp}=interpft(raw2{btemp}',1000);
    rawtimenorm2{btemp}=interpft(raw4{btemp}',1000);
    rawtimenorm3{btemp}=interpft(raw6{btemp}',1000);
    subplot(3,1,1);
    plot(rawtimenorm1{btemp});hold on;
    xlabel('Signal 1 time normalized segments');
    ylim([0 100]);
    xpos1=1000;
    ypos1=rawtimenorm1{btemp}(1000);
    %text(xpos1,ypos1,markertxt3,'FontSize',7,'color','blue');
    hold on
    subplot(3,1,2);
    plot(rawtimenorm2{btemp});hold on;
    xlabel('Signal 2 time normalized segments');
    ylim([0 100]);
    xpos2=1000;
    ypos2=rawtimenorm2{btemp}(1000);
    %text(xpos2,ypos2,markertxt3,'FontSize',7,'color','blue');
    subplot(3,1,3);
    plot(rawtimenorm3{btemp});hold on;
    xlabel('Signal 3 time normalized segments');
    ylim([0 100]);
    xpos3=1000;
    ypos3=rawtimenorm3{btemp}(1000);
    %text(xpos3,ypos3,markertxt3,'FontSize',7,'color','blue');
end
% Calculate mean and SD of segments
tempav1=0;
tempav2=0;
tempav3=0;
tempav11=0;
tempav22=0;
tempav33=0;
%MEAN
for ctemp=1:length(rawtimenorm1);
    tempav1=tempav1+rawtimenorm1{:,ctemp};
    tempav2=tempav2+rawtimenorm2{:,ctemp};
    tempav3=tempav3+rawtimenorm3{:,ctemp};
end
meanrawtimenorm1=tempav1/length(rawtimenorm1);
meanrawtimenorm2=tempav2/length(rawtimenorm1);
meanrawtimenorm3=tempav3/length(rawtimenorm1);
%SD
for ctemp1=1:length(rawtimenorm1);
    tempav11=tempav11+((rawtimenorm1{:,ctemp1}-meanrawtimenorm1).^2);
    tempav22=tempav22+((rawtimenorm2{:,ctemp1}-meanrawtimenorm2).^2);
    tempav33=tempav33+((rawtimenorm3{:,ctemp1}-meanrawtimenorm3).^2);
end
sdrawtimenorm1=sqrt(tempav11/length(rawtimenorm1));
sdrawtimenorm2=sqrt(tempav22/length(rawtimenorm1));
sdrawtimenorm3=sqrt(tempav33/length(rawtimenorm1));
%Now calculate mean+2*SD and mean-2*SD signals
sdhigh1=meanrawtimenorm1+(1*(sdrawtimenorm1));
sdlow1=meanrawtimenorm1-(1*(sdrawtimenorm1));
sdhigh2=meanrawtimenorm2+(1*(sdrawtimenorm2));
sdlow2=meanrawtimenorm2-(1*(sdrawtimenorm2));
sdhigh3=meanrawtimenorm3+(1*(sdrawtimenorm3));
sdlow3=meanrawtimenorm3-(1*(sdrawtimenorm3));

subplot(3,1,1);
plot(meanrawtimenorm1,'r','linewidth',3);hold on;
plot(sdlow1,'--r','linewidth',2);hold on;
plot(sdhigh1,':r','linewidth',2);hold on;
subplot(3,1,2);
plot(meanrawtimenorm2,'r','linewidth',3);hold on;
plot(sdlow2,'--r','linewidth',2);hold on;
plot(sdhigh2,':r','linewidth',2);hold on;
subplot(3,1,3);
plot(meanrawtimenorm3,'r','linewidth',3);hold on;
plot(sdlow3,'--r','linewidth',2);hold on;
plot(sdhigh3,':r','linewidth',2);hold on;
% scatter(maxampsignal2,ampsignal4at2,marker=indexparameterstr);
% xlabel('Mzx amplitude y-values first signal');
% ylabel('Ampltude y-values second signal at max first signal');
% %zlabel('Index parameter = segment');
% line([meanfirst meanfirst],[0 100],'color','red');
% line([0 100],[meanthird meanthird],'color','green');
% line([medianfirst medianfirst],[0 100],'color','red','LineStyle','--');
% line([0 100],[medianthird medianthird],'color','green','LineStyle','--');
% % new figure
% figure(301);
% %second scatter comparing max second with amplitude 1st at max second
% scatter(maxampsignal4,ampsignal2at4);
% xlabel('Max amplitude y-values second signal');
% ylabel('Ampltude y-values first signal at max second signal');
% %zlabel('Index parameter = segment');
% line([meansecond meansecond],[0 100],'color','red');
% line([0 100],[meanfourth meanfourth],'color','green');
% line([mediansecond mediansecond],[0 100],'color','red','LineStyle','--');
% line([0 100],[medianfourth medianfourth],'color','green','LineStyle','--');

% for tt11=1:s11;
%     xval=maxampsignal2(tt11);
%     yval=maxampsignal4(tt11);
%     sval=indexparameter(tt11);
%     text(xval,yval,sval,'Fontsize',7,'color','red');
%     hold on
% end
% ##### START CALCULATIONS FOR ERRORS (REDUCTIONS & INTRUSIONS)######
if R == 1;
    %CALCULATIONS MEANS/MEDIANS SD/MAD FOR FIRST WORD SIGNALS
    meanmaxampyfirstsignalword1=mean(maxampyfirstsignalword1);
    stdmaxampyfirstsignalword1=std(maxampyfirstsignalword1);
    medianmaxampyfirstsignalword1=median(maxampyfirstsignalword1);
    madmaxampyfirstsignalword1=median(abs(maxampyfirstsignalword1-medianmaxampyfirstsignalword1));
%
    meanmaxampysecondsignalword1=mean(maxampysecondsignalword1);
    stdmaxampysecondsignalword1=std(maxampysecondsignalword1);
    medianmaxampysecondsignalword1=median(maxampysecondsignalword1);
    madmaxampysecondsignalword1=median(abs(maxampysecondsignalword1-medianmaxampysecondsignalword1));
%
    meanampysecondsignalatmaxfirstword1=mean(ampysecondsignalatmaxfirstword1);
    stdampysecondsignalatmaxfirstword1=std(ampysecondsignalatmaxfirstword1);
    medianampysecondsignalatmaxfirstword1=median(ampysecondsignalatmaxfirstword1);
    madampysecondsignalatmaxfirstword1=median(abs(ampysecondsignalatmaxfirstword1-medianampysecondsignalatmaxfirstword1));
%
    meanampyfirstsignalatmaxsecondword1=mean(ampyfirstsignalatmaxsecondword1);
    stdampyfirstsignalatmaxsecondword1=std(ampyfirstsignalatmaxsecondword1);
    medianampyfirstsignalatmaxsecondword1=median(ampyfirstsignalatmaxsecondword1);
    madampyfirstsignalatmaxsecondword1=median(abs(ampyfirstsignalatmaxsecondword1-medianampyfirstsignalatmaxsecondword1));
%
    %CALCULATIONS MEANS/MEDIANS SD/MAD FOR SECOND WORD SIGNALS
    meanmaxampyfirstsignalword2=mean(maxampyfirstsignalword2);
    stdmaxampyfirstsignalword2=std(maxampyfirstsignalword2);
    medianmaxampyfirstsignalword2=median(maxampyfirstsignalword2);
    madmaxampyfirstsignalword2=median(abs(maxampyfirstsignalword2-medianmaxampyfirstsignalword2));
%
    meanmaxampysecondsignalword2=mean(maxampysecondsignalword2);
    stdmaxampysecondsignalword2=std(maxampysecondsignalword2);
    medianmaxampysecondsignalword2=median(maxampysecondsignalword2);
    madmaxampysecondsignalword2=median(abs(maxampysecondsignalword2-medianmaxampysecondsignalword2));
%
    meanampysecondsignalatmaxfirstword2=mean(ampysecondsignalatmaxfirstword2);
    stdampysecondsignalatmaxfirstword2=std(ampysecondsignalatmaxfirstword2);
    medianampysecondsignalatmaxfirstword2=median(ampysecondsignalatmaxfirstword2);
    madampysecondsignalatmaxfirstword2=median(abs(ampysecondsignalatmaxfirstword1-medianampysecondsignalatmaxfirstword2));
%
    meanampyfirstsignalatmaxsecondword2=mean(ampyfirstsignalatmaxsecondword2);
    stdampyfirstsignalatmaxsecondword2=std(ampyfirstsignalatmaxsecondword2);
    medianampyfirstsignalatmaxsecondword2=median(ampyfirstsignalatmaxsecondword2);
    madampyfirstsignalatmaxsecondword2=median(abs(ampyfirstsignalatmaxsecondword2-medianampyfirstsignalatmaxsecondword2));
%
% SET LOWER & UPPER BOUNDARIES FOR BOTH WORDS AND SIGNALS
mediandiffsig1wrd1=(medianmaxampyfirstsignalword1-(2*madmaxampyfirstsignalword1)); %lower boundary signal 1 word 1
mediandiffsig2wrd1=(medianmaxampysecondsignalword1 + (2*madmaxampysecondsignalword1)); %upper boundary signal 2 word 1
mediandiffsig1wrd2=(medianmaxampyfirstsignalword2+(2*madmaxampyfirstsignalword2)); %upper boundary signal 1 word 2
mediandiffsig2wrd2=(medianmaxampysecondsignalword2 - (2*madmaxampysecondsignalword2)); %lower boundary signal 2 word 2

mediandiffsig2atpeaksig1wrd1=(medianampysecondsignalatmaxfirstword1 + (2*madampysecondsignalatmaxfirstword1)); %upper boundary signal 2 word 1 at time of peak signal 1
mediandiffsig1atpeaksig2wrd2=(medianampyfirstsignalatmaxsecondword2+(2*madampyfirstsignalatmaxsecondword2)); %upper boundary signal 1 word 2 at time of peak signal 2
%
lensig1wrd1=length(maxampyfirstsignalword1)
lensig2wrd1=length(maxampysecondsignalword1)
lensig1wrd2=length(maxampyfirstsignalword2)
lensig2wrd2=length(maxampysecondsignalword2)
%
err1=1;
err2=1;
err3=1;
err4=1;
err5=1;
err6=1;
%ERROR PATTERNS BASED ON UPPER BOUNDARY OF MAX VALUES NON-TARGET
for i20=1:lensig1wrd1
    if(maxampyfirstsignalword1(i20)< mediandiffsig1wrd1)
        reducsig1wrd1(err1)=i20;
        reducsig1wrd1v(err1)=maxampyfirstsignalword1(i20);
    else
        reducsig1wrd1(err1)=0;
        reducsig1wrd1v(err1)=0;
    end
    err1=err1+1;
end
%
%maxampysecondsignalword1
%mediandiffsig2wrd1
for i21=1:lensig2wrd1
    if(maxampysecondsignalword1(i21)> mediandiffsig2wrd1)
        intrussig2wrd1(err2)=i21;
        intrussig2wrd1v(err2)=maxampysecondsignalword1(i21);
    else
        intrussig2wrd1(err2)=0;
        intrussig2wrd1v(err2)=0;
    end
    err2=err2+1;
end
%
for i22=1:lensig1wrd2
    if(maxampyfirstsignalword2(i22)> mediandiffsig1wrd2)
        intrussig1wrd2(err3)=i22;
        intrussig1wrd2v(err3)=maxampyfirstsignalword2(i22);
    else
        intrussig1wrd2(err3)=0;
        intrussig1wrd2v(err3)=0;
    end
    err3=err3+1;
end
%
for i23=1:lensig2wrd2
    if(maxampysecondsignalword2(i23)<mediandiffsig2wrd2)
        reducsig2wrd2(err4)=i23;
        reducsig2wrd2v(err4)=maxampysecondsignalword2(i23);
    else
        reducsig2wrd2(err4)=0;
        reducsig2wrd2v(err4)=0;
    end
    err4=err4+1;
end
reducsig1wrd1;
intrussig2wrd1;
reducsig2wrd2;
intrussig1wrd2;
reducsig1wrd1v;
intrussig2wrd1v;
reducsig2wrd2v;
intrussig1wrd2v;

%
%ERROR PATTERNS BASED ON UPPER BOUNDARY OF VALUES NON-TARGET AT MAX OF
%TARGET
for i24=1:lensig2wrd1
    if(ampysecondsignalatmaxfirstword1(i24)> mediandiffsig2atpeaksig1wrd1)
        intrussig2atmax1wrd1(err5)=i24;
        intrussig2atmax1wrd1v(err5)=ampysecondsignalatmaxfirstword1(i24);
    else
        intrussig2atmax1wrd1(err5)=0;
        intrussig2atmax1wrd1v(err5)=0;
    end
    err5=err5+1;
end
%
for i25=1:lensig1wrd2
    if(ampyfirstsignalatmaxsecondword2(i25)> mediandiffsig1atpeaksig2wrd2)
        intrussig1atmax2wrd2(err6)=i25;
        intrussig1atmax2wrd2v(err6)=ampyfirstsignalatmaxsecondword2(i25);
    else
        intrussig1atmax2wrd2(err6)=0;
        intrussig1atmax2wrd2v(err6)=0;
    end
    err6=err6+1;
end
%
intrussig2atmax1wrd1;
intrussig1atmax2wrd2;
intrussig2atmax1wrd1v;
intrussig1atmax2wrd2v;
% NOW PRINT DATA TO FILE
    %phiname3='d:\results\multisegment_data_auto.dat';
    fid26=fopen(phiname1,'a');
    fprintf(fid26,'%s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f %s %8.4f %8.4f %8.4f %8.4f\n',...
            'Mean,SD,Median,MAD,peak_signal_1_word_1',meanmaxampyfirstsignalword1,stdmaxampyfirstsignalword1,medianmaxampyfirstsignalword1,madmaxampyfirstsignalword1,...
            'Mean,SD,Median,MAD,peak_signal_2_word_1',meanmaxampysecondsignalword1,stdmaxampysecondsignalword1,medianmaxampysecondsignalword1,madmaxampysecondsignalword1,...
            'Mean,SD,Median,MAD,signal_2_at_peak_1_word_1',meanampysecondsignalatmaxfirstword1,stdampysecondsignalatmaxfirstword1,medianampysecondsignalatmaxfirstword1,madampysecondsignalatmaxfirstword1,...
            'Mean,SD,Median,MAD,signal_1_at_peak_2_word_1',meanampyfirstsignalatmaxsecondword1,stdampyfirstsignalatmaxsecondword1,medianampyfirstsignalatmaxsecondword1,madampyfirstsignalatmaxsecondword1,...
            'Mean,SD,Median,MAD,peak_signal_1_word_2',meanmaxampyfirstsignalword2,stdmaxampyfirstsignalword2,medianmaxampyfirstsignalword2,madmaxampyfirstsignalword2,...
            'Mean,SD,Median,MAD,peak_signal_2_word_2',meanmaxampysecondsignalword2,stdmaxampysecondsignalword2,medianmaxampysecondsignalword2,madmaxampysecondsignalword2,...
            'Mean,SD,Median,MAD,signal_2_at_peak_1_word_2',meanampysecondsignalatmaxfirstword2,stdampysecondsignalatmaxfirstword2,medianampysecondsignalatmaxfirstword2,madampysecondsignalatmaxfirstword2,...
            'Mean,SD,Median,MAD,signal_1_at_peak_2_word_2',meanampyfirstsignalatmaxsecondword2,stdampyfirstsignalatmaxsecondword2,medianampyfirstsignalatmaxsecondword2,madampyfirstsignalatmaxsecondword2);       
    fclose(fid26);
% write candidate segments (index + value) for intrusion & reduction
% gestures to file
    %phiname4='d:\results\multisegment_data_auto.dat';
    fid27=fopen(phiname1,'a');
    fprintf(fid27,'%s %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f\n','Boundaries lower_sig1wrd1,upper_sig2wrd1,upper_sig1wrd2,lower_sig2wrd2,upper_sig2atpeaksig1wrd1,upper_sig1atpeakssig2wrd2',mediandiffsig1wrd1,mediandiffsig2wrd1,mediandiffsig1wrd2,mediandiffsig2wrd2,mediandiffsig2atpeaksig1wrd1,mediandiffsig1atpeaksig2wrd2);
    fprintf(fid27,'%s\n','Reduction_sig1_wrd1');
    for j10=1:lensig1wrd1
    fprintf(fid27,'%9.4f',reducsig1wrd1(j10));
    end
    fprintf(fid27,'\n');
    for j11=1:lensig1wrd1
    fprintf(fid27,'%9.4f',reducsig1wrd1v(j11));
    end
    fprintf(fid27,'\n');
    %
    fprintf(fid27,'%s\n','Intrusion_sig2_wrd1');
    for j12=1:lensig2wrd1
    fprintf(fid27,'%9.4f',intrussig2wrd1(j12));
    end
    fprintf(fid27,'\n');
    for j13=1:lensig2wrd1
    fprintf(fid27,'%9.4f',intrussig2wrd1v(j13));
    end
    fprintf(fid27,'\n');
    %
    fprintf(fid27,'%s\n','Intrusion_sig2_at_max_sig1_wrd1');
    for j121=1:lensig2wrd1
    fprintf(fid27,'%9.4f',intrussig2atmax1wrd1(j121));
    end
    fprintf(fid27,'\n');
    for j131=1:lensig2wrd1
    fprintf(fid27,'%9.4f',intrussig2atmax1wrd1v(j131));
    end
    fprintf(fid27,'\n');
    % 
    fprintf(fid27,'%s\n','Reduction_sig2_wrd2');
    for j14=1:lensig2wrd2
    fprintf(fid27,'%9.4f',reducsig2wrd2(j14));
    end
    fprintf(fid27,'\n');
    for j15=1:lensig2wrd2
    fprintf(fid27,'%9.4f',reducsig2wrd2v(j15));
    end
    fprintf(fid27,'\n');
    %
    fprintf(fid27,'%s\n','Intrusion_sig1_wrd2');
    for j16=1:lensig1wrd2
    fprintf(fid27,'%9.4f',intrussig1wrd2(j16));
    end
    fprintf(fid27,'\n');
    for j17=1:lensig1wrd2
    fprintf(fid27,'%9.4f',intrussig1wrd2v(j17));
    end
    fprintf(fid27,'\n');
    %
    fprintf(fid27,'%s\n','Intrusion_sig1_at_max_sig2_wrd2');
    for j18=1:lensig1wrd2
    fprintf(fid27,'%9.4f',intrussig1atmax2wrd2(j18));
    end
    fprintf(fid27,'\n');
    for j19=1:lensig1wrd2
    fprintf(fid27,'%9.4f',intrussig1atmax2wrd2v(j19));
    end
    fprintf(fid27,'\n');
    fclose(fid27);
%end
%
else
    warndlg('No mean amplitudes per word have been calculated');
end

s122=1;
for s13=2:2:s11
    maxampyfirstsignalword2(s122)=maxampsignal2(s13);
    maxampysecondsignalword2(s122)=maxampsignal4(s13);
    ampysecondsignalatmaxfirstword2(s122)=ampsignal4at2(s13);
    ampyfirstsignalatmaxsecondword2(s122)=ampsignal2at4(s13);
end

% Now allow to look at individual segments and play sound
text1='Now you can select segment you wish to see and hear; notice that number of panel start with 41! ';
disp(text1);
R11=1;
counttem=0;
while R11 <999
         R11=input('Give number panel you wish to see and hear (type 999 to stop loop) ---> ');
         counttem=counttem+1;
         if R11 == 999
             break
         else
         spsegnum=R11-40;
         figure(R11);
         soundsc(spseg{spsegnum},sprate);
         if counttem > 1
             figure(302);
             subplot(3,1,1);
             plot(meanrawtimenorm1,'r','linewidth',3);hold on;
             plot(sdlow1,'--r','linewidth',2);hold on;
             plot(sdhigh1,':r','linewidth',2);hold on;
             plot(rawtimenorm1{Rprev},'blue','linewidth',2); hold on;
             subplot(3,1,2);
             plot(meanrawtimenorm2,'r','linewidth',3);hold on;
             plot(sdlow2,'--r','linewidth',2);hold on;
             plot(sdhigh2,':r','linewidth',2);hold on;
             plot(rawtimenorm2{Rprev},'blue','linewidth',2);hold on;
             subplot(3,1,3);
             plot(meanrawtimenorm3,'r','linewidth',3);hold on;
             plot(sdlow3,'--r','linewidth',2);hold on;
             plot(sdhigh3,':r','linewidth',2);hold on;
             plot(rawtimenorm3{Rprev},'blue','linewidth',2);hold on;
         else
             figure(302);
             subplot(3,1,1);
             plot(meanrawtimenorm1,'r','linewidth',3);hold on;
             plot(sdlow1,'--r','linewidth',2);hold on;
             plot(sdhigh1,':r','linewidth',2);hold on;
             plot(rawtimenorm1{spsegnum},'g','linewidth',2);hold on;
             subplot(3,1,2);
             plot(meanrawtimenorm2,'r','linewidth',3);hold on;
             plot(sdlow2,'--r','linewidth',2);hold on;
             plot(sdhigh2,':r','linewidth',2);hold on;
             plot(rawtimenorm2{spsegnum},'g','linewidth',2);hold on;
             subplot(3,1,3);
             plot(meanrawtimenorm3,'r','linewidth',3);hold on;
             plot(sdlow3,'--r','linewidth',2);hold on;
             plot(sdhigh3,':r','linewidth',2);hold on;
             plot(rawtimenorm3{spsegnum},'g','linewidth',2);hold on;
         end
         if counttem > 1
             figure(302);
             subplot(3,1,1);
             plot(meanrawtimenorm1,'r','linewidth',3);hold on;
             plot(sdlow1,'--r','linewidth',2);hold on;
             plot(sdhigh1,':r','linewidth',2);hold on;
             plot(rawtimenorm1{spsegnum},'g','linewidth',2);hold on;
             subplot(3,1,2);
             plot(meanrawtimenorm2,'r','linewidth',3);hold on;
             plot(sdlow2,'--r','linewidth',2);hold on;
             plot(sdhigh2,':r','linewidth',2);hold on;
             plot(rawtimenorm2{spsegnum},'g','linewidth',2);hold on;
             subplot(3,1,3);
             plot(meanrawtimenorm3,'r','linewidth',3);hold on;
             plot(sdlow3,'--r','linewidth',2);hold on;
             plot(sdhigh3,':r','linewidth',2);hold on;
             plot(rawtimenorm3{spsegnum},'g','linewidth',2);hold on;
         end
         Rprev=spsegnum;
         end
end

clear t* m* i* s* r* max* amp* ctem* mean* tem* rawtime*
     


     
     
