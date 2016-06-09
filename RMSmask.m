clear all

num = str2double(inputdlg('How many trials?'));

[MASKfilename, MASKpathname] = uigetfile('*.mat','Select MASK file');
trialnum = sscanf(MASKfilename,'Calvin_Dynamic_trial_%f');

rmserror = zeros(10,1);
rmserrself = zeros(100,1);
rmserrstat = zeros(100,1);
meandist = zeros(100,1);
meandist2 = zeros(100,1);
meandist3 = zeros(100,1);
xcoord1 = zeros(200,1);
ycoord1 = zeros(200,1);
zcoord1 = zeros(200,1);
xcoord2 = zeros(200,1);
ycoord2 = zeros(200,1);
zcoord2 = zeros(200,1);
xcoord3 = zeros(200,1);
ycoord3 = zeros(200,1);
zcoord3 = zeros(200,1);

for c = 1:num
    
    disp(trialnum)
    MASKfilename = ['Calvin_Dynamic_trial_' num2str(trialnum) '.mat'];
    MASKstruct = load([MASKpathname MASKfilename]);
    trialnum = trialnum+1;
    
    positionfile = zeros(5,12,length(MASKstruct.pos));
    
    positionfile(1:3,1:size(MASKstruct.pos,2),:) = MASKstruct.pos;
    positionfile = positionfile*10;
    positionfile(:,:,1:20) = [];
    
    x1=squeeze(positionfile(1,1,:)); y1=squeeze(positionfile(2,1,:)); z1=squeeze(positionfile(3,1,:));
    x2=squeeze(positionfile(1,2,:)); y2=squeeze(positionfile(2,2,:)); z2=squeeze(positionfile(3,2,:));
    x3=squeeze(positionfile(1,3,:)); y3=squeeze(positionfile(2,3,:)); z3=squeeze(positionfile(3,3,:));
    x4=squeeze(positionfile(1,4,:)); y4=squeeze(positionfile(2,4,:)); z4=squeeze(positionfile(3,4,:));
    
    xcoord1(c) = mean(x1);
    ycoord1(c) = mean(y1);
    zcoord1(c) = mean(z1);
    xcoord2(c) = mean(x2);
    ycoord2(c) = mean(y2);
    zcoord2(c) = mean(z2);
    xcoord3(c) = mean(x3);
    ycoord3(c) = mean(y3);
    zcoord3(c) = mean(z3);
    
    dist = zeros(length(x1),1);
    dist2 = zeros(length(x1),1);
    dist3 = zeros(length(x1),1);
    statdist = zeros(length(x1),1);
    
    for i = 1:length(x1)
        dist(i) = pdist([x1(i), y1(i), z1(i); x2(i), y2(i), z2(i)], 'euclidean');
        dist2(i) = pdist([x2(i), y2(i), z2(i); x3(i), y3(i), z3(i)], 'euclidean');
        dist3(i) = pdist([x3(i), y3(i), z3(i); x4(i), y4(i), z4(i)], 'euclidean');
        statdist(i) = pdist([x1(i), y1(i), z1(i); xcoord1(c), ycoord1(c), zcoord1(c)], 'euclidean');
    end
    
    meandist(c) = mean(dist);
    meandist2(c) = mean(dist2);
    meandist3(c) = mean(dist3);
    rmserror(c) = sqrt(sum((dist(:)-meandist(1)).^2)/numel(dist));
    rmserrself(c) = sqrt(sum((dist(:)-meandist(c)).^2)/numel(dist));
    rmserrstat(c) = sqrt(sum((statdist).^2)/numel(dist));
    
end

% c = 2;
%
%
%     disp(num)
%
%
%         x1=data(:,1);y1=data(:,2);z1=data(:,3);
%         x2=data(:,8);y2=data(:,9);z2=data(:,10);
%         x3=data(:,15);y3=data(:,16);z3=data(:,17);
%         x4=data(:,22);y4=data(:,23);z4=data(:,24);
%
%         dist = zeros(length(x1),1);
%         dist2 = zeros(length(x1),1);
%         dist3 = zeros(length(x1),1);
%         for i = 1:length(x1)
%             dist(i) = pdist([x1(i), y1(i), z1(i); x2(i), y2(i), z2(i)], 'euclidean');
%             dist2(i) = pdist([x2(i), y2(i), z2(i); x3(i), y3(i), z3(i)], 'euclidean');
%             dist3(i) = pdist([x3(i), y3(i), z3(i); x4(i), y4(i), z4(i)], 'euclidean');
%         end
%
%         dist(1) = dist(2);
%         dist2(1) = dist2(2);
%         dist3(1) = dist3(2);
%         meandist(c) = mean(dist);
%         meandist2(c) = mean(dist2);
%         meandist3(c) = mean(dist3);
%         rmserror(c) = sqrt(sum((dist(:)-meandist(1)).^2)/numel(dist));
%         rmserrself(c) = sqrt(sum((dist(:)-meandist(c)).^2)/numel(dist));
%
%         xcoord(c) = mean(x1);
%         ycoord(c) = mean(y1);
%         zcoord(c) = mean(z1);
%         c = c+1;
%
