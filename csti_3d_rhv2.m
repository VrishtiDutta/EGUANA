% script file pvl_cros_sep
% This is a special version of the mavis_csti_stiff + mavis_phi_dif 
% procedures to allow quick trial by trial analysis without too
% much input from user. PvL 13-08-2004
% Dominant peaks are estimated separately for each channel.
% The function shows the CSTI window and stiffesness windows of two
% signals, and also write the data to the summary files, individual
% files and peak_valley files.
% click right mouse button to delete a point on the CSTI figure
% click left mouse button to add a new point on the CSTI figure
% press the ENTER key to get the next figure in the window
% This procedures uses the dominant freq as calculated using spectral
% analysis
% COPYRIGHT PASCAL VAN LIESHOUT, PH.D. ORAL DYNAMICS LAB
% WHEN USING PARTS OF ENTIRE SECTIONS OF THIS SOFTWARE, PLEASE REFER TO THE
% FOLLOWING PAPERS:
% van Lieshout, P. H. H. M. (2004). Dynamical systems theory and its application in speech. In B. Maassen, W. Hulstijn, H.F.M. Peters, &  P.H.H.M. Lieshout (Eds.), Speech motor control in normal and disordered speech  (pp 52-81). Oxford University Press: Oxford.
% AND
% van Lieshout PHHM. 2001. Coupling dynamics of motion primitives in speech movements and its potential relevance for fluency. Society for Chaos Theory in Psychology & Life Sciences Newsletter 8(4):18 (Abstr.)


%--------------------------------------------------------------------------
%INPUT AND PREP DATA
%--------------------------------------------------------------------------

function csti_3d_rhv2(signal1, signal2,...
    signal3, signal4, namevar1, namevar2, namevar3, namevar4,...
    ac, Fs, player, tri,respath,sub,sess,lim,rate)

%--------------------------------------------------------------------------
% I BEGIN ANALYSIS
%--------------------------------------------------------------------------

%% 1
path=respath;

% if isempty(tt)
%     uiwait(errordlg('Enter a NUMERICAL value for Trial','Error'));
%     uiresume;
%     csti_3d_mattv2(signal1, signal2, signal3, signal4, namevar1, namevar2, namevar3, namevar4, ac);
% else
    
if path(length(path)) == filesep
    path = path(1:length(path)-1);
end

%% 2 PLAY SOUND %% in rh only the sound in time interval selected is played

if Fs ~= 0

acfs=Fs; %acoustic sampling frequency
t0ac=ceil(lim(1)*acfs);
tfac=floor(lim(2)*acfs);
lenmaxac=length(ac);

if t0ac <=0, t0ac=1; end
if tfac >=lenmaxac, tfac=lenmaxac; end

% soundsc(ac(t0ac:tfac),acfs);

play(player,[t0ac,tfac]);

end


%% 3 FILTER SIGNAL BASED ON CUTOFFS INPUT
%% detrend and filter again the signal)
signal1=detrend(signal1);%signal1=filter_array_rhv2(signal1,rate,hifreq,lofreq);
signal2=detrend(signal2);%signal2=filter_array_rhv2(signal2,rate,hifreq,lofreq);
signal3=detrend(signal3);%signal3=filter_array_rhv2(signal3,rate,hifreq,lofreq);
signal4=detrend(signal4);%signal4=filter_array_rhv2(signal4,rate,hifreq,lofreq);

%% 4 select only the region of interest of the signal %%%%%%%%%%%%%%%%%%%%
    startpoint1=ceil(lim(1)*rate);
    stoppoint1=floor(lim(2)*rate);
    lentmax=length(signal1);
    
    if (startpoint1 <=0 || startpoint1>lentmax), startpoint1=1; end
    if (stoppoint1 > lentmax || stoppoint1 < 0), stoppoint1=lentmax; end
    
    signal1 = signal1(startpoint1:stoppoint1);
    signal2 = signal2(startpoint1:stoppoint1);
    signal3 = signal3(startpoint1:stoppoint1);
    signal4 = signal4(startpoint1:stoppoint1);
    
    starttime=startpoint1/rate;
    stoptime=stoppoint1/rate;
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5.1 IMPORTANT PARAMETERS FOR ANALYSIS!

% Change this to increase/decrease peak picking sensitivity
timecrit=1.5; %was set to 0.5 < 02/05/08
ampcrit=0.05;%0.1 is 10% set it to 5%
%highhz = 6;
%lowhz = 0.5;
%hifreq=highhz;%*---highhz
%lofreq=lowhz;%*---lowhz
extstr = tri;%*---tt
trialnum=extstr;%*---tt
trial=trialnum;%*---tt

%% 5.2 MAKE PULS SUGGESTION AND TIME INPUT
[maxac,maxacloc]=max(ac); % find indices for max
divsam=0.0625/1000;
pulstime=divsam*maxacloc;        

relpulsloc=pulstime-starttime;
relpulslocs=round(relpulsloc*rate);

rpt=num2str(relpulsloc);
pt=num2str(pulstime);

lpt=length(pt);
lrpt=length(rpt);
if lpt~=lrpt
    if lpt>lrpt
        for i=1:lpt-lrpt
            rpt=strcat(rpt,'0');
        end
    else
        for i=1:lrpt-lpt
            pt=strcat(pt,'0');
        end
    end
end



if relpulslocs <=0
    %relpulslocs = 1;
    %errordlg('Relpulslocs <= 0');
    stringmsm=['puls suggestion -> ' pt ;...
               'relative puls   -> ' rpt];
    ButtonName=questdlg(stringmsm,'Puls suggestion','YES','NO','YES');
else
    
ButtonName=questdlg(['puls suggestion -> ' num2str(pulstime)],...
    'Puls suggestion','YES','NO','YES');

end

colordef white;
if length(ButtonName) == 2 
    p2='Enter time of audio puls (in sec):'; %% new in version rh
    r2=inputdlg(p2,'Interval selection',1);
    pulstime=eval(r2{1});
end

if (pulstime~=0)
    relpulsloc=pulstime-starttime;
    relpulslocs=round(relpulsloc*rate);
else
    relpulslocs=1;
end

scnsize=get(0, 'ScreenSize');

if relpulslocs <=0
    questdlg('Relpulslocs <= 0','Puls Warnning','OK','OK');
    %msgbox_uiresume_rh('Relpulslocs <= 0','warning','warn');
%     fh1=figure('resize','off','Toolbar','none','NumberTitle','off',...
%    'position',[scnsize(3)*0.3 scnsize(4)*0.3 scnsize(3)*0.3 scnsize(4)*0.3]);
% 
%     uicontrol('Units','Normalized','Position',[0.4,0.005,0.2,0.05],...
%     'String','OK','Callback','uiresume(gcbf)');
%     uiwait
%     delete(fh1);
%     
end

