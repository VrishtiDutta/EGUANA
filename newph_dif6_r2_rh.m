% determine phase difference, i.e., relative phase signal
% by subtracting two phase signals using Batchelet (1981)
% procedure involving circular statistics
%
% PvL: changed conditions for zero phase if no. cycles too small 14-11-2000
%
function [rph_nozero,temp_aver_phi,temp_RMS,temp_sd_phi,temp_num_sample...
    temp_cv_phi]=newph_dif6_r2_rh(signal1,signal2,interval,rate,wora,...
    fname,lastname,trial,ifname,channel1,channel2,domfreq,lofreq,hifreq,...
    starttime,stoptime,pulstime,meancoh,sdcoh,nopeakscoh,name1,name2)

string1=['subject ',...
    'trial ',...
    'channel1 ',...
    'channel2 ',...
    'Dominant freq ',...
    'Lower bin limit ',...
    'Higher bin limit ',...
    'Starttime ',...
    'Stoptime ',...
    'aver_relative_phase R_relative_phase ',...
    'SD_relative_phase ',...
    'Number_samples'];

[zfirst1,zlast1,t1,nz1,zz1,s1,v1,ph1]=phaseforrelative_rh(signal1,interval,rate);
if (zfirst1==0 && zlast1==0 && t1==0 && nz1==0 && zz1==0 && s1==0 && v1==0 && ph1==0)
    rph_nozero=0;
    return
else
    
    [zfirst2,zlast2,t2,nz2,zz2,s2,v2,ph2]=phaseforrelative_rh(signal2,interval,rate);
    if (zfirst2==0 && zlast2==0 && t2==0 && nz2==0 && zz2==0 && s2==0 && v2==0 && ph2==0)
        rph_nozero=0;
        return
    else
        
        h1=ph1;
        h2=ph2;
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
        
        
        rph=radtodeg*(rph)';% rel phase
        rph_nozero=radtodeg*(rph_nozero)'; % rel phase without zeros
        newrph=rph_nozero;
        
        %% variables calculation
        newrph=newrph*degtorad;
        val04=num2str(length(newrph));
        
        % Number of samples
        num_sample=length(newrph);
        
        % Average
        aversumcos=sum(cos(newrph))/num_sample;
        aversumsin=sum(sin(newrph))/num_sample;
        aver_phi=atan(aversumsin/aversumcos)*radtodeg;
        
        if (aversumcos<0)
            aver_phi=aver_phi+180;
        end
        if (aver_phi<0)
            aver_phi=aver_phi+360;
        end
        
        %RMS
        squraversumcos=power(aversumcos,2);
        squraversumsin=power(aversumsin,2);
        RMS=sqrt(squraversumcos+squraversumsin);
        
        %Sd
        sd_phi=sqrt(2*(1-RMS))*radtodeg;
        
        %% unwrap relative phase 
        
        %rate = 200;% for both 2D and 3D this is fine as 2D was downsampled
        temp1=rph_nozero*degtorad;% convert to radians
        relphase_nozero_unrap=unwrap(temp1);
        rph_nz_unr_deg=relphase_nozero_unrap*radtodeg;
        rph_nz_unr_deg=rph_nz_unr_deg*degtorad;

        %% first figure
    figurerelativeband(t1,s1,v1,h1,nz1,zz1,t2,s2,v2,h2,nz2,zz2,...
    nlast,nfirst,rph, rph_nz_unr_deg,aver_phi,RMS,sd_phi,val04,...
    pulstime,starttime,name1,name2);
        
        
        %% calculation for temp variables
        
        Nsegments=floor(length(newrph)/rate);
        temp_aver_phi=zeros(1,Nsegments);
        temp_RMS=zeros(1,Nsegments);
        temp_sd_phi=zeros(1,Nsegments);
        
        k=1;
        while (length(newrph)/rate>=1)
            
            
            temp=newrph(1:rate);
            %number of samples
            temp_num_sample=length(temp);
            
            %average
            aversumcos=sum(cos(temp))/temp_num_sample;
            aversumsin=sum(sin(temp))/temp_num_sample;
            temp_aver_phi(k)=atan(aversumsin/aversumcos)*180/pi;
            
            if (aversumcos<0)
                temp_aver_phi(k)=temp_aver_phi(k)+180;
            end
            if (temp_aver_phi(k)<0)
                temp_aver_phi(k)=temp_aver_phi(k)+360;
            end
            
            % RMS
            squraversumcos=power(aversumcos,2);
            squraversumsin=power(aversumsin,2);
            
            temp_RMS(k)=sqrt(squraversumcos+squraversumsin);
            temp_sd_phi(k)=sqrt(2*(1-temp_RMS(k)))*180/pi;
            
            k=k+1;
            newrph(1:rate)=[];
        end
        
        %Add on to calculate CV of relative phase % new part PVL 09-01-03
        temp_cv_phi=temp_sd_phi./temp_aver_phi;
        
        
      
        
        if (wora==1)
            fid=fopen(fname,'a');
            fprintf(fid,'%s\n',string1);
            fclose(fid);
            fid1=fopen(fname,'a');
            fprintf(fid1,'%s %s %s %s %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f\n %4.8f\n %4.8f\n %4.8f\n %4.8f %4.8f %4.8f %4.8f\n',lastname,trial,channel1,channel2,domfreq,lofreq,hifreq,starttime,stoptime,pulstime,aver_phi,RMS,sd_phi,num_sample,meancoh,sdcoh,nopeakscoh);
            fclose(fid1);
            fid2=fopen(ifname,'a');
            fprintf(fid2,'%s\n',string1);
            fclose(fid2);
            fid3=fopen(ifname,'a');
            for i3=1:(k-1)
                fprintf(fid3,'%s %s %s %s %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f\n',lastname,trial,channel1,channel2,domfreq,lofreq,hifreq,starttime,stoptime,pulstime,temp_aver_phi(i3),temp_RMS(i3),temp_sd_phi(i3),temp_num_sample);
            end
            fclose(fid3);
        elseif (wora==2)
            fid4=fopen(fname,'a');
            fprintf(fid4,'%s %s %s %s %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f\n %4.8f\n %4.8f\n %4.8f\n %4.8f %4.8f %4.8f %4.8f\n',lastname,trial,channel1,channel2,domfreq,lofreq,hifreq,starttime,stoptime,pulstime,aver_phi,RMS,sd_phi,num_sample,meancoh,sdcoh,nopeakscoh);
            %fprintf(fid4,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %4.3f %4.3f %3.0f\n',lastname,trial,channel1,channel2,domfreqstr,lowfreqstr,highfreqstr,starttimestr,stoptimestr,pulstimestr,val01,val02,val03,val04,meancoh,sdcoh,nopeakscoh);
            fclose(fid4);
            fid5=fopen(ifname,'a');
            for i3=1:(k-1)
                fprintf(fid5,'%s %s %s %s %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f %4.8f\n',lastname,trial,channel1,channel2,domfreq,lofreq,hifreq,starttime,stoptime,pulstime,temp_aver_phi(i3),temp_RMS(i3),temp_sd_phi(i3),temp_num_sample);
                %fprintf(fid5,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',lastname,trial,channel1,channel2,domfreqstr,lowfreqstr,highfreqstr,starttimestr,stoptimestr,pulstimestr,temp_aver_phi(i3),temp_RMS(i3),temp_sd_phi(i3),temp_num_sample);
            end
            fclose(fid5);
        end
    end
    
end