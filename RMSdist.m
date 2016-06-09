clear all

dir = uigetdir('','Select path for input files.');

rmserror = zeros(10,1);
rmserrself = zeros(100,1);
rmserrstat = zeros(100,1);
meandist = zeros(100,1);
meandist2 = zeros(100,1);
meandist3 = zeros(100,1);
xcoord = zeros(200,1);
ycoord = zeros(200,1);
zcoord = zeros(200,1);
xcoord2 = zeros(200,1);
ycoord2 = zeros(200,1);
zcoord2 = zeros(200,1);
xcoord3 = zeros(200,1);
ycoord3 = zeros(200,1);
zcoord3 = zeros(200,1);
xcoord4 = zeros(200,1);
ycoord4 = zeros(200,1);
zcoord4 = zeros(200,1);

trialnum = inputdlg({'Input trial number for static position:','Input trial number for trial start:','Input trial number for trial end:'});

if length(trialnum{1}) == 1
    addzero = '000';
elseif length(trialnum{1}) == 2
    addzero = '00';
elseif length(trialnum{1}) == 3
    addzero = '0';
end
filename = [dir filesep 'rawpos' filesep addzero trialnum{1} '.pos'];
f = fopen(filename, 'r');
if f ~= -1
    line1 = fgetl(f);
    line2 = fgetl(f); %has header size
    frewind(f);
    fseek(f,str2num(line2),'bof');%70
    array = fread(f,[112 inf],'single');
    %     array = fread(f,[84 inf],'single');
    data = array';
    fclose(f);
    
%     x1=data(:,29);y1=data(:,30);z1=data(:,31);
    x1=data(:,29);y1=data(:,30);z1=data(:,31);
    x2=data(:,78);y2=data(:,79);z2=data(:,80);
    x3=data(:,71);y3=data(:,72);z3=data(:,73);
    x4=data(:,22);y4=data(:,23);z4=data(:,24);
%     x1=data(:,1);y1=data(:,2);z1=data(:,3);
%     x2=data(:,8);y2=data(:,9);z2=data(:,10);
%     x3=data(:,15);y3=data(:,16);z3=data(:,17);
%     x4=data(:,22);y4=data(:,23);z4=data(:,24);
    
    
    dist = zeros(length(x1),1);
    dist2 = zeros(length(x1),1);
    dist3 = zeros(length(x1),1);
    statdist = zeros(length(x1),1);
    
    xcoord(1) = mean(x1);
    ycoord(1) = mean(y1);
    zcoord(1) = mean(z1);
    
    for i = 1:length(x1)
        dist(i) = pdist([x1(i), y1(i), z1(i); x2(i), y2(i), z2(i)], 'euclidean');
        dist2(i) = pdist([x2(i), y2(i), z2(i); x3(i), y3(i), z3(i)], 'euclidean');
        dist3(i) = pdist([x3(i), y3(i), z3(i); x4(i), y4(i), z4(i)], 'euclidean');
        statdist(i) = pdist([x1(i), y1(i), z1(i); xcoord(1), ycoord(1), zcoord(1)], 'euclidean');
    end
    
    dist(1) = dist(2);
    dist2(1) = dist2(2);
    dist3(1) = dist3(2);
    meandist(1) = mean(dist);
    meandist2(1) = mean(dist2);
    meandist3(1) = mean(dist3);
    rmserrself(1) = sqrt(sum((dist(:)-meandist(1)).^2)/numel(dist));
    
    rmserrstat(1) = sqrt(sum((statdist).^2)/numel(dist));
    
end

c = 2;
for num = str2double(trialnum{2}):str2double(trialnum{3})
    
    disp(num)
    if length(num2str(num)) == 1
        addzero = '000';
    elseif length(num2str(num)) == 2
        addzero = '00';
    elseif length(num2str(num)) == 3
        addzero = '0';
    end
    filename = [dir filesep 'rawpos' filesep addzero num2str(num) '.pos'];
    f = fopen(filename, 'r');
    if f ~= -1
        
        fseek(f,70,'bof');
        array = fread(f,[112 inf],'single');
%         array = fread(f,[84 inf],'single');
        data = array';
        fclose(f);
        
%         x1=data(:,29);y1=data(:,30);z1=data(:,31);
%         x2=data(:,36);y2=data(:,37);z2=data(:,38);
%         x1=data(:,1);y1=data(:,2);z1=data(:,3);
%         x2=data(:,8);y2=data(:,9);z2=data(:,10);
%         x3=data(:,15);y3=data(:,16);z3=data(:,17);
%         x4=data(:,22);y4=data(:,23);z4=data(:,24);
    x1=data(:,29);y1=data(:,30);z1=data(:,31);
    x2=data(:,78);y2=data(:,79);z2=data(:,80);
    x3=data(:,71);y3=data(:,72);z3=data(:,73);
    x4=data(:,22);y4=data(:,23);z4=data(:,24);
        
        xcoord(c) = mean(x1);
        ycoord(c) = mean(y1);
        zcoord(c) = mean(z1);
        xcoord2(c) = mean(x2);
        ycoord2(c) = mean(y2);
        zcoord2(c) = mean(z2);
        xcoord3(c) = mean(x3);
        ycoord3(c) = mean(y3);
        zcoord3(c) = mean(z3);
        xcoord4(c) = mean(x4);
        ycoord4(c) = mean(y4);
        zcoord4(c) = mean(z4);
        
        dist = zeros(length(x1),1);
        dist2 = zeros(length(x1),1);
        dist3 = zeros(length(x1),1);
        for i = 1:length(x1)
            dist(i) = pdist([x1(i), y1(i), z1(i); x2(i), y2(i), z2(i)], 'euclidean');
            dist2(i) = pdist([x2(i), y2(i), z2(i); x3(i), y3(i), z3(i)], 'euclidean');
            dist3(i) = pdist([x3(i), y3(i), z3(i); x4(i), y4(i), z4(i)], 'euclidean');
            statdist(i) = pdist([x1(i), y1(i), z1(i); xcoord(c), ycoord(c), zcoord(c)], 'euclidean');
        end
        
        dist(1) = dist(2);
        dist2(1) = dist2(2);
        dist3(1) = dist3(2);
        meandist(c) = mean(dist);
        meandist2(c) = mean(dist2);
        meandist3(c) = mean(dist3);
        rmserror(c) = sqrt(sum((dist(:)-meandist(1)).^2)/numel(dist));
        rmserrself(c) = sqrt(sum((dist(:)-meandist(c)).^2)/numel(dist));
        rmserrstat(c) = sqrt(sum((statdist).^2)/numel(dist));
        
        c = c+1;
    end
end

hc =[xcoord(2) ycoord(2) zcoord(2)
    xcoord2(2) ycoord2(2) zcoord2(2)
    xcoord3(2) ycoord3(2) zcoord3(2)
    xcoord4(2) ycoord4(2) zcoord4(2)];