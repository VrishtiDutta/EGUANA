function crosspec_analysis_2pair(signal1,signal2,signal3,signal4,rate,...
namevar1,namevar2,namevar3,namevar4,path,sess,lastname,trial,...
pulstime,starttime,stoptime)

%% 1. Inform user that the next step is crosspec analysis 



%% 1.2 inicial conditions


%PREPARE MAIN VARIABLES

%passbandfreq;
ratemo=rate;
winsize=4092;
winover=2048;
tolval=0.98;


%% 2 CROSSSPECTRUM ANALYSIS OCCURS HERE for Signal 3, 4

% 2.1 cuts on signal -> first signal treatment ----------------------------

tempcros1=length(signal3);
tempcros2=length(signal4);
sigcros1=signal3(200:tempcros1-200);
sigcros2=signal4(200:tempcros2-200);
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


Cwinsize=4092;
fsample=200;
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
sigcross1=signal1(200:tempcross1-200);
sigcross2=signal2(200:tempcross2-200);
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

Cwinsize=4092;
fsample=200;
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

%% 4 Open GUI for the rest of calculations

gui_phase_frequency_band(Fff1,Pp1nn,Fff2,Pp2nn,namevar1,namevar2,...
                         lofreqq,hifreqq,Cxyy, Ff,...
                         Ff1,Pp1n,Ff2,Pp2n,namevar3, namevar4,...
                         lofreq, hifreq, Cxy, F,...
                         path,sess,lastname,trial,...
                         pulstime,starttime,stoptime,...
                         signal1,signal2,signal3,signal4,...
                         rate,coh_peakk,coh_peak)