%% 6 PREPARE PEAKS AND VALLEYS VARIABLES
vrc=ampcrit; % fixed amplitude interval %*---ampcrit
vrc_int=timecrit; %fixed time interval %*---timecrit
%prc=ampcrit; %*---ampcrit
%prc_int=timecrit; %*---timecrit
dt=1/rate;
m1=length(signal1);
%m2=length(signal2);
timeax=(1:m1)/rate;
Data1=[signal1 timeax'];
Data2=[signal2 timeax'];
Data3=[signal3 timeax'];
Data4=[signal4 timeax'];

%% 7 AUTO-FIND EXTREMES
[peak1,peaktime1,valley1,valleytime1,Data1]=pickextr_rh(Data1,vrc,vrc_int,dt);
[peak2,peaktime2,valley2,valleytime2,Data2]=pickextr_rh(Data2,vrc,vrc_int,dt);
[peak3,peaktime3,valley3,valleytime3,Data3]=pickextr_rh(Data3,vrc,vrc_int,dt);
[peak4,peaktime4,valley4,valleytime4,Data4]=pickextr_rh(Data4,vrc,vrc_int,dt);

%% 8 RETRIEVE INFORMATION FROM AUTO EXTREMES FINDER - numbers of peaks,
%% valleys and their index
%peaknumbers
peaknumber1=length(peak1);peaknumber2=length(peak2);peaknumber3=length(peak3);peaknumber4=length(peak4);
%valleynumbers
valleynumber1=length(valley1);valleynumber2=length(valley2);valleynumber3=length(valley3);valleynumber4=length(valley4);
%peakindex
peakindex1=round(peaktime1*rate);peakindex2=round(peaktime2*rate);peakindex3=round(peaktime3*rate);peakindex4=round(peaktime4*rate);
%valleyindex
valleyindex1=round(valleytime1*rate);valleyindex2=round(valleytime2*rate);valleyindex3=round(valleytime3*rate);valleyindex4=round(valleytime4*rate); 
%cycle
%cycle1=length(valley1);cycle2=length(valley2);cycle3=length(valley3);cycle4=length(valley4);
%x_pt / y_pt
x1_pt=[peakindex1; valleyindex1];y1_pt=[peak1; valley1];
x2_pt=[peakindex2; valleyindex2];y2_pt=[peak2; valley2];
x3_pt=[peakindex3; valleyindex3];y3_pt=[peak3; valley3];
x4_pt=[peakindex4; valleyindex4];y4_pt=[peak4; valley4];

%CLEAR VARIABLES FOR PLOTTING
clear seg.x1 seg.x2 raw1 raw2 wav1 wav2 ampnrm1 ampnrm2 timnrm1 timrnm2 bits1 bits2
clear seg.x3 seg.x4 raw3 raw4 wav3 wav4 ampnrm3 ampnrm4 timnrm3 timrnm4 bits3 bits4

%--------------------------------------------------------------------------
% II ANALYSIS OF SIGNAL 1 and 2
%--------------------------------------------------------------------------

%% 1. PLOT SIGNAL 1 and AUTO PEAKS LET USER ADJUST

%% 1. opens the figure and maximize
hf=figure;
%maximize;
set(hf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)]...
    ,'name',['CSTI ',namevar1,' ',namevar2]) 
clf;
whitebg(hf,'white');
%CLR = 0;

%% 1.1 open first subplot in draw peaks and valleys
subplot (8,1,1)
%t1=t1*rate;    
%t2=t2*rate;
plot(signal1,'k')
index=1;
while index<=peaknumber1 
   line(peakindex1(index),peak1(index),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
   index=index+1;
end
index=1;
while index<=valleynumber1
   line(valleyindex1(index),valley1(index),... 
		'Color','b','Marker','o', 'Tag', 'Dot','LineStyle','none')
   index=index+1;
end
set(gcf,'DoubleBuffer','on');   
title(strcat('Original waves signal',' ', namevar1),'FontSize',8,'Color','black')
ylabel('Position');

%% 1.2 call function to delete and add the points
[new_x1_pt, new_y1_pt]=myrinput_rh(x1_pt, y1_pt);
fig1_pts=[new_x1_pt, new_y1_pt];
%% 1.3 sort the points array and put the points into four arrays that are
% peakindex1, peak1, valleyindex1 and valley


[peakindex1, peak1, valleyindex1, valley1]=sort_pt(fig1_pts);
%fig1_pv = [peakindex1, valleyindex1];
objects = findobj(gcf, 'Tag', 'Dot');
set(objects, 'HandleVisibility', 'Off');

%% 2. PLOT SIGNAL 2 and AUTO PEAKS LET USER ADJUST

%% 2.1 open secound subplot in draw peaks and valleys
subplot (8,1,2)        
plot(signal2,'k');
title(strcat('Original waves signal',' ', namevar2),'FontSize',8,'Color','black')
ylabel('Position');
index=1;
while index<=peaknumber2 %draw the peak points
   line(peakindex2(index),peak2(index),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
   index=index+1;
end
index=1;
while index<=valleynumber2 %draw the valley points
   line(valleyindex2(index),valley2(index),...
		'Color','b','Marker','o', 'Tag', 'Dot','LineStyle','none')
   index=index+1;
end
%reply=questdlg('Do not make any changes to the first plot!','','OK','OK');

%% 2.2 call function to delete and add the points
%deleting and adding the points
[new_x2_pt, new_y2_pt]=myrinput_rh(x2_pt, y2_pt); 
fig2_pts=[new_x2_pt, new_y2_pt];

%% 2.3 sort the points array and put the points into four arrays that are
%peakindex2 peak2, valleyindex2 and valley2
[peakindex2, peak2, valleyindex2, valley2]=sort_pt(fig2_pts);
%fig2_pv = [peakindex2, valleyindex2];

%% 2.4 PROMPT FOR CHANGE (on first plot)
reply=questdlg('Press OK to continue OR ADJUST to correct peaks/valleys of first plot','','OK','ADJUST','OK');
if length(reply) == 6
    objects2 = findobj(gcf, 'Tag', 'Dot');
    set(objects2, 'HandleVisibility', 'Off');
    set(objects, 'HandleVisibility', 'On');
    %reply=questdlg('Do not make any changes to the second plot!','','OK','OK');
    [new_x1_pt, new_y1_pt]=myrinput_rh(new_x1_pt, new_y1_pt);
    fig1_pts=[new_x1_pt, new_y1_pt];
    [peakindex1, peak1, valleyindex1, valley1]=sort_pt(fig1_pts);
end

%% 3. CONTINUE ANALYSIS WITH CORRECTED PEAKS and VALLEYS

%% 3.1 Update the peaknumber and valleynumber
peaknumber1=length(peak1);peaknumber2=length(peak2);
valleynumber1=length(valley1);valleynumber2=length(valley2);
ii11=1;ii12=1;
ii21=1;ii22=1;
numwav11=valleynumber1-1;numwav12=peaknumber1-1;
numwav21=valleynumber2-1;numwav22=peaknumber2-1;
iii1=0;iii2=0;
iv1=0;iv2=0;

%% 3.2 SEGMENTATION
%Valley based segmentation first signal
for i11=1:ii11:numwav11;
    if ((i11+ii11-1)<=numwav11)
        iii1=iii1+1;
        seg11(iii1).x1=valleyindex1(i11);
        seg11(iii1).x2=valleyindex1(i11+ii11);
    end
end
%Peak based segmentation first signal
for i12=1:ii12:numwav12;
    if ((i12+ii12-1)<=numwav12)
        iii2=iii2+1;
        seg12(iii2).x1=peakindex1(i12);
        seg12(iii2).x2=peakindex1(i12+ii12);
    end
end
%Valley based segmentation second signal
for i21=1:ii21:numwav21;
    if ((i21+ii21-1)<=numwav21)
        iv1=iv1+1;
        seg21(iv1).x1=valleyindex2(i21);
        seg21(iv1).x2=valleyindex2(i21+ii21);
    end
end
%Peak based segmentation second signal
for i22=1:ii22:numwav22;
    if ((i22+ii22-1)<=numwav22)
        iv2=iv2+1;
        seg22(iv2).x1=peakindex2(i22);
        seg22(iv2).x2=peakindex2(i22+ii22);
    end
end
%Valley based segments signal 1
for t11=1:iii1; %cycles the number of times specified above
    p_start11=seg11(t11).x1; %x1 gives the starting point
    p_end11=seg11(t11).x2; %x2 gives the end point of the segment
    wav11=signal1(p_start11:p_end11); %cuts from the smoothed disp record
    raw11(t11)={wav11}; %puts the record into a cell array
end
%Peak based segments signal 1
for t12=1:iii2; %cycles the number of times specified above
    p_start12=seg12(t12).x1; %x1 gives the starting point
    p_end12=seg12(t12).x2; %x2 gives the end point of the segment
    wav12=signal1(p_start12:p_end12); %cuts from the smoothed disp record
    raw12(t12)={wav12}; %puts the record into a cell array
end
%Valley based segments signal 2
for t21=1:iv1; %cycles the number of times specified above
    p_start21=seg21(t21).x1; %x1 gives the starting point
    p_end21=seg21(t21).x2; %x2 gives the end point of the segment
    wav21=signal2(p_start21:p_end21); %cuts from the smoothed disp record
    raw21(t21)={wav21}; %puts the record into a cell array
end
%Peak based segments signal 2
for t22=1:iv2; %cycles the number of times specified above
    p_start22=seg22(t22).x1; %x1 gives the starting point
    p_end22=seg22(t22).x2; %x2 gives the end point of the segment
    wav22=signal2(p_start22:p_end22); %cuts from the smoothed disp record
    raw22(t22)={wav22}; %puts the record into a cell array
end

%% 3.2 AMPLITUDE NORMALIZATION
for a11=1:iii1
    ampnrm11{a11}=(raw11{a11}-(mean(raw11{a11})))/std(raw11{a11});
end
for a12=1:iii2
    ampnrm12{a12}=(raw12{a12}-(mean(raw12{a12})))/std(raw12{a12});
end
for a21=1:iv1
    ampnrm21{a21}=(raw21{a21}-(mean(raw21{a21})))/std(raw21{a21});
end
for a22=1:iv2
    ampnrm22{a22}=(raw22{a22}-(mean(raw22{a22})))/std(raw22{a22});
end
%% 3.4 time normalization
for b11=1:iii1
    timnrm11{b11}=interpft(ampnrm11{b11}',1000);
end
for b12=1:iii2
    timnrm12{b12}=interpft(ampnrm12{b12}',1000);
end
for b21=1:iv1
    timnrm21{b21}=interpft(ampnrm21{b21}',1000);
end
for b22=1:iv2
    timnrm22{b22}=interpft(ampnrm22{b22}',1000);
end

%% 4 CSTI
sdsum11=0; %ensures that the sum of the SDs is reset before starting
sdsum12=0;
sdsum21=0;
sdsum22=0;
sdsum_tot11=0;
sdsum_tot12=0;
sdsum_tot21=0;
sdsum_tot22=0;
p=20; %refers to the point in time along the wave
while p<1000; %loops until the end of 1000 point waveform is reached
clear bits11 bits12 bits21 bits22; %cleans up this variable before next cycle
for g11=1:length(timnrm11); %number of tokens to be analyzed
    bits11(g11)=timnrm11{g11}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g11=g11+1; %moves along to the next element of the cell array
end
for g12=1:length(timnrm12); %number of tokens to be analyzed
    bits12(g12)=timnrm12{g12}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g12=g12+1; %moves along to the next element of the cell array
end
for g21=1:length(timnrm21); %number of tokens to be analyzed
    bits21(g21)=timnrm21{g21}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g21=g21+1; %moves along to the next element of the cell array
end
for g22=1:length(timnrm22); %number of tokens to be analyzed
    bits22(g22)=timnrm22{g22}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g22=g22+1; %moves along to the next element of the cell array
end

sd11=std(bits11); %gets standard deviation of 'bit's which has values from elements
sdsum11=sdsum11+sd11;%adds up a running total of the sds
sd12=std(bits12); %gets standard deviation of 'bit's which has values from elements
sdsum12=sdsum12+sd12;%adds up a running total of the sds
sd21=std(bits21); %gets standard deviation of 'bit's which has values from elements
sdsum21=sdsum21+sd21;%adds up a running total of the sds
sd22=std(bits22); %gets standard deviation of 'bit's which has values from elements
sdsum22=sdsum22+sd22;%adds up a running total of the sds

p=p+20; %moves along the waveform 20 points (i.e. 2% of the 1000 point wave)
end
% cSTI values
sdsum_tot11=sdsum11; %cSTI for valley based segments signal 1
sdsum_tot12=sdsum12; %cSTI for peak based segments signal 1
sdsum_tot21=sdsum21; %cSTI for valley based segments signal 2
sdsum_tot22=sdsum22; %cSTI for peak based segments signal 2
% determine lowest cSTI for each signal & plot correct raw signals

%% 5 PLOT OTHER GRAPHS IN FIGURE 9 WITH THE PEAK VALLEY GRAPHS ABOVE
if sdsum_tot11 < sdsum_tot12
    cSTI_sig1=sdsum_tot11;
    Seg_cod1='valley';
    subplot(8,1,3);
    for c=1:iii1;
        plot(raw11{c});
        hold on
        title(strcat('Segment waves signal',' ', namevar1),'FontSize',8,'Color','red')
    end
else
    cSTI_sig1=sdsum_tot12;
    Seg_cod1='peak';
    subplot(8,1,3);
    for c=1:iii2;
        plot(raw12{c});
        hold on;
        title(strcat('Segment waves signal',' ', namevar1),'FontSize',8,'Color','red')
    end
end
if sdsum_tot21 < sdsum_tot22
    cSTI_sig2=sdsum_tot21;
    Seg_cod2='valley';
    subplot(8,1,4);
    for d=1:iv1;
        plot(raw21{d});
        hold on
        title(strcat('Segment waves signal',' ', namevar2),'FontSize',8,'Color','red')
    end
else
    cSTI_sig2=sdsum_tot22;
    Seg_cod2='peak';
    subplot(8,1,4);
    for d=1:iv2;
        plot(raw22{d});
        hold on
        title(strcat('Segment waves signal',' ', namevar2),'FontSize',8,'Color','red')
    end
    clear d;
end
% Same for amplitude normalized data
if sdsum_tot11 < sdsum_tot12
    subplot(8,1,5);
    for c=1:iii1;
        plot (ampnrm11{c})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar1),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,5);
    for c=1:iii2;
        plot (ampnrm12{c})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar1),'FontSize',8,'Color','red')
    end
end
if sdsum_tot21 < sdsum_tot22
    subplot(8,1,6);
    for d=1:iv1;
        plot (ampnrm21{d})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar2),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,6);
    for d=1:iv2;
        plot (ampnrm22{d})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar2),'FontSize',8,'Color','red')
    end
end
% Same for time normalized data
if sdsum_tot11 < sdsum_tot12
    subplot(8,1,7);
    for c=1:iii1;
        plot (timnrm11{c})
        hold on
        title(strcat('Time normalized signal',' ', namevar1),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,7);
    for c=1:iii2;
        plot (timnrm12{c})
        hold on
        title(strcat('Time normalized signal',' ', namevar1),'FontSize',8,'Color','red')
    end
end
if sdsum_tot21 < sdsum_tot22
    subplot(8,1,8);
    for d=1:iv1;
        plot (timnrm21{d})
        hold on
        title(strcat('Time normalized signal',' ', namevar2),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,8);
    for d=1:iv2;
        plot (timnrm22{d})
        hold on
        title(strcat('Time normalized signal',' ', namevar2),'FontSize',8,'Color','red')
    end
end

