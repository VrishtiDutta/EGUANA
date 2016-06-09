function em_delay = ami_matt(x)


r{1} = [];
r{2} = [];

%warning('off','MATLAB:dispatcher:InexactMatch');
colordef white;
p={ 'Please enter the lag start:',...
    'Please enter the lag end:'};
t='AMI <Lag>';
def = {'0','100'};
r=inputdlg(p,t,1,def);



if ~isempty(r{1}) && ~isempty(r{2})
   lagstart=abs(eval(r{1}));
   lagend=abs(eval(r{2}));
   lag= [lagstart:lagend];
%filename=input('Please enter the filename: ','s');
%lagstart=input('Please enter the lag start: ');
%lagend=input('Please enter the lag end: ');
  
%end  
%x=load(filename);
y=x;

x=x(:);
y=y(:);
n=length(x);


% The mutual average information
x=x-min(x);   
x=x*(1-eps)/max(x);
y=y-min(y);
y=y*(1-eps)/max(y);

v=zeros(size(lag));
lastbins=nan;
counter=0;
wb = waitbar(counter,'Computing AMI. Please wait...');
wbstep=1./(lagend-lagstart);

 for ii=1:length(lag)

    abslag=abs(lag(ii));
    
    % Define the number of bins
    bins=floor(1+log2(n-abslag)+0.5);%as mai.m
    if bins~=lastbins
        binx=floor(x*bins)+1;
        biny=floor(y*bins)+1;
    end
    lastbins=bins;

    Pxy=zeros(bins);
    
	for jj=1:n-abslag
        kk=jj+abslag;
        if lag(ii)<0 
            temp=jj;jj=kk;kk=temp;%swap
        end
        Pxy(binx(kk),biny(jj))=Pxy(binx(kk),biny(jj))+1;
    end
    Pxy=Pxy/(n-abslag);
    Pxy=Pxy+eps; %avoid division and log of zero
    Px=sum(Pxy,2);
    Py=sum(Pxy,1);
    
    q=Pxy./(Px*Py);
    
    q=Pxy.*log2(q);
    
    v(ii)=sum(q(:))/log2(bins); %log2bins is what you get if x=y.

    counter=counter+wbstep;
    waitbar(counter,wb);
 end
close(wb)


ami_instructions;

scnsize=get(0, 'ScreenSize');
set(gcf, 'Units' , 'Pixel');
set(gcf, 'Position', [0, 0.8*scnsize(4), 0.25*scnsize(3), 0.08*scnsize(4)]);

figure;
set(gcf,'toolbar','figure','MenuBar','none','name','Average Mutual Information')
plot(lag,v,'ko',lag,v,'b:','MarkerSize',4)
xlabel('Delay (data points)')
ylabel('Average Mutual Information (bits)')

a = ginput(1);
em_delay = round(a(1));
end
close ami_instructions;
close;
