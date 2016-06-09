%**************************************************************************
%FUNCTION: inputemma3D
%Programmed by: Michael Novati, University of Toronto
%Date Created: July 4th, 2005
%Last Modified: July 21st, 2005
% Copyright: Oral Dynamics Lab, Pascal van Lieshout, PhD (Director)
%**************************************************************************
%DESCRIPTION: 
%   The main purpose is to load a position file created by the CalcPos or 
%   NormPos software package and display the data using MAVIS.  The user 
%   can also select and name relevent sensor channels, and select a start 
%   and end time for the trial.
%   ***NOTE***: for MAVIS analysis tools to work, you must store all
%   returned variables as new variables of the same names as the returned 
%   ones (i,e x1, x2, etc...)
%PARAMETERS:
%   'file': the FULL PATH and filename of the POSITION (rawpos or pos) data
%   'ch': an array containing the channels to be displayed in MAVIS, note
%   that simply passing '0' will result in all 12 channels being
%   displayed
%   'checkac': 0 - means no audio will be loaded, 1 - means load audio
%   'mavis': 0 - means do not open MAVIS, 1 - means display data in MAVIS
%   'varargin': controls start-stop times and channel label information
%   0 Arguments - means no start/end time and prompt user for labels
%   1 Argument - no start/end specified but load default labels (from the 
%   file channels.ini - created with SETCHANNELS function)
%   2 Arguments - means Arg1 is the start stop, Arg2 is the end time, but 
%   prompt user for labels
%   3 Arguments - means Arg1 is the start stop, Arg2 is the end time, and 
%   use default labels
%   *note, the value of the argument relating to the labels can be passed as
%   anything you choose.
%EXAMPLE:
%This will load all 12 channels with no audio, no cutoff, prompt for labels, open mavis:
%   inputemma3D('C:\name.pos', 0, 0, 1)
%This will load a few channels with audio, no cutoff, prompt for labels, open mavis:
%   inputemma3D('C:\name.pos', [1 2 3], 0, 1)    
%This will load all 12 channels with audio, and a cutoff, prompt for labels, no mavis:
%   inputemma3D('C:\name.pos', 0, 1, 0, 0.1, 1.3)
%   *note, the cutoffs are in seconds
%This will load all 12 channels with audio, and a cutoff, default labels, open mavis:
%   inputemma3D('C:\name.pos', 0, 1, 1, 0.1, 1.3)
%This will load all 12 channels with audio, no cutoff, default labels, no mavis:
%   inputemma3D('C:\name.pos', 0, 1, 0, 1)
%**************************************************************************
function [ac,Fs,srate,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
          y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
          phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
          theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
          theta10,theta11,theta12,channels,rchoice,lpValue] =...
          inputemma3D_jaw_rh(file,ch,checkac,mavis,defchannels,choice,MASKstruct,skip,lpValue,varargin)
%SETUP VARIABLES

ratemo = 200;
rate = 16000;
check = checkac;
ac = 0;

switch choice
    case 'No'
        
[data, srate] = loaddata_jaw_rh(file);

p={'td','tb','tt','head','nose','ul','ll','jaw','lc','rc','l ear','r ear'};
%def= {'1','2','3','4','5','6','7','8','9','10','11','12'};
if skip == 0
    r=inputdlg(p,'Channels',1,defchannels);
    lpValue = inputdlg('Low Pass Value','Low Pass Kinematic Data',1,{'6'});
else
    r=defchannels;
end
tempd = data;
channels = r;

for j = 1:12
    if str2double(r{j}) ~= j
        count = (j-1)*7+1;
        index = (str2double(r{j})-1)*7+1;
        for i = index:index+6
            data(:,count) = tempd(:,i);
            count = count+1;
        end
    end
end

    case 'Yes'
        data = 1;
end

