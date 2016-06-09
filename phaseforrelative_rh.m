
function [zfirst,zlast,t,nz,zz,position,v,phase]=...
    phaseforrelative_rh(x,interval,rate)


% constants
degtorad=pi/180;
radtodeg=1/degtorad;
%filtfreq_low=6;
%filtfreq_high=0.5;

% sampling rate of signals
sec=1.0/rate;

% check length of signal arrays
n=length(x);
i=1:n;
t=i*sec;
%s=1:n;

% subtract the jaw movement
%if (no5~=0)
%   x=x-no5;
%end
%x=detrend(x);     


% filter signal
%s=filter5_array(x,rate,filtfreq_low,filtfreq_high);
s=x;
% find cycles, i.e., zero crossings in position-time signal (z)
%z=[1:10000];
[z,zneg,zpos,nz,zfirst,zlast]=zero_crossings_rh(s,interval,rate);
if (nz<3)  %do nothing if cycles are less than 3.
   zfirst=0;
   zlast=0;
   t=0;
   nz=0;
   zz=0;
   v=0;
   position=0;
   phase=0;
   %qstring='The signal has less than 2 cycles. No result to be presented.';
   %		reply=questdlg(qstring,'ERROR','OK','OK');
   
   
   return
else
    
    % interpolate to find exact time indices of zero crossings (zz)
zz=zeros(1,nz);    
for j = 1:nz,
   xx(1)=s(zneg(j));
   xx(2)=s(zpos(j));
   yy=0:1;
  f=interp1(xx,yy,0,'spline');
   zz(j)=zneg(j)+f;
   zz(j)=zz(j)*sec;
end;

% determine speed ('afgeleid' is Dutch for determine derivative)
[v]=AFGELEID(s,rate);
v=v';

% filter signal
%v=filter5_array(v,rate,filtfreq_low,filtfreq_high);


% force amplitudes in s per half a cycle between -1 & 1
for j=0:nz,
    if (j==0)
        ib=1;
        ie=z(1)-1;
    end
    if (j>0) && (j<nz)
        ib=z(j);
        ie=z(j+1)-1;
    end
    if (j==nz)
        ib=z(j);
        ie=n;
    end
    ns=ie-ib+1;
    if (ns==0)
        ie=ib;
        ns=1;
    end
    for ifreq=ib:ie
        s(ifreq)=s(ifreq)*2*pi/(ns/rate);
    end
    
    c(1:ns)=s(ib:ie);
    cmax=c(1);
    cmin=cmax;
    for k=1:ns,
        if(c(k)<=cmin)
            cmin=c(k);
        end
        if(c(k)>=cmax)
            cmax=c(k);
        end
    end
    for k=ib:ie,
        if (s(k)>=0)
            if(cmax~=0)
                s(k)=s(k)/cmax;
            end
        else
            if (cmin~=0)
                s(k)=s(k)/abs(cmin);
            end
            if (round(abs(cmin))==0)
                s(k)=0;
            end
        end
    end
end
% neutralize irrelevant parts of signal;
for j=1:(z(1)),
   s(j)=0;
end
for j=(z(nz)):n,
   s(j)=0;
end

% neutralize irrelevant parts of signal (velocity);
for j=1:(z(1)-1),
   v(j)=0;
end
for j=(z(nz)+1):n,
   v(j)=0;
end

% force amplitudes in v per half a cycle between -1 & 1
for j=0:nz,
    if (j==0)
        ib=1;
        ie=z(1);
    end
    if (j>0) && (j<nz)
        ib=z(j);
        ie=z(j+1);
    end
    if (j==nz)
        ib=z(j);
        ie=n;
    end
    ns=ie-ib+1;
    if (ns==0)
        ie=ib;
        ns=1;
    end;
    
    c(1:ns)=v(ib:ie);
    cmin=c(1);
    cmax1=cmin;
    cmax2=c(ns);
    for k=1:ns,
        if(c(k)<=cmin)
            cmin=c(k);
        end
        if(c(k)>=cmax1)&&(k<=round(ns/2))
            cmax1=c(k);
        end
        if(c(k)>=cmax2)&&(k>round(ns/2))
            cmax2=c(k);
        end
    end
    for k=ib:(ie-1),
        if (v(k)<0)
            v(k)=v(k)/abs(cmin);
        end
        if (v(k)>0) && (k-ib+1<=round(ns/2))
            v(k)=v(k)/cmax1;
        end
        if (v(k)>0) && (k-ib+1>round(ns/2))
            v(k)=v(k)/cmax2;
        end
    end
end

position=s;
s=s+0.000001;

phase=zeros(1,n);
% for j=1:n,
%     phase(j)=0;
% end

for jz=zfirst:zlast,
  if s(jz)~= 0 
     phase(jz)=atan(abs(v(jz)/s(jz)));
  end
  if (s(jz)>0) && (v(jz)>0)
     phase(jz)=phase(jz);
  end
  if (s(jz)<0) && (v(jz)>0) 
     phase(jz)=pi-abs(phase(jz));
  end
  if (s(jz)<0) && (v(jz)<0) 
     phase(jz)=pi+abs(phase(jz));
  end
  if (s(jz)>0) && (v(jz)<0) 
     phase(jz)=2*pi-abs(phase(jz));
  end
  if (s(jz)==-1+0.000001) && (round(v(jz))==0)
     phase(jz)=pi;
  end
  if (s(jz)==1+0.000001) && (round(v(jz))==0)
     phase(jz)=0;
  end
end

% unwrap
unwrap(phase);

% convert radians to degrees
phase=phase*radtodeg;
end  