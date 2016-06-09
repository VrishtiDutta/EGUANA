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
function [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
          y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12] = inputemma3D_rh(file,ch,checkac,mavis,varargin)
%SETUP VARIABLES

ratemo = 200;
rate = 16000;
check = checkac;
ac=0;

data = loaddata_rh(file);
if data ~= -1
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
        afile = regexprep(afile, '\\rawpos\', '\\wav\','ignorecase');
        afile = regexprep(afile, '\\pos\', '\\wav\', 'ignorecase');
        if fopen(afile,'r') == -1
            check = 0; 
            msgbox('Audio file does not exist! Audio data will not be displayed.','EMA 3D warnning','warn');
        else
            ac = audioread(afile);
            endpoint = length(ac);
            startpoint = fix(start*16000)-1;
            stoppoint = fix(stop*16000)+1; 
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
    dataSet(1) = struct('NAME','ac/.wav', 'SRATE',rate', 'SIGNAL',ac);
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
    
    %PREPARE VARIABLES FOR RETURN (ac is already prepared)
    x1=data(:,1);x2=data(:,8);x3=data(:,15);x4=data(:,22);x5=data(:,29); 
    x6=data(:,36);x7=data(:,43);x8=data(:,50);x9=data(:,57);x10=data(:,64); 
    x11=data(:,71);x12=data(:,78);
    y1=data(:,2);y2=data(:,9);y3=data(:,16);y4=data(:,23);y5=data(:,30); 
    y6=data(:,37);y7=data(:,44);y8=data(:,51);y9=data(:,58);y10=data(:,65);
    y11=data(:,72);y12=data(:,79);
    z1=data(:,3);z2=data(:,10);z3=data(:,17);z4=data(:,24);z5=data(:,31);
    z6=data(:,38);z7=data(:,45);z8=data(:,52);z9=data(:,59);z10=data(:,66);
    z11=data(:,73);z12=data(:,80);
    
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

