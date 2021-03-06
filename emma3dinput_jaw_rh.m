%**************************************************************************
%FUNCTION: emma3D
%Programmed by: Michael Novati, University of Toronto
%Date Created: July 5th, 2005
%Upgraded by: Rafael Henriques, ODL
%Last Modified: July 12th, 2010
%**************************************************************************
%DESCRIPTION: 
%   Interface to gather parameters for inputemma3D function from the user
%   Creates variables (x1, y1, z1, ...) in the workspace directory for use 
%   with MAVIS analysis tools, also puts audio data into a variable 'ac' to
%   be used with the tools
%HOW TO USE:
%   At the MATLAB command windows type 'EMMA3D'. Enter ALL values in the 
%   prompt window and press OK to continue.
%**************************************************************************

%% DISPLAY WINDOW

% p={'File path (your output files will be named after the root directory):',...
%     'Trial number:','Subject name:',...
%    'CHANNELS TO BE DISPLAYED - list separated by spaces OR 0 to load all:',...
%    'Path to store results:'};
% def= {'D:\Rafael\3Ddata\Control 21 session 1','4','Anon',...
%      '0','D:\results\'};
 
choice = questdlg('Are you importing a MASK file?','Input file','No','Yes','No');

switch choice
    case 'No'
        
        r = gui_input3Dfiles(handles);
        
% h = msgbox({'(1) Select directory for the input data.' '(2) Select directory for storing the results.'},'File input instructions');
% p={'File path (your output files will be named after the root directory):',...
%     'Trial number:','Subject name:',...
%     'Path to store results:'};
% def= {'D:\Rafael\3Ddata\Control 21 session 1','4','Anon','D:\results\'};
% def{1} = uigetdir('','Select path for input files.');
% def{4} = uigetdir('','Select path to store results.');
% r=inputdlg(p,'Input data for 3D EMA',1,def,'on');

stop = 1;
err=0;

if isempty(r)
    err = 1;
elseif isempty(r{1})
    errordlg('Provide path for input files','Input Error','modal');
    err = 1;
elseif isempty(r{2})
    errordlg('Provide trial number','Input Error','modal');
    err = 1;
elseif isempty(r{3})
    errordlg('Provide subject name','Input Error','modal');
    err = 1;
% elseif isempty(r{4})
%     errordlg('Provide position type','Input Error','modal');
%     err = 1;
% elseif isempty(r{4})
%     errordlg('Provide channel display','Input Error','modal');
%     err = 1;
elseif isempty(r{4})
    errordlg('Provide output directory','Input Error','modal');
    err = 1;
elseif ~isempty(r)
    respath = r{4};
    tri = r{2};
    sub = r{3};
        
    %% FORM THE PATH STRING
    path = r{1};
    if isempty(path)
        path = '';
    elseif path(length(path)) ~= filesep
        path(length(path)+1) = filesep;
    end
    
    % see if there is a pos file
    
    folderlist = dir(path);
    folders = {folderlist.name};
    folders = folders.';
    numfol=size(folders,1);
    
    posOK=0;
    for i=1:numfol
        %if(size(find(folders(i,1:3)=='pos'),2)==3),posOK=1; end
        if(strcmp(folders(i),'pos')==1),posOK=1; end
    end
    
    %
    %     if posOK == 0,
    %         normalized = 'raw';
    %         msgbox('Norm pos data not found. Pos data will be used instead!'...
    %             ,'EMA 3D warnning','warn')
    %     else
    %         normalized = questdlg('Chose position data type','input 3D',...
    %                             'normalized', 'raw','normalized');
    %     end
    
    %     if strcmp(normalized,'raw')
    pathpos=path;
    path = strcat(path, 'rawpos', filesep);
    path1=path;
    %     else
    %         path = strcat(path, 'pos\');
    %     end
    
    if r{2}(length(r{2})) ~= 'c' && r{2}(length(r{2})) ~= 'r'
        for i = 1:(4-length(r{2}))
            path = strcat(path, '0');
        end
        path = strcat(path, r{2},'.pos');
    else
        for i = 1:(5-length(r{2}))
            path = strcat(path, '0');
        end
        path = strcat(path, r{2},'.pos');
    end
    
    if posOK==1
        pathpos = strcat(pathpos, 'pos', filesep);
        if r{2}(length(r{2})) ~= 'c' && r{2}(length(r{2})) ~= 'r'
            for i = 1:(4-length(r{2}))
                pathpos = strcat(pathpos, '0');
            end
            pathpos = strcat(pathpos, r{2},'.pos');
        else
            for i = 1:(5-length(r{2}))
                pathpos = strcat(pathpos, '0');
            end
            pathpos = strcat(pathpos, r{2},'.pos');
        end
    end
    %% FORM CHANNELS
%     if r{4} == '0' this r{4} is the correspondent to 'CHANNELS TO BE DISPLAYED - list
%     separated by spaces OR 0 to load all:' in last vertion
%         ch = 0;
%     else
%     ch = str2double(r{4}); % str2double is more faster but only change 
                               % scalar if you want to use the same for
                               % non scalars please change str2double to 
                               % str2num
    %end
    
    ch=0;
    start = 0;
    stop = 0;
    audio = 1;
    MASKstruct = {};

end

    case 'Yes'
        
        r = gui_inputMASKfiles(handles);
        
        %h = msgbox({'(1) Select MASK file for the input data.' '(2) Select directory for storing the results.'},'File input instructions');
        path = '';
        path1 = path;
        pathpos = '';
        err = 0;
        ch=0;
        start = 0;
        stop = 0;
        audio = 1;
        posOK = 1;
        tri = '4';
        sub = r{2};
        MASKstruct = r{4};
        
end

if err == 0

    %% Read data, CALL INPUT FUNCTION 
    if stop ==0
        defchannels = {'1','2','3','4','5','6','7','8','9','10','11','12'};
        lpValue = {'6'};
        positionfile = 0;
        [ac,Fs,srate,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
            y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
            phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
            theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
            theta10,theta11,theta12,channels,rchoice,lpValue] =...
            inputemma3D_jaw_rh(path, ch,audio, 1, defchannels, choice, MASKstruct, 0,lpValue);
        %     else
        %        [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
        %           y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12] = inputemma3D_jaw_rh(path, ch,audio, 1, start, stop);
        
        if posOK==1
            defchannels = channels;
            choice = rchoice;
            [ac,Fs,srate,x1pos,x2pos,x3pos,x4pos,x5pos,x6pos,x7pos,x8pos,x9pos,x10pos,x11pos,x12pos,y1pos,y2pos,y3pos,y4pos,y5pos,y6pos,y7pos,...
                y8pos,y9pos,y10pos,y11pos,y12pos,z1pos,z2pos,z3pos,z4pos,z5pos,z6pos,z7pos,z8pos,z9pos,z10pos,z11pos,z12pos,...
                phi1pos,phi2pos,phi3pos,phi4pos,phi5pos,phi6pos,phi7pos,phi8pos,phi9pos,phi10pos,phi11pos,phi12pos,...
                theta1pos,theta2pos,theta3pos,theta4pos,theta5pos,theta6pos,theta7pos,theta8pos,theta9pos,...
                theta10pos,theta11pos,theta12pos,channels,rchoice,lpValue] =...
                inputemma3D_jaw_rh(pathpos, ch,audio, 1, defchannels, choice, MASKstruct, 1,lpValue);
        end
        switch choice
            case 'Yes'
                respath = r{3};
            case 'No'
        end
    end

    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% CORRECT FOR 3D DATA!!! Jaw Correction / Gestures calculation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % decoupling jaw from LL & Tongue % NOTICE SAME METHOD FOR 2D 
% % Z position
% [x7c,z7c]=decouple_rh(x7,z7,x8,z8,200);
% [x1c,z1c]=decouple_rh(x1,z1,x8,z8,200);
% [x2c,z2c]=decouple_rh(x2,z2,x8,z8,200);
% [x3c,z3c]=decouple_rh(x3,z3,x8,z8,200);
% 
% %[x7c,y7c]=decouple_rh(x7,z7,x8,z8,200);
% %[x1c,y1c]=decouple_rh(x1,z1,x8,z8,200);
% %[x2c,y2c]=decouple_rh(x2,z2,x8,z8,200);
% %[x3c,y3c]=decouple_rh(x3,z3,x8,z8,200);
% 
% % creating lip closure tract variable + gestures
% 
% len=size(x1,1);
% 
% %BC = bilabial closure
% ges_stop = 0;
% if x6 == 0, ges_stop = 1;
% elseif y6 == 0, ges_stop = 1;
% elseif z6 == 0, ges_stop = 1;
% elseif x7 == 0, ges_stop = 1; 
% elseif y7 == 0, ges_stop = 1; 
% elseif z7 == 0, ges_stop = 1; 
% end 
% if ges_stop == 1
%     BC = zeros(1,len);
% else
% hulpsig1=x6-x7;
% hulpsig2=y6-y7;
% hulpsigt=z6-z7;
% lipclos=hulpsig2;
% hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
% hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
% BC=sqrt(hulpsig5);  
% end
% 
% %TD = tongue dorsum
% ges_stop = 0;
% if x1 == 0, ges_stop = 1;
% elseif y1 == 0, ges_stop = 1;
% elseif z1 == 0, ges_stop = 1;
% elseif x5 == 0, ges_stop = 1; 
% elseif y5 == 0, ges_stop = 1; 
% elseif z5 == 0, ges_stop = 1; 
% end 
% if ges_stop == 1
%     TD = zeros(1,len);
% else
% hulpsig1=x1-x5;
% hulpsig2=y1-y5;
% hulpsigt=z1-z5;
% hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
% hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
% TD=sqrt(hulpsig5);
% end
% 
% %TB = tongue body
% ges_stop = 0;
% if x2 == 0, ges_stop = 1;
% elseif y2 == 0, ges_stop = 1;
% elseif z2 == 0, ges_stop = 1;
% elseif x5 == 0, ges_stop = 1; 
% elseif y5 == 0, ges_stop = 1; 
% elseif z5 == 0, ges_stop = 1; 
% end 
% if ges_stop == 1
%     TB = zeros(1,len);
% else
% hulpsig1=x2-x5;% use nose position as upper limit (like ul in BC)
% hulpsig2=y2-y5;
% hulpsigt=z2-z5;
% hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
% hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
% TB=sqrt(hulpsig5);
% end
% 
% %TT = tongue tip (actually blade)
% ges_stop = 0;
% if x3 == 0, ges_stop = 1;
% elseif y3 == 0, ges_stop = 1;
% elseif z3 == 0, ges_stop = 1;
% elseif x5 == 0, ges_stop = 1; 
% elseif y5 == 0, ges_stop = 1; 
% elseif z5 == 0, ges_stop = 1; 
% end 
% if ges_stop == 1
%     TT = zeros(1,len);
% else
% hulpsig1=x3-x5;
% hulpsig2=y3-y5;
% hulpsigt=z3-z5;
% hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;hulpsigt1=(hulpsigt).^2;
% hulpsig5=hulpsig3+hulpsig4+hulpsigt1;
% TT=sqrt(hulpsig5);  
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORRECT FOR 3D DATA!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% saving session name - 3D files are named by directory
last_slash = 0;
last_slash2 = 0;
last_slash3 = 0;
dot = 0;
for k = 1:length(path)
    if path(k) == filesep 
        last_slash3 = last_slash2;
        last_slash2 = last_slash;
        last_slash = k;
        
    end
    if path(k) == '.' dot = k;
    end
end

switch choice
    case 'No'
        sess = path(last_slash3+1:last_slash2-1); % name of session
    case 'Yes'
        sess = 'MASK';
end

end



  
