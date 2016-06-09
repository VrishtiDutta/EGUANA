function [RF,nfirst,nlast]=relativephase1pair(signal1,signal2,namevar1,namevar2)
%% PREPARE MAIN VARIABLES

rate=200;
ratemo=rate;
winsize=4092;
winover=2048;
tolval=0.98;
interval=0.2;

% 1 CROSSSPECTRUM ANALYSIS OCCURS HERE for Signal 3, 4

% 1.1 cuts on signal -> first signal treatment ----------------------------

tempcros1=length(signal1);
tempcros2=length(signal2);
sigcros1=signal1(200:tempcros1-200);
sigcros2=signal2(200:tempcros2-200);
sigcros1(1:25)=0.0;
sigcros2(1:25)=0.0;
sizetemp1=length(sigcros1);
sizetemp2=length(sigcros2);
sigcros1(sizetemp1-25:sizetemp1)=0.0;
sigcros2(sizetemp2-25:sizetemp2)=0.0;

% 1.2 Increase resolution analysis by copying signals ---------------------

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

% 1.3 Spectrum calculation ------------------------------------------------

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


% 1.4 find peaks index, and the maximun frequency/amplitude frequency of 
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

% 1.5 calculate the midle frequency pass band first estimative ------------

if passbandfreq1 == passbandfreq2
    passbandfreq=passbandfreq1;
elseif (passbandfreq1 < passbandfreq2) && (locmaxpow2 ~= 1)
    passbandfreq=passbandfreq1;
else
    passbandfreq=passbandfreq2;
end
% passbanddif=abs(passbandfreq_dur-passbandfreq);


% 1.6 calculation the cross coherence of 2 power of 2 sinals --------------


Cwinsize=4092;
fsample=200;
[Cxy, F] = mscohere(kinsig1n, kinsig2n, Cwinsize, [], [], fsample);

%[Cxy,F] = COHERE(kinsig1n,kinsig2n,4000,ratemo,2000); old cohere function


% 1.7 Choose dominant peaks from signal4 signal

coh_peak=Cxy(peaktemp2); % coherence values of peaks
coh_peakloc=F(peaktemp2); % positions of peaks(the same of maxfreq2)

[max_coh,loc_maxcoh]=max(coh_peak); %   maximum coherence of peaks
max_coh_freq=coh_peakloc(loc_maxcoh); % maximum coherence frequency
coh_domfreq2=coh_peak(locmaxpow2); %    coherence of maximum peak
diff_in_coh=abs(max_coh-coh_domfreq2);

if (max_coh_freq ~= passbandfreq)&& (diff_in_coh > .5)
    passbandfreq=max_coh_freq;
end

%
hifreq=passbandfreq+0.25;
lofreq=passbandfreq-0.25;


%%   2           Frequency band selection GUI                           


[lofreq,hifreq]=frebandselection1pair(Ff1,Pp1n,Ff2,Pp2n,...
     F,Cxy,namevar1,namevar2,lofreq, hifreq);
 
 %% %  3 Now continue with filtering
 
 signal1=filter_array_rhv2(signal1,rate,hifreq,lofreq);
 signal2=filter_array_rhv2(signal2,rate,hifreq,lofreq);
 
 
 [zfirst1,zlast1,t1,nz1,zz1,s1,v1,ph1]=phaseforrelative_rh(signal1,interval,rate);
 
 [zfirst2,zlast2,t2,nz2,zz2,s2,v2,ph2]=phaseforrelative_rh(signal2,interval,rate);
 
 
 degtorad=pi/180;% convert to radians
 radtodeg=1/degtorad;
 ph1=ph1*degtorad;
 ph2=ph2*degtorad;
 
 
 % determine the range of the array to do subtraction
 if (zfirst1<zfirst2)
     nfirst=zfirst2;
 else
     nfirst=zfirst1;
 end
 
 if (zlast1>zlast2)
     nlast=zlast2;
 else
     nlast=zlast1;
 end
 
 %% determine phase difference
 nmax=length(signal1);
 rph=zeros(1,nmax);
 
 for i=nfirst:nlast,
     rph(i)=ph1(i)-ph2(i);
     dx=cos(rph(i));
     dy=sin(rph(i));
     if (dx==0)
         if (dy>0)
             rph(i)=pi/2;
         end
         if (dy<0)
             rph(i)=pi+pi/2;
         end
     end
     if (dx>0)
         rph(i)=atan(dy/dx);
     end
     if (dx<0)
         rph(i)=pi+atan(dy/dx);
     end
     if(rph(i)<0)
         rph(i)=2*pi-abs(rph(i));
     end
 end
 
 rph_nozero=rph(nfirst:nlast);
        

       
rph_nozero=radtodeg*(rph_nozero)'; % rel phase without zeros          
       
%% unwrap relative phase 
        
%rate = 200;% for both 2D and 3D this is fine as 2D was downsampled
temp1=rph_nozero*degtorad;% convert to radians
relphase_nozero_unrap=unwrap(temp1);
rph_nz_unr_deg=relphase_nozero_unrap*radtodeg;
RF=rph_nz_unr_deg*degtorad;   

end
    