mess1=strcat('STI signal  ', namevar1, ' = '); %text to lead output values
mess2=strcat('STI signal  ', namevar2, ' = ');
mess3=Seg_cod1;
mess4=Seg_cod2;
disp (mess1); disp(cSTI_sig1); %display the text and the STI value
disp (mess2); disp(cSTI_sig2);
val1=num2str(cSTI_sig1); %convert into a string for the graph title
val2=num2str(cSTI_sig2);
val3=num2str(vrc);
%val4=num2str(vrc_int);

stititl=strcat(mess1,val1,'-> ',mess2,val2,'-> ',mess3,'-> ',mess4); %join text and value into a string variable
xlabel(stititl); %display on the graph  
%t=t/rate;

pause(1) % rh version

%--------------------------------------------------------------------------
% III ANALYSIS OF SIGNAL 3 and 4
%--------------------------------------------------------------------------

%% 1 - PLOT SIGNAL 3 and AUTO PEAKS, LET USER ADJUST

%% 1. opens the figure and maximize
hf=figure;
%maximize;
set(hf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)]...
    ,'name',['CSTI ',namevar3,' ',namevar4])  
clf;
whitebg(hf,'white');
%CLR = 0;

%% 1.1 open first subplot in draw peaks and valleys
subplot (8,1,1)
%t1=t1*rate;    
%t2=t2*rate;
plot(signal3,'k')
indexg=1;
while indexg<=peaknumber3 %draw the peak points
   line(peakindex3(indexg),peak3(indexg),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
   indexg=indexg+1;
end
indexg=1;
while indexg<=valleynumber3 %draw the vally points
   line(valleyindex3(indexg),valley3(indexg),...
		'Color','b','Marker','o', 'Tag', 'Dot','LineStyle','none')
   indexg=indexg+1;
end
set(gcf,'DoubleBuffer','on'); 

title(strcat('Original waves signal',' ', namevar3),'FontSize',8,'Color','black')
ylabel('Position');

%% 1.2 call function to delete and add the points
[new_x3_pt, new_y3_pt]=myrinput_rh(x3_pt, y3_pt);
fig3_pts=[new_x3_pt, new_y3_pt];
objects = findobj(gcf, 'Tag', 'Dot');
set(objects, 'HandleVisibility', 'Off');

% 1.3 sort the points array and put the points into four arrays that are
[peakindex3, peak3, valleyindex3, valley3]=sort_pt(fig3_pts);

%% 2. SIGNAL 4 PEAKS VALLEYS

%% 2.1 open secound subplot in draw peaks and valleys
subplot (8,1,2)        
plot(signal4,'k');
title(strcat('Original waves signal',' ', namevar4),'FontSize',8,'Color','black')
ylabel('Position');
indexg=1;
while indexg<=peaknumber4 %draw the peak points
   line(peakindex4(indexg),peak4(indexg),...
      'Color','r', 'Marker', 'o', 'Tag', 'Dot','LineStyle','none')
   indexg=indexg+1;
end
indexg=1;
while indexg<=valleynumber4 %draw the valley points
   line(valleyindex4(indexg),valley4(indexg),...
		'Color','b','Marker','o', 'Tag', 'Dot','LineStyle','none')
   indexg=indexg+1;
end
%reply=questdlg('Do not make any changes to the first plot!','','OK','OK');

%% 2.2 call function to delete and add the points
%deleting and adding the points
[new_x4_pt, new_y4_pt]=myrinput_rh(x4_pt, y4_pt); 
fig4_pts=[new_x4_pt, new_y4_pt];

%% 2.3 sort the points array and put the points into four arrays that are
[peakindex4, peak4, valleyindex4, valley4]=sort_pt(fig4_pts);

%% 2.4 PROMPT FOR CHANGES
reply=questdlg('Press OK to continue OR ADJUST to correct peaks/valleys of first plot','','OK','ADJUST','OK');
if length(reply) == 6
    objects2 = findobj(gcf, 'Tag', 'Dot');
    set(objects2, 'HandleVisibility', 'Off');
    set(objects, 'HandleVisibility', 'On');
    %reply=questdlg('Do not make any changes to the second plot!','','OK','OK');
    [new_x3_pt, new_y3_pt]=myrinput_rh(new_x3_pt, new_y3_pt);
    % fig1_pts=[new_x3_pt, new_y3_pt];
    [peakindex3, peak3, valleyindex3, valley3]=sort_pt(fig3_pts);
end

%% 3 CONTINUE ANALYSIS WITH CORRECTED PEAKS and VALLEYS

%% 3.1 Update the peaknumber and valleynumber
peaknumber3=length(peak3);
peaknumber4=length(peak4);
valleynumber3=length(valley3);
valleynumber4=length(valley4);
ii31=1;
ii32=1;
ii41=1;
ii42=1;
numwav31=valleynumber3-1;
numwav32=peaknumber3-1;
numwav41=valleynumber4-1;
numwav42=peaknumber4-1;
iii1=0;
iii2=0;
iv1=0;
iv2=0;
%% 3.2 SEGMENTATION
%Valley based segmentation first signal
for i31=1:ii31:numwav31;
    if ((i31+ii31-1)<=numwav31)
        iii1=iii1+1;
        seg31(iii1).x1=valleyindex3(i31);
        seg31(iii1).x2=valleyindex3(i31+ii31);
    end
end
%Peak based segmentation first signal
for i32=1:ii32:numwav32;
    if ((i32+ii32-1)<=numwav32)
        iii2=iii2+1;
        seg32(iii2).x1=peakindex3(i32);
        seg32(iii2).x2=peakindex3(i32+ii32);
    end
end
%Valley based segmentation second signal
for i41=1:ii41:numwav41;
    if ((i41+ii41-1)<=numwav41)
        iv1=iv1+1;
        seg41(iv1).x1=valleyindex4(i41);
        seg41(iv1).x2=valleyindex4(i41+ii41);
    end
end
%Peak based segmentation second signal
for i42=1:ii42:numwav42;
    if ((i42+ii42-1)<=numwav42)
        iv2=iv2+1;
        seg42(iv2).x1=peakindex4(i42);
        seg42(iv2).x2=peakindex4(i42+ii42);
    end
end
%Valley based segments signal 1
for t31=1:iii1; %cycles the number of times specified above
    p_start31=seg31(t31).x1; %x1 gives the starting point
    p_end31=seg31(t31).x2; %x2 gives the end point of the segment
    wav31=signal3(p_start31:p_end31); %cuts from the smoothed disp record
    raw31(t31)={wav31}; %puts the record into a cell array
end
%Peak based segments signal 1
for t32=1:iii2; %cycles the number of times specified above
    p_start32=seg32(t32).x1; %x1 gives the starting point
    p_end32=seg32(t32).x2; %x2 gives the end point of the segment
    wav32=signal3(p_start32:p_end32); %cuts from the smoothed disp record
    raw32(t32)={wav32}; %puts the record into a cell array
end
%Valley based segments signal 2
for t41=1:iv1; %cycles the number of times specified above
    p_start41=seg41(t41).x1; %x1 gives the starting point
    p_end41=seg41(t41).x2; %x2 gives the end point of the segment
    wav41=signal4(p_start41:p_end41); %cuts from the smoothed disp record
    raw41(t41)={wav41}; %puts the record into a cell array
end
%Peak based segments signal 2
for t42=1:iv2; %cycles the number of times specified above
    p_start42=seg42(t42).x1; %x1 gives the starting point
    p_end42=seg42(t42).x2; %x2 gives the end point of the segment
    wav42=signal4(p_start42:p_end42); %cuts from the smoothed disp record
    raw42(t42)={wav42}; %puts the record into a cell array
end

%% 3.3 AMPLITUDE NORMALIZATION
for a31=1:iii1
    ampnrm31{a31}=(raw31{a31}-(mean(raw31{a31})))/std(raw31{a31});
end
for a32=1:iii2
    ampnrm32{a32}=(raw32{a32}-(mean(raw32{a32})))/std(raw32{a32});
end
for a41=1:iv1
    ampnrm41{a41}=(raw41{a41}-(mean(raw41{a41})))/std(raw41{a41});
end
for a42=1:iv2
    ampnrm42{a42}=(raw42{a42}-(mean(raw42{a42})))/std(raw42{a42});
end

%% 3.4 Time normalization
for b31=1:iii1
    timnrm31{b31}=interpft(ampnrm31{b31}',1000);
end
for b32=1:iii2
    timnrm32{b32}=interpft(ampnrm32{b32}',1000);
end
for b41=1:iv1
    timnrm41{b41}=interpft(ampnrm41{b41}',1000);
end
for b42=1:iv2
    timnrm42{b42}=interpft(ampnrm42{b42}',1000);
end

%% 4 CSTI
sdsum31=0; %ensures that the sum of the SDs is reset before starting
sdsum32=0;
sdsum41=0;
sdsum42=0;
sdsum_tot31=0;
sdsum_tot32=0;
sdsum_tot41=0;
sdsum_tot42=0;
p=20; %refers to the point in time along the wave
while p<1000; %loops until the end of 1000 point waveform is reached
clear bits31 bits32 bits41 bits42; %cleans up this variable before next cycle
for g31=1:length(timnrm31); %number of tokens to be analyzed
    bits31(g31)=timnrm31{g31}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g31=g31+1; %moves along to the next element of the cell array
end
for g32=1:length(timnrm32); %number of tokens to be analyzed
    bits32(g32)=timnrm32{g32}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g32=g32+1; %moves along to the next element of the cell array
end
for g41=1:length(timnrm41); %number of tokens to be analyzed
    bits41(g41)=timnrm41{g41}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g41=g41+1; %moves along to the next element of the cell array
end
for g42=1:length(timnrm42); %number of tokens to be analyzed
    bits42(g42)=timnrm42{g42}(p); %variable 'bits' element 'g' extracted from cell 'g' of
    %cell array 'timnrm' at time 'p'
    g42=g42+1; %moves along to the next element of the cell array
end

sd31=std(bits31); %gets standard deviation of 'bit's which has values from elements
sdsum31=sdsum31+sd31;%adds up a running total of the sds
sd32=std(bits32); %gets standard deviation of 'bit's which has values from elements
sdsum32=sdsum32+sd32;%adds up a running total of the sds
sd41=std(bits41); %gets standard deviation of 'bit's which has values from elements
sdsum41=sdsum41+sd41;%adds up a running total of the sds
sd42=std(bits42); %gets standard deviation of 'bit's which has values from elements
sdsum42=sdsum42+sd42;%adds up a running total of the sds

p=p+20; %moves along the waveform 20 points (i.e. 2% of the 1000 point wave)
end
% cSTI values
sdsum_tot31=sdsum31; %cSTI for valley based segments signal 1
sdsum_tot32=sdsum32; %cSTI for peak based segments signal 1
sdsum_tot41=sdsum41; %cSTI for valley based segments signal 2
sdsum_tot42=sdsum42; %cSTI for peak based segments signal 2

%% 5 PLOT OTHER GRAPHS IN FIGURE 10 WITH THE PEAK VALLEY GRAPHS ABOVE
% determine lowest cSTI for each signal & plot correct raw signals
if sdsum_tot31 < sdsum_tot32
    cSTI_sig3=sdsum_tot31;
    Seg_cod3='valley';
    subplot(8,1,3);
    for c=1:iii1;
        plot(raw31{c});
        hold on
        title(strcat('Segment waves signal',' ', namevar3),'FontSize',8,'Color','red')
    end
else
    cSTI_sig3=sdsum_tot32;
    Seg_cod3='peak';
    subplot(8,1,3);
    for c=1:iii2;
        plot(raw32{c});
        hold on
        title(strcat('Segment waves signal',' ', namevar3),'FontSize',8,'Color','red')
    end
end
if sdsum_tot41 < sdsum_tot42
    cSTI_sig4=sdsum_tot41;
    Seg_cod4='valley';
    subplot(8,1,4);
    for d=1:iv1;
        plot(raw41{d});
        hold on
        title(strcat('Segment waves signal',' ', namevar4),'FontSize',8,'Color','red')
    end
    clear d;
else
    cSTI_sig4=sdsum_tot42;
    Seg_cod4='peak';
    subplot(8,1,4);
    for d=1:iv2;
        plot(raw42{d});
        hold on
        title(strcat('Segment waves signal',' ', namevar4),'FontSize',8,'Color','red')
    end
end

% Same for amplitude normalized data
if sdsum_tot31 < sdsum_tot32
    subplot(8,1,5);
    for c=1:iii1;
        plot (ampnrm31{c})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar3),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,5);
    for c=1:iii2;
        plot (ampnrm32{c})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar3),'FontSize',8,'Color','red')
    end
end
if sdsum_tot41 < sdsum_tot42
    subplot(8,1,6);
    for d=1:iv1;
        plot (ampnrm41{d})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar4),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,6);
    for d=1:iv2;
        plot (ampnrm42{d})
        hold on
        title(strcat('Amplitude normalized signal',' ', namevar4),'FontSize',8,'Color','red')
    end