% %%  PREPARE FILE OUTPUT
% 
% % function phase_part2(signal1,signal2,signal3,signal4,...
% %  lofreqq,hifreqq,lofreq,hifreq,...
% %  rate,pulstime,path,sess,...
% %  namevar1,namevar2,namevar3,...
% %  namevar4,lastname,trial,starttime,...
% %  stoptime,coh_peakk,coh_peak)
% 
% % .1 PREPARE FILE OUTPUT
% 
% fname= strcat(path, '\',sess,'.phi_sum.txt');
% ifname= strcat(path,'\',sess,'.phi_ind.txt');
% 
% phiname=[path,'\',sess,'.RELPHASE.',namevar1,'.',namevar2,'.txt'];
% phiname1=[path,'\',sess,'.RELPHASE.',namevar3,'.',namevar4,'.txt'];
% 
% 
% % .2 prepare relative puls and coherence variables
% interval=0.2;
% pulslocs=pulstime;
% 
% if (pulslocs~=0)
%       relpulsloc=pulslocs-starttime;
%       relpulslocs=round(relpulsloc*rate);
% else
%       relpulsloc=1.0;
%       relpulslocs=round(relpulsloc*rate);
% end
% 
% %
% 
% nopeakscohh=length(coh_peakk); % signal 1 & 2
% meancohh=mean(coh_peakk);
% sdcohh=std(coh_peakk);
% domfreqq=(hifreqq+lofreqq)/2;
%  
% nopeakscoh=length(coh_peak); % signal 3 & 4
% meancoh=mean(coh_peak);
% sdcoh=std(coh_peak);
% domfreq=(hifreq+lofreq)/2;
% 
% 
% 
% %  .3 Now continue with filtering
% %signal1=detrend(signal1);
% signal1=filter_array_rh(signal1,rate,hifreqq,lofreqq);
% %signal2=detrend(signal2);
% signal2=filter_array_rh(signal2,rate,hifreqq,lofreqq);
% %signal3=detrend(signal3);
% signal3=filter_array_rh(signal3,rate,hifreq,lofreq);
% %signal4=detrend(signal4);
% signal4=filter_array_rh(signal4,rate,hifreq,lofreq);
% %use starttime and stoptime to trim signals
% 
% 
% [relphase_zero,relphase_nozero,pvl1normpos1,pvl1normpos2,pvl1normvel1,pvl1normvel2,pvl1phase1,pvl1phase2,pvl1relphase]=newph_dif6_r2(signal1,0,signal2,0,interval,rate,2,fname,lastname,trial,ifname,namevar1,namevar2,domfreqq,lofreqq,hifreqq,starttime,stoptime,pulstime,meancohh,sdcohh,nopeakscohh);
% [relphase_zero_1,relphase_nozero_1,pvl1normpos3,pvl1normpos4,pvl1normvel3,pvl1normvel4,pvl1phase3,pvl1phase4,pvl1relphase_1]=newph_dif6_r2(signal3,0,signal4,0,interval,rate,2,fname,lastname,trial,ifname,namevar3,namevar4,domfreq,lofreq,hifreq,starttime,stoptime,pulstime,meancoh,sdcoh,nopeakscoh);
% 
% size(pvl1phase1)
% figure(100);
% plot(pvl1phase1);
% 
% rstr = num2str(relphase_nozero_1);
% rstr0 = num2str(relphase_nozero);
% 
% %WRITE DATA
% %Signal 1, 2
% fid20=fopen(phiname,'w');
% 
% fprintf(fid20,'%f\n',relphase_nozero);
% 
% fclose(fid20);
% 
% %Signal 3, 4
% fid21=fopen(phiname1,'w');
% fprintf(fid21,'%f\n',relphase_nozero_1);
% fclose(fid21);
% 
% ntem=length(pvl1normpos1);
% item=[1:ntem];
% ttem=item*(1.0/rate);
% 
% pvl1relphase_n=abs(180-pvl1relphase); 
% pvl1relphase_n_1=abs(180-pvl1relphase_1);
% %ntem2=length(roundphi_nozero);
% %item2=[1:ntem2];
% %ttem2=item2*(1.0/rate);
% 
% figure(35);
% whitebg(35,'white');
% subplot(7,1,1);
% plot(ttem,pvl1normpos1);
% subplot(7,1,2);
% plot(ttem,pvl1normpos2);
% subplot(7,1,3);
% plot(ttem,pvl1normvel1);
% subplot(7,1,4);
% plot(ttem,pvl1normvel2);
% subplot(7,1,5);
% plot(ttem,pvl1phase1);
% subplot(7,1,6);
% plot(ttem,pvl1phase2);
% subplot(7,1,7);
% 
% 
% if relpulslocs <=0
%     relpulslocs = 1;
%     errordlg('Relpulslocs <= 0');
% end
% plot(ttem,pvl1relphase,'b',relpulsloc,pvl1relphase(relpulslocs),'ro');
% YLABEL('[deg]');
% 
% figure(36);
% whitebg(36,'white');
% subplot(7,1,1);
% plot(ttem,pvl1normpos3);
% subplot(7,1,2);
% plot(ttem,pvl1normpos4);
% subplot(7,1,3);
% plot(ttem,pvl1normvel3);
% subplot(7,1,4);
% plot(ttem,pvl1normvel4);
% subplot(7,1,5);
% plot(ttem,pvl1phase3);
% subplot(7,1,6);
% plot(ttem,pvl1phase4);
% subplot(7,1,7);
% 
% plot(ttem,pvl1relphase_1,'b',relpulsloc,pvl1relphase_1(relpulslocs),'ro');
% %axis([min(ttem) max(ttem) 0 360]);
% YLABEL('[deg]');
% %figure(51);
% %whitebg(51,'white');
% %plot(ttem2,roundphi_nozero,'r');
% %YLABEL('[rounds]');
% 
% %close figure 1 figure 2 figure 3 figure 4 figure 9 figure 10 figure 19 figure 20...
%  %   figure 35 figure 36 figure 50 figure 90 figure 91 figure 100;
% 
% 
% set(0,'ShowHiddenHandles', 'on');
% delete (findobj('Tag','AUDIO'));
% set(0,'ShowHiddenHandles', 'off');
% 
% 
% rate = 200; % for both 2D and 3D this is fine as 2D was downsampled
% %relphase_nozero_1_filt = filter_array_rh(relphase_nozero_1,rate, 10.0, 0.1);
% %relphase_nozero_filt = filter_array_rh(relphase_nozero,rate, 10.0, 0.1);
% relphase_nozero_1_filt = relphase_nozero_1;
% relphase_nozero_filt = relphase_nozero;
% % convert to radians
% temp1=relphase_nozero_1_filt*(pi/180);
% relphase_nozero_1_filt_rad=unwrap(temp1);
% temp11=relphase_nozero_filt*(pi/180);
% relphase_nozero_filt_rad=unwrap(temp11);
% %relphase_nozero_1_filt_rad=filter_array_rh(relphase_nozero_1_filt_rad,rate,6.0,0.1);
% %relphase_nozero_filt_rad=filter_array_rh(relphase_nozero_filt_rad,rate,6.0,0.1);
% %
% temppha1=relphase_nozero_filt_rad;%*(pi/180);
% temppha2=relphase_nozero_1_filt_rad;%*(pi/180);
% timevar1=(1:length(temppha1))/rate;
% timevar2=(1:length(temppha2))/rate;
% timevar3=(1:length(relphase_nozero_filt))/rate;
% timevar4=(1:length(relphase_nozero_1_filt))/rate;
% %
% figure(62);
% subplot(3,1,1);
% plot(timevar1,temppha1,'b',timevar2,temppha2,'r');
% subplot(3,1,2)
% plot(timevar3,relphase_nozero_filt,'b');
% subplot(3,1,3)
% plot(timevar4,relphase_nozero_1_filt,'r');
% 
% 
% 
% % gui_hurst(relphase_nozero_filt_rad, relphase_nozero_1_filt_rad, afgeleid(relphase_nozero_filt_rad,rate),...
% %     afgeleid(relphase_nozero_1_filt_rad,rate),namevar1,namevar2,namevar3,namevar4,respath,sess,tri,sub);
% end