p={'File path (your output files will be named after the root directory):',...
    'Trial number:'};
def= {'Y:\odlftp\ag501\data\recorder\current','390'};
def{1} = uigetdir('','Select path for input files.');
r=inputdlg(p,'',1,def);
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
elseif ~isempty(r)        
    %% FORM THE PATH STRING
    path = r{1};
    if isempty(path)
        path = '';
    elseif path(length(path)) ~= '\'
        path(length(path)+1) = '\';
    end
    
    % see if there is a pos file
    folders=ls(path);
    numfol=size(folders,1);
    posOK=0;
    
    for i=1:numfol
        if(size(find(folders(i,1:3)=='pos'),2)==3),posOK=1; end
    end
    pathpos=path;
    path = strcat(path, 'rawpos\');
    path1=path;
    
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
        pathpos = strcat(pathpos, 'pos\');
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
    
    ch=0;
    start = 0;
    stop = 0;

end

if err == 0

    %% Read data, CALL INPUT FUNCTION 
    if stop ==0
        
        
        if fopen(path,'r') == -1
            questdlg('File does not exist.  Please ensure PATH is correct.',...
                'ERROR','OK','OK');
            data = -1;
        else
            f = fopen(path, 'r');
            array = fread(f,[84 inf], 'single');
            data = array';
        end

        %PREPARE VARIABLES FOR RETURN (ac is already prepared)
        x1=data(:,1);y1=data(:,2);z1=data(:,3);phi1=data(:,4);theta1=data(:,5);
        x2=data(:,8);y2=data(:,9);z2=data(:,10);phi2=data(:,11);theta2=data(:,12);
        x3=data(:,15);y3=data(:,16);z3=data(:,17);phi3=data(:,18);theta3=data(:,19);
        x4=data(:,22);y4=data(:,23);z4=data(:,24);phi4=data(:,25);theta4=data(:,26);
        x5=data(:,29);y5=data(:,30);z5=data(:,31);phi5=data(:,32);theta5=data(:,33);
        
        if posOK==1
            if fopen(pathpos,'r') == -1
                questdlg('File does not exist.  Please ensure PATH is correct.',...
                    'ERROR','OK','OK');
                data2 = -1;
            else
                f = fopen(pathpos, 'r');
                array = fread(f,[84 inf], 'single');
                data2 = array';
            end

            %PREPARE VARIABLES FOR RETURN (ac is already prepared)
            x1pos=data2(:,1);y1pos=data2(:,2);z1pos=data2(:,3);phi1pos=data2(:,4);theta1pos=data2(:,5);
            x2pos=data2(:,8);y2pos=data2(:,9);z2pos=data2(:,10);phi2pos=data2(:,11);theta2pos=data2(:,12);
            x3pos=data2(:,15);y3pos=data2(:,16);z3pos=data2(:,17);phi3pos=data2(:,18);theta3pos=data2(:,19);
            x4pos=data2(:,22);y4pos=data2(:,23);z4pos=data2(:,24);phi4pos=data2(:,25);theta4pos=data2(:,26);
            x5pos=data2(:,29);y5pos=data2(:,30);z5pos=data2(:,31);phi5pos=data2(:,32);theta5pos=data2(:,33);
        end
    end
end

subplot(5,3,1)
plot(1:length(x1),x1)
hold all
plot(1:length(x1pos),x1pos)
subplot(5,3,2)
plot(1:length(y1),y1,1:length(y1pos),y1pos)
subplot(5,3,3)
plot(1:length(z1),z1,1:length(z1pos),z1pos)
subplot(5,3,4)
plot(1:length(x2),x2,1:length(x2pos),x2pos)
subplot(5,3,5)
plot(1:length(y2),y2,1:length(y2pos),y2pos)
subplot(5,3,6)
plot(1:length(z2),z2,1:length(z2pos),z2pos)
subplot(5,3,7)
plot(1:length(x3),x3,1:length(x3pos),x3pos)
subplot(5,3,8)
plot(1:length(y3),y3,1:length(y3pos),y3pos)
subplot(5,3,9)
plot(1:length(z3),z3,1:length(z3pos),z3pos)
subplot(5,3,10)
plot(1:length(x4),x4,1:length(x4pos),x4pos)
subplot(5,3,11)
plot(1:length(y4),y4,1:length(y4pos),y4pos)
subplot(5,3,12)
plot(1:length(z4),z4,1:length(z4pos),z4pos)
subplot(5,3,13)
plot(1:length(x5),x5,1:length(x5pos),x5pos)
subplot(5,3,14)
plot(1:length(y5),y5,1:length(y5pos),y5pos)
subplot(5,3,15)
plot(1:length(z5),z5,1:length(z5pos),z5pos)