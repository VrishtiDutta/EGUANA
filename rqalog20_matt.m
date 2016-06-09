function rad = rqalog20_matt(data,emdel,emdim)

[n,m]=size(data);
if m~=1
    disp('Your data must consist of a single column of data.  Press any key to quit');
    pause;
    return
end

rescale=0;
%disp(FileName)

colordef white;% Use first minima obtained from AMI (optimal delay) as input 
p={ 'Please enter the delay to use for embedding (AMI):',...
    'Please enter the number of embedding dimensions to use (FNN):',....
    'How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist (NEW): ',...
    'Enter your starting radius (NEW): ',...
    'Enter your ending radius (NEW): ',...
    'Enter your radius step size (NEW): '}; 

def = {int2str(emdel),int2str(emdim),'1','0','30','1'};
t='RQAlog20 <Radius>';
r=inputdlg(p,t,1,def);

if ~isempty(r)
   delay=abs(eval(r{1}));
   embed=abs(eval(r{2}));
   rescale=abs(eval(r{3}));
   rstart=abs(eval(r{4}));
   rend=abs(eval(r{5}));
   rstep=abs(eval(r{6}));
end


%delay=input('Enter the delay (in datapoints) to use for embedding: ');
%embed=input('Enter the number of embedding dimensions (integer only): ');
%while (rescale ~=1) & (rescale~= 2)
 %   rescale=input('How would you like to rescale your distances? 1=Mean Dist, 2 = Max Dist: ');
%end
%rstart=input('Enter your starting radius: ');
%rend=input('Enter your ending radius: ');
%rstep=input('Enter your radius step size: ');


clear euclid
[rows,cols]=size(data);



disp(['Please Wait']);tic
%Create surrogate dimension data vectors
for loop=1:embed
    vectorstart=(loop-1).*delay+1;
    vectorend=rows-((embed-loop).*delay);
    eval(['v' num2str(loop) '=data(' num2str(vectorstart) ':' num2str(vectorend) ');']);
end %embedding loop

%Create matrix from vectors to use for distance matrix calcs
for loop=1:embed
    if loop==1
        dimdata=v1;
    else
        eval(['dimdata=[dimdata v' num2str(loop) '];']);
    end %End if statement
end %loop loop


%Calculate Euclidean Distance Matrix dm

[vlength,columns]=size(v1);

%Compute euclidean distance matrix
dm=squareform(pdist(dimdata));  % use distmat instead of pdist (statistical toolbox required)
                                % for squareform write another function

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
for loop=1:steps
    counter=counter+step;
    waitbar(counter,wb);

    %Compute recurrence matrix
    [r,c]=find(dmrescale<=radius(loop));

    [recurs,nothing]=size(r);

    %disp(['Get triangular regions']);tic
    newindexr=find(r>c);
    newindexc=find(c>r);
    lowertricoord=[r(newindexr) c(newindexr)];
    uppertricoord=[r(newindexc) c(newindexc)];

    [numrecurs,nothing]=size(uppertricoord);
    percentrecurs(loop)=(numrecurs./((vlength.^2-vlength)./2)).*100;
end%end radius loop
close(wb)

rqalog20_instructions;
scnsize=get(0, 'ScreenSize');
set(gcf, 'Units' , 'Pixel');
set(gcf, 'Position', [0, 0.8*scnsize(4), 0.25*scnsize(3), 0.13*scnsize(4)]);

figure;
temp=find(percentrecurs<20);
ymin=min(percentrecurs);ymax=max(temp);
loglog(rstart:rstep:rend,percentrecurs,'bo:')
xlim([rstart radius(ymax)]);ylim([0 percentrecurs(ymax)]);
set(gca,'ytick',[0:1:ymax])
set(gca,'xtick',[round(rstart):1:rend])
set(gcf,'name','RQA Log-Log up to 20% Recurrence')
switch rescale
    case 1
        %In the case of mean distance
        xlabel('Radius (%Mean Distance)')
        ylabel('% Recurrence');%title(FileName)

    case 2
        %In the case of max distance
        xlabel('Radius (%Maximum Distance)')
        ylabel('% Recurrence');%title(FileName)

end%End switch rescale
a = ginput(1);
rad = a(1);
close rqalog20_instructions;
close;
