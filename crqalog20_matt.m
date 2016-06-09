function rad = crqalog20_matt(data1,data2,FileName1,FileName2,ami1,fnn1);


[n,m]=size(data1);
if m~=1
    disp('Your data must consist of a single column of data.  Press any key to quit');
    pause;
    return
end


[n,m]=size(data2);
if m~=1
    disp('Your data must consist of a single column of data.  Press any key to quit');
    pause;
    return
end


rescale=0;
%disp([FileName1 ' ' FileName2])

colordef white;
p={ 'Please enter the delay to use for embedding (AMI):',...
    'Please enter the number of embedding dimensions to use (FNN):',....
    'How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist (NEW): ',...
    'How would you like to rescale your source data? 1=Unit Inteval, 2 = Zscore (NEW):'...
    'Enter your starting radius (NEW): ',...
    'Enter your ending radius (NEW): ',...
    'Enter your radius step size (NEW): '}; 

def = {int2str(ami1),int2str(fnn1),'1','2','0','30','1'};

t='CRQA <Cross Recurrence Plot>';
r=inputdlg(p,t,1,def);

if ~isempty(r)
   delay=abs(eval(r{1}));
   embed=abs(eval(r{2}));
   
   while (rescale ~=1) & (rescale~= 2)
   rescale=abs(eval(r{3}));
   end
   
      normalize=0;
while (normalize ~=1) & (normalize~= 2)
    normalize=abs(eval(r{4}));
end

switch normalize
    case 1
        data1=(data1-min(data1));
        data1=data1./max(data1);
        data2=(data2-min(data2));
        data2=data2./max(data2);

    case 2
        data1=zscore(data1);data2=zscore(data2);
end  %End switch
   
   rstart=abs(eval(r{5}));
   rend=abs(eval(r{6}));
   rstep=abs(eval(r{7}));

end

%delay=input('Enter the delay (in datapoints) to use for embedding: ');
%embed=input('Enter the number of embedding dimensions (integer only): ');
%while (rescale ~=1) & (rescale~= 2)
 %   rescale=input('How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist: ');
%end

clear euclid
[rows,cols]=size(data1);



%disp(['Creating vectors']);tic
%Create surrogate dimension data vectors
for loop=1:embed
    vectorstart=(loop-1).*delay+1;
    vectorend=rows-((embed-loop).*delay);
    eval(['v1' num2str(loop) '=data1(' num2str(vectorstart) ':' num2str(vectorend) ');']);
end %embedding loop

for loop=1:embed
    vectorstart=(loop-1).*delay+1;
    vectorend=rows-((embed-loop).*delay);
    eval(['v2' num2str(loop) '=data2(' num2str(vectorstart) ':' num2str(vectorend) ');']);
end %embedding loop




%Create matrix from vectors to use for distance matrix calcs
for loop=1:embed
    if loop==1
        dimdata1=v11;
    else
        eval(['dimdata1=[dimdata1 v1' num2str(loop) '];']);
    end %End if statement
end %loop loop

for loop=1:embed
    if loop==1
        dimdata2=v21;
    else
        eval(['dimdata2=[dimdata2 v2' num2str(loop) '];']);
    end %End if statement
end %loop loop

dimdata=[dimdata1;dimdata2];



%Calculate Euclidean Distance Matrix dm

[vlength,columns]=size(v11);


%Compute euclidean distance matrix

dmtemp=squareform(pdist(dimdata));

dm=dmtemp(1:vlength,vlength+1:2*vlength);


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

radius=rstart:rstep:rend;
counter=0;
wb = waitbar(counter,'Computing %recur for range of radius values. Please wait...');
step=1./((rend-rstart+rstep)./rstep);
radiusrange=rstart:rstep:rend;
steps=length(radiusrange);

clear percentrecurs

for loop=1:steps


    %Compute recurrence matrix
    [r,c]=find(dmrescale<=radius(loop));



    [recurs,nothing]=size(r);

    %disp(['Get triangular regions']);tic
    newindexr=find(r>c);
    newindexc=find(c>r);
    newindexd=find(r==c);
    lowertricoord=[r(newindexr) c(newindexr)];
    uppertricoord=[r(newindexc) c(newindexc)];
    diagcoord=[r(newindexd) c(newindexd)];

    %disp(['Calcualte recur on one triangular region']);tic
    [numrecursu,nothing]=size(uppertricoord);
    [numrecursl,nothing]=size(lowertricoord);
    [numrecursd,nothing]=size(diagcoord);
    numrecurs=numrecursu+numrecursl+numrecursd;

    percentrecurs(loop)=(numrecurs./(vlength.^2)).*100;

    counter=counter+(1/steps);
    waitbar(counter,wb);
end
close(wb)
temp=find(percentrecurs<20);
ymin=min(percentrecurs);ymax=max(temp);

rqalog20_instructions;
scnsize=get(0, 'ScreenSize');
set(gcf, 'Units' , 'Pixel');
set(gcf, 'Position', [0, 0.8*scnsize(4), 0.25*scnsize(3), 0.13*scnsize(4)]);


figure;loglog(rstart:rstep:rend,percentrecurs,'bo:')
xlim([rstart radius(ymax)]);ylim([0 percentrecurs(ymax)]);
set(gca,'ytick',[0:1:ymax])
set(gca,'xtick',[round(rstart):1:rend])
%xlabel('Radius');ylabel('% Recurrence')
set(gcf,'name','CRQA Log-Log up to 20% Recurrence','toolbar','figure','MenuBar','none')
switch rescale
    case 1
        %In the case of mean distance
        xlabel('Radius (%Mean Distance)')
        ylabel('% (Cross) Recurrence');title([FileName1 ' compared to ' FileName2])

    case 2
        %In the case of max distance
        xlabel('Radius (%Maximum Distance)')
        ylabel('% (Cross) Recurrence');title([FileName1 ' compared to ' FileName2])

end%End switch rescale
a = ginput(1);
rad = a(1);
close rqalog20_instructions;
close;
