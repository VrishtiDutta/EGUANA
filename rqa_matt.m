function [delay, embed, radius, rescaletype, minline, numrecurs, numlines, percentrecurs, pdeter,...
    entropy, RelEnt, maxline, meanline, trend] = rqa_matt(data,emdel,emdim,rad)




[n,m]=size(data);
if m~=1
    disp('Your data must consist of a single column of data.  Press any key to quit');
    pause;
    return
end


rescale=0;
%disp(FileName)


colordef white;
p={ 'Please enter the delay to use for embedding:',...
    'Please enter the number of embedding dimensions to use:',....
    'What % of the Mean Dist would you like to use for a radius?:'...
    'How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist: '}; 

def = {int2str(emdel),int2str(emdim),int2str(rad),'1'};
t='RQA <Recurrence Plot>';
r=inputdlg(p,t,1,def);

if ~isempty(r)
   delay=abs(eval(r{1}));
   embed=abs(eval(r{2}));
   
   while (rescale ~=1) & (rescale~= 2)
   rescale=abs(eval(r{4}));
   end
   
   switch rescale
       case 1 
           radius=abs(eval(r{3}));
           rescaletype='Mean Distance';
       case 2
            radius=abs(eval(r{3}));
           rescaletype='Maximum Distance';
   end % End switch
   
end

%
%delay=input('Enter the delay (in datapoints) to use for embedding: ');
%embed=input('Enter the number of embedding dimensions (integer only): ');
%while (rescale ~=1) & (rescale~= 2)
%    rescale=input('How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist: ');
%end
%switch rescale
%   case 1
%        radius=input('What % of the Mean Dist would you like to use for a radius?: ');
%        rescaletype='Mean Distance';
%    case 2
%        radius=input('What % of the Max Dist would you like to use for a radius?: ');
%       rescaletype='Maximum Distance';
%end  %End switch


counter=0;
wb = waitbar(counter,'Computing Recurrence Matrix. Please wait...');

clear euclid
[rows,cols]=size(data);


counter=counter+.1;
waitbar(counter,wb);

%disp(['Creating vectors']);tic
%Create surrogate dimension data vectors
for loop=1:embed
    vectorstart=(loop-1).*delay+1;
    vectorend=rows-((embed-loop).*delay);
    eval(['v' num2str(loop) '=data(' num2str(vectorstart) ':' num2str(vectorend) ');']);
end %embedding loop
%plot3(vector1,vector2,vector3)

counter=counter+.1;
waitbar(counter,wb);


%Create matrix from vectors to use for distance matrix calcs
for loop=1:embed
    if loop==1
        dimdata=v1;
    else
        eval(['dimdata=[dimdata v' num2str(loop) '];']);
    end %End if statement
end %loop loop

counter=counter+.1;
waitbar(counter,wb);

%Calculate Euclidean Distance Matrix dm

[vlength,columns]=size(v1);

%Compute euclidean distance matrix
dm=squareform(pdist(dimdata));

counter=counter+.1;
waitbar(counter,wb);