end
% Same for time normalized data

if sdsum_tot31 < sdsum_tot32
    subplot(8,1,7);
    for c=1:iii1;
        plot (timnrm31{c})
        hold on
        title(strcat('Time normalized signal',' ', namevar3),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,7);
    for c=1:iii2;
        plot (timnrm32{c})
        hold on
        title(strcat('Time normalized signal',' ', namevar3),'FontSize',8,'Color','red')
    end
end
if sdsum_tot41 < sdsum_tot42
    subplot(8,1,8);
    for d=1:iv1;
        plot (timnrm41{d})
        hold on
        title(strcat('Time normalized signal',' ', namevar4),'FontSize',8,'Color','red')
    end
else
    subplot(8,1,8);
    for d=1:iv2;
        plot (timnrm42{d})
        hold on
        title(strcat('Time normalized signal',' ', namevar4),'FontSize',8,'Color','red')
    end
end

mess5=strcat('STI signal  ', namevar3, ' = '); %text to lead output values
mess6=strcat('STI signal  ', namevar4, ' = ');
mess7=Seg_cod3;
mess8=Seg_cod4;
disp (mess5), disp(cSTI_sig3) %display the text and the STI value
disp (mess6), disp(cSTI_sig4)
val5=num2str(cSTI_sig3); %convert into a string for the graph title
val6=num2str(cSTI_sig4);

stitit2=strcat(mess5,val5,'-> ',mess6,val6,'-> ',mess7,'-> ',mess8); %join text and value into a string variable
xlabel(stitit2); %display on the graph  
%t=t/rate;

% update the peaktime and valleytime
[peaktime1, valleytime1] = update_pv_rh(Data1, peak1, valley1);
[peaktime2, valleytime2] = update_pv_rh(Data2, peak2, valley2);
[peaktime3, valleytime3] = update_pv_rh(Data3, peak3, valley3);
[peaktime4, valleytime4] = update_pv_rh(Data4, peak4, valley4);

pause(1) %intruduced in rh version

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IV KINEMATIC ANALYSIS OF SIGNAL 1, 2, 3, 4 (Each has own plot window) %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1 CALCULATE KINEMATIC DATA
%Calculate the kinematic data for signal1
[velocity, ampl, velo1,dur, stiffness, cvalue, xtime, percent,...
ampl2, velo2 ,dur2, stiff2, cvalue2, xtime2, percent2, val000, val2000,peakindex1,peak1,peaknumber1] = stiffness_var_rhv2(signal1,...
rate, peaknumber1,valleynumber1,peakindex1, valleyindex1, peak1,  valley1);
    
%Calculate the kinematic data for signal2
[velocity_2, ampl_2, velo1_2,dur_2, stiffness_2, cvalue_2, xtime_2, percent_2,...
ampl2_2, velo2_2 ,dur2_2, stiff2_2, cvalue2_2, xtime2_2, percent2_2, val000_2, val2000_2,peakindex2,peak2,peaknumber2]= stiffness_var_rhv2(signal2,...
rate,peaknumber2, valleynumber2,peakindex2, valleyindex2, peak2,valley2);

%Calculate the kinematic data for signal3
[velocity_3, ampl_3, velo1_3,dur_3, stiffness_3, cvalue_3, xtime_3, percent_3,...
ampl2_3, velo2_3,dur2_3, stiff2_3, cvalue2_3, xtime2_3, percent2_3, val000_3, val2000_3,peakindex3,peak3,peaknumber3] = stiffness_var_rhv2(signal3,...
rate, peaknumber3, valleynumber3, peakindex3, valleyindex3, peak3,valley3);
    
%Calculate the kinematic data for signal4
[velocity_4, ampl_4, velo1_4,dur_4, stiffness_4, cvalue_4, xtime_4, percent_4,...
ampl2_4, velo2_4 ,dur2_4, stiff2_4, cvalue2_4, xtime2_4, percent2_4, val000_4, val2000_4,peakindex4,peak4,peaknumber4]= stiffness_var_rhv2(signal4,...
rate, peaknumber4, valleynumber4,peakindex4, valleyindex4, peak4, valley4);

%% 2 Ploting the Kinematic data 

%Specifying the figures position
bdwidth=5;
topbdwidth=30;
set(0, 'Units', 'pixels')
scnsize=get(0, 'ScreenSize');
pos1=[bdwidth, 2/3*scnsize(4) + bdwidth,...
        scnsize(3)/2 - 2*bdwidth, ...
        scnsize(4)/3 - (topbdwidth + bdwidth)];
pos2=[pos1(1) + scnsize(3)/2,...
        pos1(2), pos1(3), pos1(4)];

%[choice, wora, confirm, path, sub, trialnum] = stiffness_input;
%dt=1/rate;
m1=length(signal1);

clear t1
t1=(1:m1)/rate;  

%Function call for the signal1 stiffness figure window 
[dur3, sumdur3, val00,val01,val02,val03,val04,val05,val06,val07,val08,val09,val010,val011,val012,val013,...
val014,val015,val016,val017,val018,val019,val020,val021,val0211,val0212,val0213,val0214,val022,val023,...
val024,val025,val000,val2000] = stiffness_figure_rh(pos1, signal1, peakindex1, peak1, valleyindex1, ...
valley1, velocity, ampl, velo1, dur, stiffness, cvalue, percent,ampl2, velo2 ,dur2, stiff2, cvalue2,... 
percent2, val000, val2000, sub, trialnum, namevar1); 

set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)]) 
%maximize;


%Function call for the signal2 stiffness figure window    
[dur3_2, sumdur3_2, val00_2,val01_2,val02_2,val03_2,val04_2,val05_2,val06_2,val07_2,val08_2,val09_2,val010_2,...
val011_2,val012_2,val013_2, val014_2,val015_2,val016_2,val017_2,val018_2,val019_2,val020_2,val021_2,val0211_2,...
val0212_2,val0213_2,val0214_2,val022_2,val023_2, val024_2,val025_2,val000_2,val2000_2] = stiffness_figure_rh(pos2,...
signal2,peakindex2, peak2, valleyindex2, valley2,velocity_2, ampl_2, velo1_2,dur_2, stiffness_2, cvalue_2,...
percent_2, ampl2_2, velo2_2 ,dur2_2, stiff2_2, cvalue2_2, percent2_2,...
val000_2, val2000_2, sub, trialnum, namevar2);

set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)]) 
%maximize;

%Function call for the signal3 stiffness figure window    
[dur3_3, sumdur3_3, val00_3,val01_3,val02_3,val03_3,val04_3,val05_3,val06_3,val07_3,val08_3,val09_3,val010_3,...
val011_3,val012_3,val013_3, val014_3,val015_3,val016_3,val017_3,val018_3,val019_3,val020_3,val021_3,val0211_3,...
val0212_3,val0213_3,val0214_3,val022_3,val023_3, val024_3,val025_3,val000_3,val2000_3] = stiffness_figure_rh(pos1,...
signal3,peakindex3, peak3, valleyindex3, valley3,velocity_3, ampl_3, velo1_3,dur_3, stiffness_3, cvalue_3,...
percent_3, ampl2_3, velo2_3 ,dur2_3, stiff2_3, cvalue2_3, percent2_3,...
val000_3, val2000_3, sub, trialnum, namevar3);

set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)]) 
%maximize;

%Function call for the signal4 stiffness figure window    
[dur3_4, sumdur3_4, val00_4,val01_4,val02_4,val03_4,val04_4,val05_4,val06_4,val07_4,val08_4,val09_4,val010_4,...
val011_4,val012_4,val013_4, val014_4,val015_4,val016_4,val017_4,val018_4,val019_4,val020_4,val021_4,val0211_4,...
val0212_4,val0213_4,val0214_4,val022_4,val023_4, val024_4,val025_4,val000_4,val2000_4] = stiffness_figure_rh(pos2,...
signal4,peakindex4, peak4, valleyindex4, valley4,velocity_4, ampl_4, velo1_4,dur_4, stiffness_4, cvalue_4,...
percent_4, ampl2_4, velo2_4 ,dur2_4, stiff2_4, cvalue2_4,percent2_4,...
val000_4, val2000_4, sub, trialnum, namevar4);

set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
%maximize;


%--------------------------------------------------------------------------
%% V STORE ALL DATA PROCESSED FOR 1, 2, 3, 4 IN FILES
%--------------------------------------------------------------------------
% string1=['STI_signal ','Segment_amp_criterion_signal ','interval_of_signal ','subject ',...
% 'trial ','channel ','amp1 SD_amp1','amp2 SD_amp2 ','pvel1 SD_pvel1 ','pvel2 SD_pvel2 ',...
% 'dur1 SD_dur1 ','dur2 SD_dur2 ','dur_cycle SD_durcycle ','stiff1 SD_stiff1 ','stiff2 SD_stiff2 ',...
% 'vpp1 SD_vpp1  ','vpp2 SD_vpp2 ','vps1 SD_vps1 ','vps2 SD_vps2 ','slope_duration/stiffness(1st) ',...
% 'slope_duration/stiffness(2nd) ','slope_amplitude/constant(1st) ','slope_amplitude/constant(2nd) ',...
% 'RMS_velocity ','no. cycles'];
% 
% string2=['subject ','trial ','channel ','amp1 ','amp2 ','pvel1 ','pvel2 ','dur1 ','dur2 ','dur-cyc ',...
% 'dur-cum ','stiff1 ','stiff2 ','vpp1 ','vpp2 ','vps1 ','vps2'];
% 
% string3=['subject ','trial ','channel ','peak_x ','peak_y ','valley_x ','valley_y '];

z=1.5;
interval=num2str(z);            

