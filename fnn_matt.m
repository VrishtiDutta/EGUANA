function em_dim = fnn_matt(x_data,emdel)
% False Nearest Neighbours
% Based on "Determining embedding dimension for phase-space reconstruction using 
% a geometrical construction", M. B. Kennel, R. Brown, and H.D.I. Abarbanel,
% Physical Review A, Vol 45, No 6, 15 March 1992, pp 3403-3411.

colordef white;% Use first minima obtained from AMI (optimal delay) as input 
p={ 'Please enter the delay to use for embedding (from AMI):',...
    'Please enter the number of embedding dimensions to use (NEW):'}; 
t='FNN <Embedding Dimension>';
def = {int2str(emdel),'6'};
r=inputdlg(p,t,1,def);

if ~isempty(r)
   m=abs(eval(r{1}));
   d_max=abs(eval(r{2}));
end
   
%m=input('Please enter the delay to use for embedding: ');
%d_max=input('Please enter the number of embedding dimensions to use: ');
counter=0;
wb = waitbar(counter,'Computing FNN. Please wait...');
wbstep=1./d_max;

xlength=length(x_data);
%[n,columns]=size(x_data);
n=xlength-((d_max)*m);
%n=xlength;
%n=1000;

R_tol = 15; % tolerance suggested by Kennel, Brown, & Abarbanel (1992) (15-20)
R_a = std(x_data); % estimate of attractor size, as per KBA
A_tol = 2; % suggested by KBA (1-2) -- try other values!

if size(x_data,1) ~= 1
   x_data = x_data';
end
if size(x_data,1) ~= 1
   error('x_data should be a vector of scalar data points.')
end

z = x_data(1:n);
y = [];
fnn_list = [];

global yq m_search L_done pqd pqr pqz b_upper b_lower sort_list node_list 

m_search = 2; % just search for the nearest point; the closest will be yq
              % itself and the next its neighbor

indx=[1:n];
for d = 1:d_max
    y = [y; z];
    %disp([1+m*d n+m*d])
    z = x_data(1+m*d:n+m*d);
    L = zeros(1,n);
    %fprintf('Partitioning data for d = %d\n',d)
    kd_part(y, z, 512); % put the data into 512-point bins <-- this needs optimization
    %fprintf('Checking for false nearest neighbors\n')
    
    for i = 1:length(indx)
        
        yq = y(:,indx(i)); % set up the next point to check
        
      % set up the bounds, which start at +/- infinity
        b_upper = Inf*ones(size(yq));
        b_lower = -b_upper;
        
      % and set up storage for the results
        pqd = Inf*ones(1,m_search);
        pqr = [];
        pqz = [];
        L_done = 0;
   
        kdsearch(1); % start searching at the root (node 1)
   
        diff = pqz(1) - pqz(2);
        if abs(diff) > pqd(2)*R_tol L(i) = 1; end
        if sqrt(pqd(2)^2+diff^2)/R_a > A_tol L(i) = 1; end
        
    end % i loop
    
    fnn_list = [fnn_list sum(L)/n];
    counter=counter+wbstep;
    waitbar(counter,wb);
end % d loop

close(wb)


stringdim={['Dimension'],
    [num2str((1:d_max)')]};

stringfnn={['  %FNN'],
    [num2str((fnn_list)')]};


fnn_instructions;

scnsize=get(0, 'ScreenSize');
set(gcf, 'Units' , 'Pixel');
set(gcf, 'Position', [0, 0.85*scnsize(4), 0.25*scnsize(3), 0.08*scnsize(4)]);

figure;set(gcf,'units','normalized','position',[.1 .25 .8 .55],'toolbar','figure','menubar','none');
%subplotdims=[.2 .8];
subplot(1,2,1);plot(1:d_max,fnn_list,'b:',1:d_max,fnn_list,'ko');
set(gca,'units','normalized','position',[0.1300    0.1100    0.5    0.815])

%title(filename);
xlabel('Embedding Dimensions');ylabel('%False Nearest Neighbors');
fnnout=uicontrol('style','text','units','normalized','position',[0.70 0.1 .09 .84],'fontsize',11,'backgroundcolor',[.8 .8 .8],'horizontalalignment','center');
fnnout2=uicontrol('style','text','units','normalized','position',[0.81 0.1 .2 .84],'fontsize',11,'backgroundcolor',[.8 .8 .8],'horizontalalignment','left');

set(fnnout,'string',stringdim)
set(fnnout2,'string',stringfnn)
a = ginput(1);
em_dim = a(1);
close;
close fnn_instructions;