%disp(['Finding distances within radius']);tic
%Find indeces of the distance matrix that fall within prescribed radius.
switch rescale
    case 1
        %Create a distance matrix that is re-scaled to the mean distance
        rescaledist=mean(mean(dm)');
        dmrescale=(dm./rescaledist).*100;
    case 2
        %Create a distance matrix that is re-scaled to the max distance
        rescaledist=max(max(dm)');
        dmrescale=(dm./rescaledist).*100;
end%End switch rescale

%Compute recurrence matrix
[r,c]=find(dmrescale<=radius);

S=sparse(r,c,1);     % Create a SPARSE matrix, S, use as the Recurrence maxtrix. 
                         % One could clear the DistanceMatrix to free memory at this
                         % point.

%recplot=plot(r,c,'k.');xlim([1 vlength]);ylim([1 vlength]);axis square;drawnow

counter=counter+.1;
waitbar(counter,wb);

[recurs,nothing]=size(r);

%disp(['Get triangular regions']);tic
newindexr=find(r>c);
newindexc=find(c>r);
%lowertricoord=[r(newindexr) c(newindexr)];
uppertri=triu(S,1);

%uppertricoord=[r(newindexc) c(newindexc)];
lowertri=tril(S,-1);



%disp(['Calcualte recur on one triangular region']);tic
numrecurs=nnz(uppertri);
percentrecurs=(numrecurs./((vlength.^2-vlength)./2)).*100;

counter=counter+.1;
waitbar(counter,wb);

clear lines

[B,d]=spdiags(uppertri);
%size(B)

%% COMPUTE TREND DATA
        
tindex=(length(S):-1:1)';
raw_trend=zeros(length(S),1);raw_trend(d)=sum(B); raw_trend=raw_trend./tindex.*100; 
[p,s]=polyfit(1:floor(length(S)*.9),raw_trend(1:floor(length(S)*.9))',1);
        trend=p(1,1)*1000; %fit to 90% of length, mult coefficent by 1000.



    
 
%% COMPUTING THE LINE COUNTS
minline=2; % set a minimum line length, this can become an option.

% This section finds the index of the zeros in the matrix B,
% which contains the diagonals of one triangle of the recurrence matrix
% (the idenity line excluded). The find command indexes the matrix sequentially
% from 1 to the total number of elements. The element numbers for a 2X2 matrix
% would be [1 3; 2 4]. You get a hit for every zero. If you take the
% difference of the resulting vector, minus 1, it yields the length of an
% interceding vector of ones, a line. Here is an e.g. using a row vector
% rather than a col. vector, since it types easier: B=[0 1 1 1 0], a line of
% length 3.  find(B==0) yields [1 5], diff([1 5])-1=3, the line length. So
% this solution finds line lengths in the interior of the B matrix, BUT
% fails if a line butts up against either edge of the B matrix, e.g. say
% B=[0 1 1 1 1], find(B==0) returns a 1, and you miss the line of length 4.
% A solution is to "bracket" B with a row of zeros at each top and bottom.

%"Bracket B with zeros"
B=[zeros(1,size(B,2)); B ; zeros(1,size(B,2))];
%Get list of line lengths, sorted from largest to smallest
lines=sort(diff(find(B==0))-1,'descend');

%Delete line counts less than the minimum.
lines(lines<minline)=[]; %lines(lines>200)=[]; % Can define a maximum line length too.
numlines=length(lines);
maxline=max(lines);
meanline=mean(lines);
    
   
    
%% COMPUTE ENTROPY, USE LOG BASE 2, DIVIDE BY MAX ENTROPY TO GET RELATIVE
%  ENTROPY
    [count,bin]=hist(lines,minline:maxline);
    total=sum(count);
    p=count./total;
    del=find(count==0); p(del)=[];
    entropy=-1*sum(p.*log2(p));
    % Transform to relative entropy: entropy/max entropy
    % More comparable across contexts and conditions.
    RelEnt=entropy/(-1*log2(1/length(bin)));

%% COMPUTE PERCENT DETERMINISM
    pdeter=(sum(lines)/numrecurs)*100;
    


string={['Delay=' num2str(delay)],
    ['# Embedding Dimensions=' num2str(embed)],
    ['Radius = ' num2str(radius) '% ' rescaletype],
    ['Line Length (min) =' num2str(minline) ' Recurrent Points'],
    ['# Recurrent Points = ' num2str(numrecurs)],
    ['# Lines = ' num2str(numlines)],
    ['%REC = ' num2str(percentrecurs)],
    ['%DET = ' num2str(pdeter)],
    ['ENTROPY = ' num2str(entropy)],
    ['RELATIVE ENTROPY = ' num2str(RelEnt)],
    ['MAXLINE = ' num2str(maxline)],
    ['MEANLINE = ' num2str(meanline)],
    ['TREND = ' num2str(trend)]};


counter=counter+.1;
waitbar(counter,wb);

close(wb)

figure
set(gcf,'units','normalized','position',[0 0 1 .93],'toolbar','figure','MenuBar','none','name','RQA')
subplot(2,2,1);seriesplot=plot(data);xlabel('data point');ylabel('x');%title(['Time series ' FileName]);
subplot(2,2,2);viewangle=get(gca,'cameraposition');
if embed==1
    spaceplot=plot(data);xlabel('data point');ylabel('x');%title(['Reconstructed Phase Space for ' FileName]);
elseif embed==2
    spaceplot=plot(v1,v2);xlabel('x(t)');ylabel('x(t + tau)');%title(['Reconstructed Phase Space for ' FileName])
else
    plot3(v1,v2,v3);xlabel('x(t)');ylabel(['x(t + ' int2str(delay) ')']);zlabel(['x(t + ' int2str(2.*delay) ')']);rotate3d %title(['Reconstructed Phase Space for ' FileName]);rotate3d
end
subplot(2,2,3);recplot=plot(r,c,'.m','MarkerSize',0.2,'MarkerEdgeColor',[1 .5 .2]);xlim([1 vlength]);ylim([1 vlength]);axis square;xlabel('i');ylabel('j');%title(['Recurrence Plot of ' FileName])

subplotdims=[.41 .4];
outbox=uicontrol('style','text','units','normalized','position',[0.55 0.1 subplotdims],'fontsize',13,'backgroundcolor',[.8 .8 .8],'horizontalalignment','left');
set(outbox,'string',string)

drawnow




