clear all

dir = uigetdir('','Select path for input files.');

trialnum = inputdlg({'Input trial number for trial start:','Input trial number for trial end:'});

% dist = zeros(str2double(trialnum{2})-1-str2double(trialnum{1}),1);

coord = zeros(str2double(trialnum{2})-str2double(trialnum{1})+1,3);

for num = str2double(trialnum{1}):str2double(trialnum{2})
    
    if length(num2str(num)) == 2
        addzero = '00';
    else
        addzero = '0';
    end
    filename = [dir filesep 'rawpos' filesep addzero num2str(num) '.pos'];
    f = fopen(filename, 'r');
    if f ~= -1
        
        array = fread(f,[84 inf], 'single');
        data = array';
        fclose(f);
        
        x1 = mean(data(:,1)); y1 = mean(data(:,2)); z1 = mean(data(:,3));
        coord(num-str2double(trialnum{1})+1,:) = [x1 y1 z1];
    end
    
%     if length(num2str(num+1)) == 2
%         addzero = '00';
%     else
%         addzero = '0';
%     end
%     filename = [dir filesep 'rawpos' filesep addzero num2str(num+1) '.pos'];
%     f = fopen(filename, 'r');
%     if f ~= -1
%         
%         array = fread(f,[84 inf], 'single');
%         data = array';
%         fclose(f);
%         
%         x2=mean(data(:,1));y2=mean(data(:,2));z2=mean(data(:,3));
%     end
%     
%     dist(num) = pdist([x1, y1, z1; x2, y2, z2], 'euclidean');
    
end