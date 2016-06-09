%**************************************************************************
%FUNCTION: emma2dinput_rh.m (previous names EMMA / EMMA_matt)
%Upgraded by: Rafael Henriques, ODL
%Date Created: N/A
%Last Modified: July 7th, 2010
%**************************************************************************
%DESCRIPTION: 
%   Facilitates input from AG100 data file
%**************************************************************************

%% input dialog box

r = gui_input2Dfiles(handles);

% colordef white;
% %p={ 'File name (with path):','Trial number:','Subject name:'...
% %    'VIEW CHANNELS: 5=channels 1 to 5, 6=channels 1,2,3,6,7,8 OR 10=all channels:','Path to store results:'};
% p={ 'File name (with path):','Trial number:','Subject name:'...
%    ,'Path to store results:'};
% t='Input data for 2D EMA';
% %def = {'D:\PASCAL RA\Matt\Abishek Program edited by MC\Emma 2D sample\Tontwi.008','8','Anon','10','D:\results\'};
% def = {'D:\Rafael\2Ddata\N2P1_converted\N2p1s1.011','8','Anon','D:\results\'};
% h = msgbox({'(1) Select file for the input data.' '(2) Select directory for storing the results.'},'File input instructions');
% [filename2d, pathname2d] = uigetfile('*.*','Select the 2D data file');
% def{1} = [pathname2d filename2d];
% [pathstr, fname, ext] = fileparts(filename2d);
% def{2} = num2str(str2double(ext(3:length(ext))));
% def{4} = uigetdir('','Select path to store results.');
% r=inputdlg(p,t,[1 60],def,'on');

if isempty(r)
    
elseif isempty(r{1})
    errordlg('Provide path for input files','Input Error','modal');

elseif isempty(r{2})
    errordlg('Provide trial number','Input Error','modal');

elseif isempty(r{3})
    errordlg('Provide subject name','Input Error','modal');

%elseif isempty(r{4})
%    errordlg('Provide channel display','Input Error','modal');

%elseif isempty(r{5})
elseif isempty(r{4})
    errordlg('Provide output directory','Input Error','modal');
elseif ~isempty(r)
    
%     respath = r{5};
    respath=r{4};
    tri = r{2};
    move1=r{1};
    number_ch=10;
    sub = r{3};
    %checkch=eval(r{4});
    checkch=10;
    ratemo=400;
    checkac=1;
    rate=16000;
   
    namestr=move1(1:length(move1)-3);
    extstr=move1(length(move1)-1:length(move1));
        
    if number_ch == 10
        move2=[namestr,'1',extstr];
    else 
        move2=0;
    end
    if checkac == 1
        finame=[namestr,'m',extstr];
    else
        finame=0;
    end

%% Read data
    [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10]=...
        inputemma2d_rh(move1,number_ch,move2,checkch,checkac,finame,...
        rate,ratemo);
    
%% Jaw Correction /  milimeters convertion  

    if number_ch == 10
        %convert into mm
        x1=x1/100;x2=x2/100;x3=x3/100;x4=x4/100;x5=x5/100;
        x6=x6/100;x7=x7/100;x8=x8/100;x9=x9/100;x10=x10/100;
        y1=y1/100;y2=y2/100;y3=y3/100;y4=y4/100;y5=y5/100;
        y6=y6/100;y7=y7/100;y8=y8/100;y9=y9/100;y10=y10/100;
        
%         %correct for head movements as signaled by coil #5 (nose) and #4
%         %(maxilla)
%         x1h=x1-x5;x2h=x2-x5;x3h=x3-x5;x4h=x4-x5;x6h=x6-x5;
%         x7h=x7-x5;x8h=x8-x5;x9h=x9-x5;x10h=x10-x5;
%         % same for y
%         y1h=y1-y5;y2h=y2-y5;y3h=y3-y5;y4h=y4-y5;y6h=y6-y5;
%         y7h=y7-y5;y8h=y8-y5;y9h=y9-y5;y10h=y10-y5;
        
        % decoupling jaw from LL & Tongue
        [x7c,y7c]=decouple_rh(x7,y7,x8,y8,400);
        [x1c,y1c]=decouple_rh(x1,y1,x8,y8,400);
        [x2c,y2c]=decouple_rh(x2,y2,x8,y8,400);
        [x3c,y3c]=decouple_rh(x3,y3,x8,y8,400);
        
        % creating lip closure tract variable + gestures
        

%% these code will be useful when user can select only the channels that
% he want to see

%     else  
%         x1=x1/100;x2=x2/100;x3=x3/100;x4=x4/100;x5=x5/100;
%         y1=y1/100;y2=y2/100;y3=y3/100;y4=y4/100;y5=y5/100;
%         
%         % decoupling jaw from LL & Tongue
%         [x4c,y4c]=decouple_rh(x4,y4,x5,y5,400);
%         [x1c,y1c]=decouple_rh(x1,y1,x5,y5,400);
%         [x2c,y2c]=decouple_rh(x2,y2,x5,y5,400);
%         
%         % creating lip closure vocal tract variable + gestures 
%         %(see above for legend)
%         %BC = bilabial closure
%         hulpsig1=x3-x4;hulpsig2=y3-y4;
%         lipclos=hulpsig2;
%         hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;
%         hulpsig5=hulpsig3+hulpsig4;
%         BC=sqrt(hulpsig5);  
     end
    
    %% resampling to 200 Hz 
    % this was necessary to use the PDIST function inside crqalog20
    x1c = resample(x1c,1,2);
    x2c = resample(x2c,1,2);
    x3c = resample(x3c,1,2);
    x1 = resample(x1,1,2);
    x2 = resample(x2,1,2);
    x3 = resample(x3,1,2);
    x4 = resample(x4,1,2);
    x5 = resample(x5,1,2);
    x6 = resample(x6,1,2);
    x7c = resample(x7c,1,2);
    x7 = resample(x7,1,2);
    x8 = resample(x8,1,2);
    x9 = resample(x9,1,2);
    x10 = resample(x10,1,2);
    y1c = resample(y1c,1,2);
    y2c = resample(y2c,1,2);
    y3c = resample(y3c,1,2);
    y1 = resample(y1,1,2);
    y2 = resample(y2,1,2);
    y3 = resample(y3,1,2);
    y4 = resample(y4,1,2);
    y5 = resample(y5,1,2);
    y6 = resample(y6,1,2);
    y7c = resample(y7c,1,2);
    y7 = resample(y7,1,2);
    y8 = resample(y8,1,2);
    y9 = resample(y9,1,2);
    y10 = resample(y10,1,2);

%% Gestures

len=size(x1,1);

%BC = bilabial closure
ges_stop = 0;
if x6 == 0, ges_stop = 1;
elseif y6 == 0, ges_stop = 1;
elseif x7 == 0, ges_stop = 1; 
elseif y7 == 0, ges_stop = 1; 
end 
if ges_stop == 1
    BC = zeros(1,len);
else
hulpsig1=x6-x7;hulpsig2=y6-y7;
hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;
hulpsig5=hulpsig3+hulpsig4;
BC=sqrt(hulpsig5);
end

%TD = tongue dorsum
ges_stop = 0;
if x1 == 0, ges_stop = 1;
elseif y1 == 0, ges_stop = 1;
elseif x5 == 0, ges_stop = 1; 
elseif y5 == 0, ges_stop = 1; 
end 
if ges_stop == 1
    TD = zeros(1,len);
else
hulpsig1=x1-x5;hulpsig2=y1-y5;
hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;
hulpsig5=hulpsig3+hulpsig4;
TD=sqrt(hulpsig5);
end

%TB = tongue body [use nose position as upper limit(like ul in BC)]
ges_stop = 0;
if x2 == 0, ges_stop = 1;
elseif y2 == 0, ges_stop = 1;
elseif x5 == 0, ges_stop = 1; 
elseif y5 == 0, ges_stop = 1; 
end 
if ges_stop == 1
    TB = zeros(1,len);
else
hulpsig1=x2-x5;hulpsig2=y2-y5;
hulpsig3=(hulpsig1).^2;hulpsig4=(hulpsig2).^2;
hulpsig5=hulpsig3+hulpsig4;
TB=sqrt(hulpsig5);
end

%TT = tongue tip (actually blade)
ges_stop = 0;
if x3 == 0, ges_stop = 1;
elseif y3 == 0, ges_stop = 1;
elseif x5 == 0, ges_stop = 1; 
elseif y5 == 0, ges_stop = 1; 
end 
if ges_stop == 1
    TT = zeros(1,len);
else
hulpsig1=x3-x5;
hulpsig2=y3-y5;
hulpsig3=(hulpsig1).^2;
hulpsig4=(hulpsig2).^2;
hulpsig5=hulpsig3+hulpsig4;
TT=sqrt(hulpsig5);
end


    %% saving session name
    last_slash = 0;
    dot = 0;
    for k = 1:length(move1)
        if move1(k) == filesep, last_slash = k;
        end
        if move1(k) == '.', dot = k;
        end
    end
    sess = move1(last_slash+1:dot-1); % name of session

    clear hulpsig* p t r move1 number_ch move2 checkch ratemo checkac ...
          finame rate starttime stoptime
end


