%**************************************************************************
%FUNCTION: loaddata
%Programmed by: Michael Novati, University of Toronto
%Date Created: June 30th, 2005
%Last Modified: June 30th, 2005
%**************************************************************************
%DESCRIPTION: 
%   Load a position file in proprietary format and return an array with 84
%   columns (12 sensors X 7 columns each) and number of rows representing
%   the number of samples (given rate is 200 samples per second)
%PARAMETERS:
%   'filename': the filename of the position data
%**************************************************************************
function [array, srate]=loaddata_jaw_rh(filename)
if fopen(filename,'r') == -1
   % reply=...
    questdlg('File does not exist.  Please ensure PATH is correct.',...
        'ERROR','OK','OK');
    array = -1;
else
    f = fopen(filename, 'r');
    line1 = fgetl(f);
    line2 = fgetl(f); %has header size
    frewind(f);
    check = fread(f,[1,2],'*char');
    if strcmp(check,'AG') == 1
        fseek(f,str2num(line2),'bof');
        array = fread(f,[112 inf],'single');
        srate = 250;
    else
        fseek(f,0,'bof');
        array = fread(f,[84 inf], 'single');
        srate = 200;
    end
    array = array';
    fclose(f);
    
end