%sample name from other code
%fs_1=strcat(path, '\',sess,'.',tri,'.stiff_S.',namevar1,'.txt'); all tri
%(trial # info) removed from file names; PvL 280110
fs_1=strcat(path, filesep, sess,'.stiff_S.',namevar1,'.txt');
fs_2=strcat(path, filesep, sess,'.stiff_S.',namevar2,'.txt');
fi_1=strcat(path, filesep, sess,'.stiff_I.',namevar1,'.txt');
fi_2=strcat(path, filesep, sess,'.stiff_I.',namevar2,'.txt');
fpv_1=strcat(path, filesep, sess,'.Peak_Valley.',namevar1,'.txt');
fpv_2=strcat(path, filesep, sess,'.Peak_Valley.',namevar2,'.txt');

fs_3=strcat(path, filesep, sess,'.stiff_S.',namevar3,'.txt');
fs_4=strcat(path, filesep, sess,'.stiff_S.',namevar4,'.txt');
fi_3=strcat(path, filesep, sess,'.stiff_I.',namevar3,'.txt');
fi_4=strcat(path, filesep, sess,'.stiff_I.',namevar4,'.txt');
fpv_3=strcat(path, filesep, sess,'.Peak_Valley.',namevar3,'.txt');
fpv_4=strcat(path, filesep, sess,'.Peak_Valley.',namevar4,'.txt');
    
if path~=0
    fid11=fopen(fs_1,'a'); % add data into the summary files
    disp(fid11)
    fprintf(fid11,'%s\n %s %s %s %s %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val1, val3, interval, Seg_cod1,sub,trialnum,namevar1,val00,val01,val02,val03,val04,val05,val06,val07,val08,val09,val010,val011,val012,val013,val014,val015,val016,val017,val018,val019,val020,val021,val0211,val0212,val0213,val0214,val022,val023,val024,val025,val000,val2000);
    fclose(fid11);

    fid12=fopen(fs_2,'a');
    fprintf(fid12,'%s\n %s %s %s %s %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val2, val3, interval, Seg_cod2,sub,trialnum,namevar2,val00_2,val01_2,val02_2,val03_2,val04_2,val05_2,val06_2,val07_2,val08_2,val09_2,val010_2,...
                val011_2,val012_2,val013_2, val014_2,val015_2,val016_2,val017_2,val018_2,val019_2,val020_2,val021_2,val0211_2, val0212_2,val0213_2,val0214_2,val022_2,val023_2, val024_2,val025_2,val000_2,val2000_2);
    fclose(fid12); 

    fid13=fopen(fs_3,'a');
    fprintf(fid13,'%s\n %s %s %s %s %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val5, val3, interval, Seg_cod3,sub,trialnum,namevar3,val00_3,val01_3,val02_3,val03_3,val04_3,val05_3,val06_3,val07_3,val08_3,val09_3,val010_3,...
                val011_3,val012_3,val013_3, val014_3,val015_3,val016_3,val017_3,val018_3,val019_3,val020_3,val021_3,val0211_3, val0212_3,val0213_3,val0214_3,val022_3,val023_3, val024_3,val025_3,val000_3,val2000_3);
    fclose(fid13); 

    fid14=fopen(fs_4,'a');
    fprintf(fid14,'%s\n %s %s %s %s %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val6, val3, interval, Seg_cod4,sub,trialnum,namevar4,val00_4,val01_4,val02_4,val03_4,val04_4,val05_4,val06_4,val07_4,val08_4,val09_4,val010_4,...
                val011_4,val012_4,val013_4, val014_4,val015_4,val016_4,val017_4,val018_4,val019_4,val020_4,val021_4,val0211_4, val0212_4,val0213_4,val0214_4,val022_4,val023_4, val024_4,val025_4,val000_4,val2000_4);
    fclose(fid14); 

    %Find general estimate of dominant frequency
    temppvl1=str2num(val012_4);
    temppvl2=str2num(val012_3);
    if (temppvl1 == temppvl2);
        temppvl3=(temppvl1)*1000;
        passbandfreq=1000/temppvl3;
    elseif (temppvl2 > temppvl1)
        temppvl3=(temppvl2)*1000;
        passbandfreq=1000/temppvl3;
    elseif (temppvl1 > temppvl2)
        temppvl3=(temppvl1)*1000;
        passbandfreq=1000/temppvl3;
    end
    %passbandfreq;
    %passbandacous=round(passbandfreq);    
    if passbandfreq < 0.5
        passbandfreq=0.6;
    end
    for nm=1:(length(ampl)) % add data into the individual files
        fid15=fopen(fi_1,'a');
        fprintf(fid15,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar1,ampl(nm),ampl2(nm),velo1(nm),velo2(nm),dur(nm),dur2(nm),dur3(nm),sumdur3(nm),stiffness(nm),stiff2(nm),cvalue(nm),cvalue2(nm),percent(nm),percent2(nm));
        fprintf(fid15,'\n');
        fclose(fid15);
    end
    for nm=1:(length(ampl_2))
        fid16=fopen(fi_2,'a');
        fprintf(fid16,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar2,ampl_2(nm),ampl2_2(nm),velo1_2(nm),velo2_2(nm),dur_2(nm),dur2_2(nm),dur3_2(nm),sumdur3_2(nm),stiffness_2(nm),stiff2_2(nm),cvalue_2(nm),cvalue2_2(nm),percent_2(nm),percent2_2(nm));
        fprintf(fid16,'\n');
        fclose(fid16);
    end
    for nm=1:(length(ampl_3))
        fid17=fopen(fi_3,'a');
        fprintf(fid17,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar3,ampl_3(nm),ampl2_3(nm),velo1_3(nm),velo2_3(nm),dur_3(nm),dur2_3(nm),dur3_3(nm),sumdur3_3(nm),stiffness_3(nm),stiff2_3(nm),cvalue_3(nm),cvalue2_3(nm),percent_3(nm),percent2_3(nm));
        fprintf(fid17,'\n');
        fclose(fid17);
    end 
    for nm=1:(length(ampl_4))
        fid18=fopen(fi_4,'a');
        fprintf(fid18,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar4,ampl_4(nm),ampl2_4(nm),velo1_4(nm),velo2_4(nm),dur_4(nm),dur2_4(nm),dur3_4(nm),sumdur3_4(nm),stiffness_4(nm),stiff2_4(nm),cvalue_4(nm),cvalue2_4(nm),percent_4(nm),percent2_4(nm));
        fprintf(fid18,'\n');
        fclose(fid18);
    end 
    %Add data into the peak_valley files
    index=1;
    fid19=fopen(fpv_1, 'a');
    if peaknumber1 == valleynumber1
        while index <= valleynumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
    elseif peaknumber1 > valleynumber1
        while index <= valleynumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
        fprintf(fid19, '%s %s %s %f %f -- --\n', sub, trialnum, namevar1, peakindex1(index), peak1(index));
    elseif peaknumber1 < valleynumber1
        while index <= peaknumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
        fprintf(fid19, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar1, valleyindex1(index), valley1(index));  
    end
    fclose(fid19);  

    index=1;
    fid110=fopen(fpv_2, 'a');
    if peaknumber2 == valleynumber2
        while index <= valleynumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar2, peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
    elseif peaknumber2 > valleynumber2
        while index<=valleynumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar2,  peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
        fprintf(fid110, '%s %s %s %f %f -- --\n', sub, trialnum, namevar2, peakindex2(index), peak2(index));
    elseif peaknumber2 < valleynumber2
        while index <= peaknumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar2, peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
        fprintf(fid110, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar2, valleyindex2(index), valley2(index));  
    end
    fclose(fid110);

    index=1;
    fid111=fopen(fpv_3, 'a');
    if peaknumber3 == valleynumber3
        while index <= valleynumber3
        fprintf(fid111, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar3, peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
        index=index+1;
        end
    elseif peaknumber3 > valleynumber3
        while index<=valleynumber3
        fprintf(fid111, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar3,  peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
        index=index+1;
        end
        fprintf(fid111, '%s %s %s %f %f -- --\n', sub, trialnum, namevar3, peakindex3(index), peak3(index));
    elseif peaknumber3 < valleynumber3
        while index <= peaknumber3
            fprintf(fid111, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar3, peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
            index=index+1;
        end
        fprintf(fid111, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar3, valleyindex3(index), valley3(index));  
    end
    fclose(fid111);

    index=1;
    fid112=fopen(fpv_4, 'a');
    if peaknumber4 == valleynumber4
        while index <= valleynumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar4, peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
    elseif peaknumber4 > valleynumber4
        while index<=valleynumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar4,  peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
        fprintf(fid112, '%s %s %s %f %f -- --\n', sub, trialnum, namevar4, peakindex4(index), peak4(index));
    elseif peaknumber4 < valleynumber4
        while index <= peaknumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar4, peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
        fprintf(fid112, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar4, valleyindex4(index), valley4(index));  
    end
    fclose(fid112);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  VI KINEMATIC ANALYSIS OF SIGNAL 1, 2, 3, 4                           %%
%%  90 10 percent amplitude on interval selection method                %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

K91Q=questdlg('Do you also want kinematic data for an amplitude range?',...
    'Amplitude Kinematic analysis','yes','no','no');
if strcmp(K91Q,'yes')

    prompt = {'Enter lower value:','Enter higher value:'};
    dlg_title = 'Amplitude for Kinematic analysis';
    num_lines = 1;
    def = {'10','90'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    loweramp = str2num(answer{1});
    higheramp = str2num(answer{2});
    
    %% 1 Calculate the 90-10% Kinematic data signal
    %Calculate the kinematic data for signal1
    [velocity, ampl, velo1,dur, stiffness, cvalue, xtime, percent,...
    ampl2, velo2 ,dur2, stiff2, cvalue2, xtime2, percent2, val000, val2000,...
    allind10_90_s1,velocity10_90_s1,peakindex1,peak1,peaknumber1] = stiffness_90_10_rhv2(signal1,...
    rate, peaknumber1,valleynumber1,peakindex1, valleyindex1, peak1,  valley1, loweramp, higheramp);

    %Calculate the kinematic data for signal2
    [velocity_2, ampl_2, velo1_2,dur_2, stiffness_2, cvalue_2, xtime_2, percent_2,...
    ampl2_2, velo2_2 ,dur2_2, stiff2_2, cvalue2_2, xtime2_2, percent2_2, val000_2, val2000_2,...
    allind10_90_s2,velocity10_90_s2,peakindex2,peak2,peaknumber2] = stiffness_90_10_rhv2(signal2,...
    rate,peaknumber2, valleynumber2,peakindex2, valleyindex2, peak2,valley2, loweramp, higheramp);

    %Calculate the kinematic data for signal3
    [velocity_3, ampl_3, velo1_3,dur_3, stiffness_3, cvalue_3, xtime_3, percent_3,...
    ampl2_3, velo2_3,dur2_3, stiff2_3, cvalue2_3, xtime2_3, percent2_3, val000_3, val2000_3,...
    allind10_90_s3,velocity10_90_s3,peakindex3,peak3,peaknumber3]= stiffness_90_10_rhv2(signal3,...
    rate, peaknumber3, valleynumber3, peakindex3, valleyindex3, peak3,valley3, loweramp, higheramp);

    %Calculate the kinematic data for signal4
    [velocity_4, ampl_4, velo1_4,dur_4, stiffness_4, cvalue_4, xtime_4, percent_4,...
    ampl2_4, velo2_4 ,dur2_4, stiff2_4, cvalue2_4, xtime2_4, percent2_4, val000_4, val2000_4,...
    allind10_90_s4,velocity10_90_s4,peakindex4,peak4,peaknumber4]= stiffness_90_10_rhv2(signal4,...
    rate, peaknumber4, valleynumber4,peakindex4, valleyindex4, peak4, valley4, loweramp, higheramp);


    %% 2 Ploting the 9010 Kinematic data 

    %Specifying the figures position
    bdwidth=5;
    topbdwidth=30;
    set(0, 'Units', 'pixels')
    scnsize=get(0, 'ScreenSize');
    pos1=[bdwidth, 2/3*scnsize(4) + bdwidth,...
            scnsize(3)/2 - 2*bdwidth, ...
            scnsize(4)/3 - (topbdwidth + bdwidth)];
    pos2=[pos1(1) + scnsize(3)/2,...
            pos1(2), pos1(3), pos1(4)];

    %[choice, wora, confirm, path, sub, trialnum] = stiffness_input;
    
    %dt=1/rate;
    %m1=length(signal1);

    %clear t1
    %t1=(1:m1)/rate;  

    %Function call for the signal1 stiffness figure window 
    [dur3, sumdur3, val00,val01,val02,val03,val04,val05,val06,val07,val08,val09,val010,val011,val012,val013,...
    val014,val015,val016,val017,val018,val019,val020,val021,val0211,val0212,val0213,val0214,val022,val023,...
    val024,val025,val000,val2000] = stiff9010_figure_rh(pos1, signal1, ...
    velocity, ampl, velo1, dur, stiffness, cvalue,percent,ampl2, velo2 ,dur2, stiff2, cvalue2,... 
    percent2, val000, val2000,allind10_90_s1,velocity10_90_s1,sub, trialnum, namevar1); 

    set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
    %maximize;


    %Function call for the signal2 stiffness figure window    
    [dur3_2, sumdur3_2, val00_2,val01_2,val02_2,val03_2,val04_2,val05_2,val06_2,val07_2,val08_2,val09_2,val010_2,...
    val011_2,val012_2,val013_2, val014_2,val015_2,val016_2,val017_2,val018_2,val019_2,val020_2,val021_2,val0211_2,...
    val0212_2,val0213_2,val0214_2,val022_2,val023_2, val024_2,val025_2,val000_2,val2000_2] = stiff9010_figure_rh(pos2,...
    signal2,velocity_2, ampl_2, velo1_2,dur_2, stiffness_2, cvalue_2,...
    percent_2, ampl2_2, velo2_2 ,dur2_2, stiff2_2, cvalue2_2, percent2_2,...
    val000_2, val2000_2,allind10_90_s2,velocity10_90_s2, sub, trialnum, namevar2);

    set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
    %maximize;

    %Function call for the signal3 stiffness figure window    
    [dur3_3, sumdur3_3, val00_3,val01_3,val02_3,val03_3,val04_3,val05_3,val06_3,val07_3,val08_3,val09_3,val010_3,...
    val011_3,val012_3,val013_3, val014_3,val015_3,val016_3,val017_3,val018_3,val019_3,val020_3,val021_3,val0211_3,...
    val0212_3,val0213_3,val0214_3,val022_3,val023_3, val024_3,val025_3,val000_3,val2000_3] = stiff9010_figure_rh(pos1,...
    signal3,velocity_3, ampl_3, velo1_3,dur_3, stiffness_3, cvalue_3,...
    percent_3, ampl2_3, velo2_3 ,dur2_3, stiff2_3, cvalue2_3, percent2_3,...
    val000_3, val2000_3,allind10_90_s3,velocity10_90_s3, sub, trialnum, namevar3);

    set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
    %maximize;

    %Function call for the signal4 stiffness figure window    
    [dur3_4, sumdur3_4, val00_4,val01_4,val02_4,val03_4,val04_4,val05_4,val06_4,val07_4,val08_4,val09_4,val010_4,...
    val011_4,val012_4,val013_4, val014_4,val015_4,val016_4,val017_4,val018_4,val019_4,val020_4,val021_4,val0211_4,...
    val0212_4,val0213_4,val0214_4,val022_4,val023_4, val024_4,val025_4,val000_4,val2000_4] = stiff9010_figure_rh(pos2,...
    signal4,velocity_4, ampl_4, velo1_4,dur_4, stiffness_4, cvalue_4,...
    percent_4, ampl2_4, velo2_4 ,dur2_4, stiff2_4, cvalue2_4, percent2_4,...
    val000_4, val2000_4,allind10_90_s4,velocity10_90_s4, sub, trialnum, namevar4);

     set(gcf,'position',[scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)])
    %maximize;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VII STORE ALL DATA PROCESSED FOR 1, 2, 3, 4 IN FILES                  %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% string1=['STI_signal ','Segment_amp_criterion_signal ','interval_of_signal ','subject ',...
% 'trial ','channel ','amp1 SD_amp1','amp2 SD_amp2 ','pvel1 SD_pvel1 ','pvel2 SD_pvel2 ',...
% 'dur1 SD_dur1 ','dur2 SD_dur2 ','dur_cycle SD_durcycle ','stiff1 SD_stiff1 ','stiff2 SD_stiff2 ',...
% 'vpp1 SD_vpp1  ','vpp2 SD_vpp2 ','vps1 SD_vps1 ','vps2 SD_vps2 ','slope_duration/stiffness(1st) ',...
% 'slope_duration/stiffness(2nd) ','slope_amplitude/constant(1st) ','slope_amplitude/constant(2nd) ',...
% 'RMS_velocity ','no. cycles'];
% 
% string2=['subject ','trial ','channel ','amp1 ','amp2 ','pvel1 ','pvel2 ','dur1 ','dur2 ','dur-cyc ',...
% 'dur-cum ','stiff1 ','stiff2 ','vpp1 ','vpp2 ','vps1 ','vps2'];
% 
% string3=['subject ','trial ','channel ','peak_x ','peak_y ','valley_x ','valley_y '];

z=1.5;
interval=num2str(z);            

%sample name from other code
%fs_1=strcat(path, '\',sess,'.',tri,'.stiff_S.',namevar1,'.txt'); all tri
%(trial # info) removed from file names; PvL 280110
fs_1=strcat(path, filesep, sess,'.stiff_S_10_90.',namevar1,'.txt');
fs_2=strcat(path, filesep, sess,'.stiff_S_10_90.',namevar2,'.txt');
fi_1=strcat(path, filesep, sess,'.stiff_I_10_90.',namevar1,'.txt');
fi_2=strcat(path, filesep, sess,'.stiff_I_10_90.',namevar2,'.txt');
fpv_1=strcat(path, filesep, sess,'.Peak_Valley_10_90.',namevar1,'.txt');
fpv_2=strcat(path, filesep, sess,'.Peak_Valley_10_90.',namevar2,'.txt');

fs_3=strcat(path, filesep, sess,'.stiff_S_10_90.',namevar3,'.txt');
fs_4=strcat(path, filesep, sess,'.stiff_S_10_90.',namevar4,'.txt');
fi_3=strcat(path, filesep, sess,'.stiff_I_10_90.',namevar3,'.txt');
fi_4=strcat(path, filesep, sess,'.stiff_I_10_90.',namevar4,'.txt');
fpv_3=strcat(path, filesep, sess,'.Peak_Valley_10_90.',namevar3,'.txt');
fpv_4=strcat(path, filesep, sess,'.Peak_Valley_10_90.',namevar4,'.txt');
    
if path~=0
    fid11=fopen(fs_1,'a'); % add data into the summary files
    disp(fid11)
    fprintf(fid11,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val1, val3, interval, Seg_cod1,sub,trialnum,namevar1,val00,val01,val02,val03,val04,val05,val06,val07,val08,val09,val010,val011,val012,val013,val014,val015,val016,val017,val018,val019,val020,val021,val0211,val0212,val0213,val0214,val022,val023,val024,val025,val000,val2000);
    fclose(fid11);

    fid12=fopen(fs_2,'a');
    fprintf(fid12,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val2, val3, interval, Seg_cod2,sub,trialnum,namevar2,val00_2,val01_2,val02_2,val03_2,val04_2,val05_2,val06_2,val07_2,val08_2,val09_2,val010_2,...
                val011_2,val012_2,val013_2, val014_2,val015_2,val016_2,val017_2,val018_2,val019_2,val020_2,val021_2,val0211_2, val0212_2,val0213_2,val0214_2,val022_2,val023_2, val024_2,val025_2,val000_2,val2000_2);
    fclose(fid12); 

    fid13=fopen(fs_3,'a');
    fprintf(fid13,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val5, val3, interval, Seg_cod3,sub,trialnum,namevar3,val00_3,val01_3,val02_3,val03_3,val04_3,val05_3,val06_3,val07_3,val08_3,val09_3,val010_3,...
                val011_3,val012_3,val013_3, val014_3,val015_3,val016_3,val017_3,val018_3,val019_3,val020_3,val021_3,val0211_3, val0212_3,val0213_3,val0214_3,val022_3,val023_3, val024_3,val025_3,val000_3,val2000_3);
    fclose(fid13); 

    fid14=fopen(fs_4,'a');
    fprintf(fid14,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',val6, val3, interval, Seg_cod4,sub,trialnum,namevar4,val00_4,val01_4,val02_4,val03_4,val04_4,val05_4,val06_4,val07_4,val08_4,val09_4,val010_4,...
                val011_4,val012_4,val013_4, val014_4,val015_4,val016_4,val017_4,val018_4,val019_4,val020_4,val021_4,val0211_4, val0212_4,val0213_4,val0214_4,val022_4,val023_4, val024_4,val025_4,val000_4,val2000_4);
    fclose(fid14); 

    
    %Find general estimate of dominant frequency
%     temppvl1=str2num(val012_4);
%     temppvl2=str2num(val012_3);
%     if (temppvl1 == temppvl2);
%         temppvl3=(temppvl1)*1000;
%         passbandfreq=1000/temppvl3;
%     elseif (temppvl2 > temppvl1)
%         temppvl3=(temppvl2)*1000;
%         passbandfreq=1000/temppvl3;
%     elseif (temppvl1 > temppvl2)
%         temppvl3=(temppvl1)*1000;
%         passbandfreq=1000/temppvl3;
%     end
    %passbandacous=round(passbandfreq);    
%     if passbandfreq < 0.5
%         passbandfreq=0.6;
%     end
    for nm=1:(length(ampl)) % add data into the individual files
        fid15=fopen(fi_1,'a');
        fprintf(fid15,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar1,ampl(nm),ampl2(nm),velo1(nm),velo2(nm),dur(nm),dur2(nm),dur3(nm),sumdur3(nm),stiffness(nm),stiff2(nm),cvalue(nm),cvalue2(nm),percent(nm),percent2(nm));
        fprintf(fid15,'\n');
        fclose(fid15);
    end
    for nm=1:(length(ampl_2))
        fid16=fopen(fi_2,'a');
        fprintf(fid16,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar2,ampl_2(nm),ampl2_2(nm),velo1_2(nm),velo2_2(nm),dur_2(nm),dur2_2(nm),dur3_2(nm),sumdur3_2(nm),stiffness_2(nm),stiff2_2(nm),cvalue_2(nm),cvalue2_2(nm),percent_2(nm),percent2_2(nm));
        fprintf(fid16,'\n');
        fclose(fid16);
    end
    for nm=1:(length(ampl_3))
        fid17=fopen(fi_3,'a');
        fprintf(fid17,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar3,ampl_3(nm),ampl2_3(nm),velo1_3(nm),velo2_3(nm),dur_3(nm),dur2_3(nm),dur3_3(nm),sumdur3_3(nm),stiffness_3(nm),stiff2_3(nm),cvalue_3(nm),cvalue2_3(nm),percent_3(nm),percent2_3(nm));
        fprintf(fid17,'\n');
        fclose(fid17);
    end 
    for nm=1:(length(ampl_4))
        fid18=fopen(fi_4,'a');
        fprintf(fid18,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f',sub,trialnum,namevar4,ampl_4(nm),ampl2_4(nm),velo1_4(nm),velo2_4(nm),dur_4(nm),dur2_4(nm),dur3_4(nm),sumdur3_4(nm),stiffness_4(nm),stiff2_4(nm),cvalue_4(nm),cvalue2_4(nm),percent_4(nm),percent2_4(nm));
        fprintf(fid18,'\n');
        fclose(fid18);
    end 
    %Add data into the peak_valley files
    index=1;
    fid19=fopen(fpv_1, 'a');
    if peaknumber1 == valleynumber1
        while index <= valleynumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
    elseif peaknumber1 > valleynumber1
        while index <= valleynumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
        fprintf(fid19, '%s %s %s %f %f -- --\n', sub, trialnum, namevar1, peakindex1(index), peak1(index));
    elseif peaknumber1 < valleynumber1
        while index <= peaknumber1
            fprintf(fid19, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar1, peakindex1(index), peak1(index), valleyindex1(index), valley1(index));   
            index=index+1;
        end
        fprintf(fid19, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar1, valleyindex1(index), valley1(index));  
    end
    fclose(fid19);  

    index=1;
    fid110=fopen(fpv_2, 'a');
    if peaknumber2 == valleynumber2
        while index <= valleynumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar2, peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
    elseif peaknumber2 > valleynumber2
        while index<=valleynumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar2,  peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
        fprintf(fid110, '%s %s %s %f %f -- --\n', sub, trialnum, namevar2, peakindex2(index), peak2(index));
    elseif peaknumber2 < valleynumber2
        while index <= peaknumber2
            fprintf(fid110, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar2, peakindex2(index), peak2(index), valleyindex2(index), valley2(index));   
            index=index+1;
        end
        fprintf(fid110, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar2, valleyindex2(index), valley2(index));  
    end
    fclose(fid110);

    index=1;
    fid111=fopen(fpv_3, 'a');
    if peaknumber3 == valleynumber3
        while index <= valleynumber3
        fprintf(fid111, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar3, peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
        index=index+1;
        end
    elseif peaknumber3 > valleynumber3
        while index<=valleynumber3
        fprintf(fid111, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar3,  peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
        index=index+1;
        end
        fprintf(fid111, '%s %s %s %f %f -- --\n', sub, trialnum, namevar3, peakindex3(index), peak3(index));
    elseif peaknumber3 < valleynumber3
        while index <= peaknumber3
            fprintf(fid111, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar3, peakindex3(index), peak3(index), valleyindex3(index), valley3(index));   
            index=index+1;
        end
        fprintf(fid111, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar3, valleyindex3(index), valley3(index));  
    end
    fclose(fid111);

    index=1;
    fid112=fopen(fpv_4, 'a');
    if peaknumber4 == valleynumber4
        while index <= valleynumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar4, peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
    elseif peaknumber4 > valleynumber4
        while index<=valleynumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n',sub, trialnum, namevar4,  peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
        fprintf(fid112, '%s %s %s %f %f -- --\n', sub, trialnum, namevar4, peakindex4(index), peak4(index));
    elseif peaknumber4 < valleynumber4
        while index <= peaknumber4
            fprintf(fid112, '%s %s %s %f %f %f %f\n', sub, trialnum, namevar4, peakindex4(index), peak4(index), valleyindex4(index), valley4(index));   
            index=index+1;
        end
        fprintf(fid112, '%s %s %s -- -- %f %f \n', sub, trialnum, namevar4, valleyindex4(index), valley4(index));  
    end
    fclose(fid112);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VIII RELATIVE PHASE                                                   %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1. Inform user that the next step is crosspec analysis 



%% 1.2 PREPARE MAIN VARIABLES

ratemo=rate;
winsize=4092/4;
winover=2048/4;
tolval=0.98;


%% 2 CROSSSPECTRUM ANALYSIS OCCURS HERE for Signal 3, 4

% 2.1 cuts on signal -> first signal treatment ----------------------------

tempcros1=length(signal3);
tempcros2=length(signal4);
sigcros1=signal3(ratemo:tempcros1-ratemo);
sigcros2=signal4(ratemo:tempcros2-ratemo);
sigcros1(1:25)=0.0;
sigcros2(1:25)=0.0;
sizetemp1=length(sigcros1);
sizetemp2=length(sigcros2);
sigcros1(sizetemp1-25:sizetemp1)=0.0;
sigcros2(sizetemp2-25:sizetemp2)=0.0;

% 2.2 Increase resolution analysis by copying signals ---------------------

% n is the number of copies (update this part of code in 27/07/2010)
% now if you want to change the num of copies change in this variable
% By Rafael Henriques 

n=10;
lenvar1=length(sigcros1);
kinsig1n=zeros(1,lenvar1*n);

for i=0:n
   kinsig1n(i*lenvar1+1:(i+1)*lenvar1)=sigcros1;
end

lenvar2=length(sigcros2);
kinsig2n=zeros(1,lenvar2*n);

for i=0:n
   kinsig2n(i*lenvar2+1:(i+1)*lenvar2)=sigcros2;
end

% 2.3 Spectrum calculation ------------------------------------------------

    %old function of spectrum
    %[Pp1n,Ff1] = SPECTRUM(kinsig1n,winsize,winover,[],ratemo);
    %[Pp2n,Ff2] = SPECTRUM(kinsig2n,winsize,winover,[],ratemo);
    %Pp1ns=Pp1n(:,1);
    %Pp2ns=Pp2n(:,1);

    %figure(2000) figure to comper the two versions
    %a1=subplot(2,2,1); plot(a1,Ff1,Pp1n); set(a1,'XLim',[0 6]),
    %a2=subplot(2,2,2); plot(a2,Ff2,Pp2n); set(a2,'XLim',[0 6]),
    %[Pp1nN,Ff1N] = pwelch(kinsig1n,winsize,winover,[],ratemo);
    %[Pp2nN,Ff2N] = pwelch(kinsig2n,winsize,winover,[],ratemo);
    %a3=subplot(2,2,3); plot(a3,Ff1N,Pp1nN), set(a3,'XLim',[0 6]),
    %a4=subplot(2,2,4); plot(a4,Ff2N,Pp2nN), set(a4,'XLim',[0 6]),
    
[Pp1n,Ff1] = pwelch(kinsig1n,winsize,winover,[],ratemo);
[Pp2n,Ff2] = pwelch(kinsig2n,winsize,winover,[],ratemo);


% 2.4 find peaks index, and the maximun frequency/amplitude frequency of 
%the picks  ------------------------------------------------------------


%[maxPp1n]=max(Pp1ns);
[nopeak1,peaktemp1]=peakfind_rh(Pp1n,tolval);
%[minPp1n]=min(Pp1ns);

maxfreq1=Ff1(peaktemp1);
maxPp1pow=10*log10(Pp1n(peaktemp1));

%[maxPp2n]=max(Pp2ns);
[nopeak2,peaktemp2]=peakfind_rh(Pp2n,tolval);
%minPp2n=min(Pp2ns);

maxfreq2=Ff2(peaktemp2);
maxPp2pow=10*log10(Pp2n(peaktemp2));

%('Peak frequencies signal 1 and signal 2 and power in dB:');
%maxfreq1;
%maxfreq2;
%maxPp1pow;
%maxPp2pow;
[maxpow1,locmaxpow1]=max(maxPp1pow); % signal3
passbandfreq1=maxfreq1(locmaxpow1);
[maxpow2,locmaxpow2]=max(maxPp2pow); % signal4
passbandfreq2=maxfreq2(locmaxpow2);
%passbandfreq_dur=passbandacous;

% 2.5 calculate the midle frequency pass band first estimative ------------

if passbandfreq1 == passbandfreq2
    passbandfreq=passbandfreq1;
elseif (passbandfreq1 < passbandfreq2) && (locmaxpow2 ~= 1)
    passbandfreq=passbandfreq1;
else
    passbandfreq=passbandfreq2;
end
% passbanddif=abs(passbandfreq_dur-passbandfreq);


% 2.6 calculation the cross coherence of 2 power of 2 sinals --------------


Cwinsize=4092/4;
fsample=ratemo;
[Cxy, F] = mscohere(kinsig1n, kinsig2n, Cwinsize, [], [], fsample);

%[Cxy,F] = COHERE(kinsig1n,kinsig2n,4000,ratemo,2000); old cohere function


% 2.7 Choose dominant peaks from signal4 signal

%maxCxy=max(Cxy);
%minCxy=min(Cxy);

coh_peak=Cxy(peaktemp2); % coherence values of peaks
coh_peakloc=F(peaktemp2); % positions of peaks(the same of maxfreq2)

[max_coh,loc_maxcoh]=max(coh_peak); %   maximum coherence of peaks
max_coh_freq=coh_peakloc(loc_maxcoh); % maximum coherence frequency
coh_domfreq2=coh_peak(locmaxpow2); %    coherence of maximum peak
diff_in_coh=abs(max_coh-coh_domfreq2);

if (max_coh_freq ~= passbandfreq)&& (diff_in_coh > .5)
    passbandfreq=max_coh_freq;
end

% % 2.8 Calculate the mean and std of peaks coherence
% 
% nopeakscoh=length(coh_peak);
% if nopeakscoh == 1
%    meancoh=coh_peak;
%    sdcoh=0.0;
% else
% 	meancoh=mean(coh_peak);
%    sdcoh=std(coh_peak);
% end
% 
% % 2.9 Pass band frenquencies
% 
hifreq=passbandfreq+0.25;
lofreq=passbandfreq-0.25;
%domfreq=passbandfreq;


%% 3 CROSSSPECTRUM ANALYSIS OCCURS HERE for Signal 1, 2

% 3.1
tempcross1=length(signal1);
tempcross2=length(signal2);
sigcross1=signal1(ratemo:tempcross1-ratemo);
sigcross2=signal2(ratemo:tempcross2-ratemo);
sigcross1(1:25)=0.0;% create fixed zero onset & offset
sigcross2(1:25)=0.0;
sizetempp1=length(sigcross1);
sizetempp2=length(sigcross2);
sigcross1(sizetempp1-25:sizetempp1)=0.0;
sigcross2(sizetempp2-25:sizetempp2)=0.0;

% 3.2 increase resolution analysis by copying signals

n=10;
lenvarr1=length(sigcross1);
kinsig1nn=zeros(1,lenvarr1*n);

for i=0:n
   kinsig1nn(i*lenvarr1+1:(i+1)*lenvarr1)=sigcross1;
end

lenvarr2=length(sigcross2);
kinsig2nn=zeros(1,lenvarr2*n);

for i=0:n
   kinsig2nn(i*lenvarr2+1:(i+1)*lenvarr2)=sigcross2;
end

% 3.3 Spectrum calculation ------------------------------------------------

[Pp1nn,Fff1] = pwelch(kinsig1nn,winsize,winover,[],ratemo);
[Pp2nn,Fff2] = pwelch(kinsig2nn,winsize,winover,[],ratemo);

%Pp1nns=Pp1nn(:,1);
%Pp2nns=Pp2nn(:,1);

% 3.4 find peaks index, and the maximun frequency/amplitude frequency of 
%the picks  ------------------------------------------------------------


%[maxPp1nn]=max(Pp1nns);
[nopeakk1,peaktempp1]=peakfind_rh(Pp1nn,tolval);
%[minPp1nn]=min(Pp1nns);

maxfreqq1=Ff1(peaktempp1);
maxPp1poww=10*log10(Pp1nn(peaktempp1));

%[maxPp2nn]=max(Pp2nns);
[nopeakk2,peaktempp2]=peakfind_rh(Pp2nn,tolval);
%minPp2nn=min(Pp2nns);

maxfreqq2=Ff2(peaktempp2);
maxPp2poww=10*log10(Pp2nn(peaktempp2));

%('Peak frequencies signal 1 and signal 2 and power in dB:');
%maxfreq1;
%maxfreq2;
%maxPp1pow;
%maxPp2pow;
[maxpoww1,locmaxpoww1]=max(maxPp1poww); % signal 1 'example UL'
passbandfreqq1=maxfreqq1(locmaxpoww1);
[maxpoww2,locmaxpoww2]=max(maxPp2poww); % signal 2 'example LL'
passbandfreqq2=maxfreqq2(locmaxpoww2);
%passbandfreq_durr=passbandacous;

% 3.5 calculate the midle frequency pass band first estimative ------------

if passbandfreqq1 == passbandfreqq2
    passbandfreqq=passbandfreqq1;
elseif (passbandfreqq1 < passbandfreqq2) && (locmaxpoww2 ~= 1)
    passbandfreqq=passbandfreqq1;
else
    passbandfreqq=passbandfreqq2;
end

%passbanddiff=abs(passbandfreq_durr-passbandfreqq)

% 3.6 calculation the cross coherence of 2 power of 2 sinals --------------
%

Cwinsize=4092/4;
fsample=ratemo;
[Cxyy, Ff] = mscohere(kinsig1nn, kinsig2nn, Cwinsize, [], [], fsample);
%[Cxyy,Ff] = COHERE(kinsig1nn,kinsig2nn,4000,ratemo,2000);

% 3.7 choose dominant peaks from 2nd signal

%maxCxyy=max(Cxyy);
%minCxyy=min(Cxyy);

coh_peakk=Cxyy(peaktempp2);% coherence values of peaks
coh_peaklocc=Ff(peaktempp2);% positions of peaks(the same of maxfreq2)

[max_cohh,loc_maxcohh]=max(coh_peakk);%   maximum coherence of peaks
max_coh_freqq=coh_peaklocc(loc_maxcohh);% maximum coherence frequency
coh_domfreqq2=coh_peakk(locmaxpoww2);%    coherence of maximum peak
diff_in_cohh=abs(max_cohh-coh_domfreqq2);

if (max_coh_freqq ~= passbandfreqq)&& (diff_in_cohh > .5) 
    passbandfreqq=max_coh_freqq;
end

% % 3.8 Calculate the mean and std of peaks coherence
% 
% nopeakscohh=length(coh_peakk);
% if nopeakscohh == 1
%    meancohh=coh_peakk;
%    sdcohh=0.0;
% else
% 	meancohh=mean(coh_peakk);
%    sdcohh=std(coh_peakk);
% end
% 
% % 3.9 Pass band frenquencies
% 
hifreqq=passbandfreqq+0.25;
lofreqq=passbandfreqq-0.25;
% domfreqq=passbandfreqq;



%%   4            Frequency band selection GUI                           


[lofreqq,hifreqq,lofreq,hifreq]=frebandselection(Fff1,Pp1nn,Fff2,Pp2nn,...
    Ff1,Pp1n,Ff2,Pp2n, Ff,Cxyy,F,Cxy,...
    namevar1,namevar2,namevar3, namevar4,lofreqq,hifreqq,lofreq, hifreq);


%%                 5 relative phase calculation


% .1 PREPARE FILE OUTPUT

fname= strcat(path, filesep, sess,'.phi_sum.txt');
ifname= strcat(path, filesep, sess,'.phi_ind.txt');

phiname=[path,filesep, sess,'.RELPHASE.',namevar1,'.',namevar2,'.txt'];
phiname1=[path,filesep, sess,'.RELPHASE.',namevar3,'.',namevar4,'.txt'];


% .2 prepare coherence variables (mean & std)
interval=0.2;

nopeakscohh=length(coh_peakk); % signal 1 & 2
meancohh=mean(coh_peakk);
sdcohh=std(coh_peakk);
domfreqq=(hifreqq+lofreqq)/2;
 
nopeakscoh=length(coh_peak); % signal 3 & 4
meancoh=mean(coh_peak);
sdcoh=std(coh_peak);
domfreq=(hifreq+lofreq)/2;



%  .3 Now continue with filtering

%signal1=detrend(signal1);
signal1=filter_array_rhv2(signal1,rate,hifreqq,lofreqq);
%signal2=detrend(signal2);
signal2=filter_array_rhv2(signal2,rate,hifreqq,lofreqq);
%signal3=detrend(signal3);
signal3=filter_array_rhv2(signal3,rate,hifreq,lofreq);
%signal4=detrend(signal4);
signal4=filter_array_rhv2(signal4,rate,hifreq,lofreq);
%use starttime and stoptime to trim signals

% .4 relative phase calculation and the parameters, display the values in
% a first figure and save them in a file

[relphase_nozero,temp_aver_phi1,temp_RMS1,temp_sd_phi1,temp_num_sample1...
    temp_cv_phi1]=newph_dif6_r2_rh(signal1,signal2,interval,rate,2,...
    fname,sub,trial,ifname,namevar1,...
    namevar2,domfreqq,lofreqq,hifreqq,starttime,stoptime,pulstime,...
    meancohh,sdcohh,nopeakscohh,namevar1,namevar2);

[relphase_nozero_1,temp_aver_phi2,temp_RMS2,temp_sd_phi2,temp_num_sample2...
    temp_cv_phi2]=newph_dif6_r2_rh(signal3,signal4,interval,rate,2,...
    fname,sub,trial,...
    ifname,namevar3,namevar4,domfreq,lofreq,hifreq,starttime,stoptime,...
    pulstime,meancoh,sdcoh,nopeakscoh,namevar3,namevar4);


% .5 temporal values of two pairm signals displayed in a figure 4/08/10 rh

%% figure 2 %%

hfig=figure;

scnsize=get(0, 'ScreenSize');

set(hfig,'color',[0.8 0.8 0.8],'position',...
    [scnsize(1),0.05*scnsize(4),scnsize(3),0.87*scnsize(4)],'name',...
    'temporal parameters of relative phase')
set(hfig,'Units','Normalized')

firstPair = uipanel('Title',['First Pair (' namevar1 ' / ' namevar2 ')'],...
    'FontSize',12,'BackgroundColor',[0.93 0.93 0.96],'Units',...
    'Normalized','Position',[.01 .01 .47 .99],'HighlightColor','b',...
    'ForegroundColor','b');

secondPair = uipanel('Title',['Second Pair (' namevar3 ' / ' namevar4 ')'],...
    'FontSize',12,'BackgroundColor',[0.93 0.93 0.96],'Units',...
    'Normalized','Position',[.51 .01 .47 .99],'HighlightColor','b',...
    'ForegroundColor','b');


newrph1=relphase_nozero*pi/180;
Nsegments=floor(length(newrph1)/rate);
Nseg=1:Nsegments;

axes('Parent', firstPair,'position',[0.1 0.81 0.80 0.15]);
ob=plot(Nseg,temp_aver_phi1,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('Average');

axes('Parent', firstPair,'position',[0.1 0.61 0.80 0.15]);
ob=plot(Nseg,temp_RMS1,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('R');

axes('Parent', firstPair,'position',[0.1 0.41 0.80 0.15]);
ob=plot(Nseg,temp_sd_phi1,'bo-');
set(ob,'LineWidth',2)
xlabel ('Number of segments');
ylabel('SD');

axes('Parent', firstPair,'position',[0.1 0.21 0.80 0.15]);
ob=plot(Nseg,temp_cv_phi1,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('CV-PHI');

temp_num_sample1=temp_num_sample1*ones(1,Nsegments);
Datatable=[temp_aver_phi1;temp_RMS1;temp_sd_phi1;temp_num_sample1];


uitable('Parent',hfig,'Units','Normalized',...
'position',[0.1 0.03 0.80 0.13],'Data',Datatable,...
'RowName',{'average of relative phase:','R of relative phase:',...
'SD of relative phase:','Number of samples:'});

newrph2=relphase_nozero_1*pi/180;
Nsegments2=floor(length(newrph2)/rate);
Nseg2=1:Nsegments2;

axes('Parent', secondPair,'position',[0.1 0.81 0.80 0.15]);
ob=plot(Nseg2,temp_aver_phi2,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('Average');

axes('Parent', secondPair,'position',[0.1 0.61 0.80 0.15]);
ob=plot(Nseg2,temp_RMS2,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('R');

axes('Parent', secondPair,'position',[0.1 0.41 0.80 0.15]);
ob=plot(Nseg2,temp_sd_phi2,'bo-');
set(ob,'LineWidth',2)
xlabel ('Number of segments');
ylabel('SD');

axes('Parent', secondPair,'position',[0.1 0.21 0.80 0.15]);
ob=plot(Nseg2,temp_cv_phi2,'bo-');
set(ob,'LineWidth',2)
xlabel('Number of segments');
ylabel('CV-PHI');

temp_num_sample2=temp_num_sample2*ones(1,Nsegments2);
Datatable2=[temp_aver_phi2;temp_RMS2;temp_sd_phi2;temp_num_sample2];

uitable('Parent',hfig,'Units','Normalized',...
'position',[0.1 0.03 0.80 0.13],'Data',Datatable2,...
'RowName',{'average of relative phase:','R of relative phase:',...
'SD of relative phase:','Number of samples:'});

% .6 WRITE DATA
%Signal 1, 2
fid20=fopen(phiname,'w');

fprintf(fid20,'%f\n',relphase_nozero);

fclose(fid20);

%Signal 3, 4
fid21=fopen(phiname1,'w');
fprintf(fid21,'%f\n',relphase_nozero_1);
fclose(fid21);


set(0,'ShowHiddenHandles', 'on');
delete (findobj('Tag','AUDIO'));
set(0,'ShowHiddenHandles', 'off');


% gui_hurst(relphase_nozero_filt_rad, relphase_nozero_1_filt_rad, afgeleid(relphase_nozero_filt_rad,rate),...
%     afgeleid(relphase_nozero_1_filt_rad,rate),namevar1,namevar2,namevar3,namevar4,respath,sess,tri,sub);
end