if data ~= -1
    
    switch choice
        case 'No'
    %LOAD DATA AND CROP FOR START/END TIME
    if length(varargin) >= 2
        start = varargin{1};
        stop = varargin{2};
        endpoint = length(data);
        startpoint = fix(start*200)-1;
        stoppoint = fix(stop*200)+1;    
        data(stoppoint:endpoint,:)= [];
        data(1:startpoint,:)= [];
    else
        start = 0;
        stop = length(data)/200;
        endpoint = length(data);
        startpoint = 0;
        stoppoint = endpoint+1; 
    end
    
    %LOAD ACCOUSTIC DATA IF REQUIRED
    if check == 1
        afile = strcat(file(1:length(file)-4), '.wav');
        afile = regexprep(afile, ['rawpos' filesep], ['wav' filesep], 'ignorecase');
        afile = regexprep(afile, ['pos' filesep], ['wav' filesep], 'ignorecase');
        afile
        if fopen(afile,'r') == -1
            check = 0; 
            msgbox('Audio file does not exist! Audio data will not be displayed.','EMA 3D warnning','warn');
            Fs = 0;
        else
            [ac, Fs] = audioread(afile);
            endpoint = length(ac);
            rate = Fs;
            startpoint = fix(start*Fs)-1;
            stoppoint = fix(stop*Fs)+1; 
            ac(stoppoint:endpoint,:)= [];
            ac(1:startpoint,:)= [];
        end
    end

    %SETUP NUMBER OF CHANNELS
    nc = length(ch);
    if ch == 0
        t = zeros(1,length(data(:,1)));
        t = t';
        ch = [];
        nc = 0;
        for i = 1:12
           if ~isequal(data(:,(i-1)*7+1), t) && ~isequal(data(:,(i-1)*7+2), t) && ~isequal(data(:,(i-1)*7+3), t)
               ch(length(ch)+1) = i;
               nc = nc+1;
           end
        end
    end
    
      
    %CHANGE LABELS
    for i =1:nc
       lab{i} = ''; 
    end
    if mavis == 1
        if isempty(varargin) || length(varargin) == 2
            %p={'Enter 1 if you want to change the name of articulator for each channel. Enter 2 to load the defaults. Otherwise, enter 0:'};
            r{1} = '0';
            %r=inputdlg(p,'',1,{'0'});
            if  ~isempty(r) && eval(r{1}) == 1    
                for i = 1:nc
                   p2{i} = strcat('Enter the name of articulator for channel ', num2str(ch(i)), ':');
                end
                r2=inputdlg(p2,'',1);
                for i = 1:nc
                   lab{i} = r2{i};
                end 
            elseif ~isempty(r) && eval(r{1}) == 2
                if file(2) ~= ':'
                    lab = getchannels('channels.ini');
                else
                    t = regexprep(file, 'rawpos', 'aaa','ignorecase');
                    lab = getchannels(strcat(t(1:length(t)-12), 'channels.ini'));
                end
            end
        elseif length(varargin) == 1 || length(varargin) == 3
            if file(2) ~= ':'
                lab = getchannels('channels.ini');
            else
                t = regexprep(file, 'rawpos', 'aaa','ignorecase');
                lab = getchannels(strcat(t(1:length(t)-12), 'channels.ini'));
            end
        end
    end
    
    %FORMAT DATA FOR MAVIS ENVIRONMENT
    % stuff mvt channels, leaving space for audio
    for i = 1 : nc,
     dataSet(i+1) = struct('NAME',sprintf('x%d&y%d&z%d:%s',ones(1,3)*ch(i),lab{i}), ...
                           'SRATE',ratemo, ...
                           'SIGNAL',[data(:,(ch(i)-1)*7+1) data(:,(ch(i)-1)*7+2) data(:,(ch(i)-1)*7+3)]);
    end
    if check == 1 % stuff audio (note that I've skipped the unnecessary? scaling on ac)
    dataSet(1) = struct('NAME', ['ac' filesep '.wav'], 'SRATE',rate', 'SIGNAL',ac);
    else % zap audio placeholder
    dataSet(1) = [];
    end

    %start = 0;
    %if check == 1
     %  msignal = cell(1,nc+1);
      % start = 1;
       %mname{1} = strcat('ac/', '.wav');
       %msrate{1} = rate;
       %scale = max(abs(data(:,1)));
       %for i = 2:84
       %    temp = max(abs(data(:,i)));
        %   if temp > scale
         %      scale = temp;
          % end
       %end
       %msignal{1} = [ac*10*scale/max(ac)];
       %msignal{1} = [ac*0.0005*scale/max(ac)];
    %else
    %   msignal = cell(1,nc);   
    %end
    %for i = 1:nc     
    %   mname{i+start} = strcat('x', num2str(ch(i)), '&y', num2str(ch(i)), '&z', num2str(ch(i)), ':', lab{i});
    %   msrate{i+start} = ratemo;
    %   msignal{i+start} = [data(:,(ch(i)-1)*7+1) data(:,(ch(i)-1)*7+2) data(:,(ch(i)-1)*7+3)];
    %end
    
    %dataSet=struct('NAME',mname,'SRATE',msrate,'SIGNAL',msignal);     
    
    MASKfile = 0;
    rchoice = choice;
    
        case 'Yes'
    
            rchoice = choice;
            MASKfile = 1;
            channels = defchannels;
    
    end
    
    if MASKfile == 0
        
%         srate = 200;
%         srate = 250;
        
        %PREPARE VARIABLES FOR RETURN (ac is already prepared)
        x1=data(:,1);y1=data(:,2);z1=data(:,3);phi1=data(:,4);theta1=data(:,5);
        x2=data(:,8);y2=data(:,9);z2=data(:,10);phi2=data(:,11);theta2=data(:,12);
        x3=data(:,15);y3=data(:,16);z3=data(:,17);phi3=data(:,18);theta3=data(:,19);
        x4=data(:,22);y4=data(:,23);z4=data(:,24);phi4=data(:,25);theta4=data(:,26);
        x5=data(:,29);y5=data(:,30);z5=data(:,31);phi5=data(:,32);theta5=data(:,33);
        x6=data(:,36);y6=data(:,37);z6=data(:,38);phi6=data(:,39);theta6=data(:,40);
        x7=data(:,43);y7=data(:,44);z7=data(:,45);phi7=data(:,46);theta7=data(:,47);
        x8=data(:,50);y8=data(:,51);z8=data(:,52);phi8=data(:,53);theta8=data(:,54);
        x9=data(:,57);y9=data(:,58);z9=data(:,59);phi9=data(:,60);theta9=data(:,61);
        x10=data(:,64);y10=data(:,65);z10=data(:,66);phi10=data(:,67);theta10=data(:,68);
        x11=data(:,71);y11=data(:,72);z11=data(:,73);phi11=data(:,74);theta11=data(:,75);
        x12=data(:,78);y12=data(:,79);z12=data(:,80);phi12=data(:,81);theta12=data(:,82);
        
    elseif MASKfile == 1
        
        positionfile = zeros(5,12,length(MASKstruct.pos));
        
        positionfile(1:3,1:size(MASKstruct.pos,2),:) = MASKstruct.pos;
        positionfile = positionfile*10;
        ac = MASKstruct.voice;
        Fs = MASKstruct.sample_rate;
        if isempty(ac) == 1
            ac = 0;
            Fs = 0;
        end
        
        srate = 60;
        
        x1=squeeze(positionfile(1,1,:)); y1=squeeze(positionfile(2,1,:)); z1=squeeze(positionfile(3,1,:)); phi1=squeeze(positionfile(4,1,:)); theta1=squeeze(positionfile(5,1,:));
        x2=squeeze(positionfile(1,2,:)); y2=squeeze(positionfile(2,2,:)); z2=squeeze(positionfile(3,2,:)); phi2=squeeze(positionfile(4,2,:)); theta2=squeeze(positionfile(5,2,:));
        x3=squeeze(positionfile(1,3,:)); y3=squeeze(positionfile(2,3,:)); z3=squeeze(positionfile(3,3,:)); phi3=squeeze(positionfile(4,3,:)); theta3=squeeze(positionfile(5,3,:));
        x4=squeeze(positionfile(1,4,:)); y4=squeeze(positionfile(2,4,:)); z4=squeeze(positionfile(3,4,:)); phi4=squeeze(positionfile(4,4,:)); theta4=squeeze(positionfile(5,4,:));
        x5=squeeze(positionfile(1,5,:)); y5=squeeze(positionfile(2,5,:)); z5=squeeze(positionfile(3,5,:)); phi5=squeeze(positionfile(4,5,:)); theta5=squeeze(positionfile(5,5,:));
        x6=squeeze(positionfile(1,6,:)); y6=squeeze(positionfile(2,6,:)); z6=squeeze(positionfile(3,6,:)); phi6=squeeze(positionfile(4,6,:)); theta6=squeeze(positionfile(5,6,:));
        x7=squeeze(positionfile(1,7,:)); y7=squeeze(positionfile(2,7,:)); z7=squeeze(positionfile(3,7,:)); phi7=squeeze(positionfile(4,7,:)); theta7=squeeze(positionfile(5,7,:));
        x8=squeeze(positionfile(1,8,:)); y8=squeeze(positionfile(2,8,:)); z8=squeeze(positionfile(3,8,:)); phi8=squeeze(positionfile(4,8,:)); theta8=squeeze(positionfile(5,8,:));
        x9=squeeze(positionfile(1,9,:)); y9=squeeze(positionfile(2,9,:)); z9=squeeze(positionfile(3,9,:)); phi9=squeeze(positionfile(4,9,:)); theta9=squeeze(positionfile(5,9,:));
        x10=squeeze(positionfile(1,10,:)); y10=squeeze(positionfile(2,10,:)); z10=squeeze(positionfile(3,10,:)); phi10=squeeze(positionfile(4,10,:)); theta10=squeeze(positionfile(5,10,:));
        x11=squeeze(positionfile(1,11,:)); y11=squeeze(positionfile(2,11,:)); z11=squeeze(positionfile(3,11,:)); phi11=squeeze(positionfile(4,11,:)); theta11=squeeze(positionfile(5,11,:));
        x12=squeeze(positionfile(1,12,:)); y12=squeeze(positionfile(2,12,:)); z12=squeeze(positionfile(3,12,:)); phi12=squeeze(positionfile(4,12,:)); theta12=squeeze(positionfile(5,12,:));
 
    end
    
%     x1=data(:,1);x2=data(:,8);x3=data(:,15);x4=data(:,22);x5=data(:,29); 
%     x6=data(:,36);x7=data(:,43);x8=data(:,50);x9=data(:,57);x10=data(:,64); 
%     x11=data(:,71);x12=data(:,78);
%     y1=data(:,2);y2=data(:,9);y3=data(:,16);y4=data(:,23);y5=data(:,30); 
%     y6=data(:,37);y7=data(:,44);y8=data(:,51);y9=data(:,58);y10=data(:,65);
%     y11=data(:,72);y12=data(:,79);
%     z1=data(:,3);z2=data(:,10);z3=data(:,17);z4=data(:,24);z5=data(:,31);
%     z6=data(:,38);z7=data(:,45);z8=data(:,52);z9=data(:,59);z10=data(:,66);
%     z11=data(:,73);z12=data(:,80);
    
   %EXECUTE MAVIS
     clear dataSet_cfg;
     warning('off','MATLAB:dispatcher:InexactMatch');    
    %MVIEW(dataSet)
     dataSet_cfg = struct('FIGPOS',[1281 1 1280 977],'FRAME',256,...
            'ORDER',20,'WSIZE',30,'NFMTS',3,'NUDGE',5,'AVGW',6,'OLAP',1,...
            'ZOOMW',10,'PREEMP',0.9800,'SOFF',20,'CONTRAST',4,'AUTO',0,'DPROC',[],...
            'LPROC','LP_FINDGEST','LPSTATE',[],'PALATE',[],'PHARYNX',[],'ANAL',1,...
            'MULT',1,'TEMPMAP',[],'ISF',0,'SPREAD',-6.9461e+003,'SPECLIM',8000,'SPLINE',[],...
            'CIRCLE',[],'VIEW',[27 20],'FTRAJ',1); 
    dataSet_cfg.TEMPMAP ={'ac','z1','z2','z3','z6','z7','z8'};
    %mview(dataSet,'CONFIG',dataSet_cfg);
%    mview(dataSet);
end

