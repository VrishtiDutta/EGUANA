close all
clear all
%
f='folha';
pos='xyze';
method={'RG','WG','SG','RW','RS','WS'};
barh=-15:0.1:15;
Table10=zeros(6,16);
Table9=zeros(6,16);
TableT=zeros(6,16);


%% bloco coil1

for m=1:6 %6 comparation of methods
    m
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'10');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'10');
        %whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
                
        %Median
        Table10(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table10(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table10(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table10(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end

for m=1:6 %4 methods
    m
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m},  pos(p),'9');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'9');
        %%whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
                
        %Median
        Table9(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table9(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table9(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table9(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end


%% Total
for m=1:6 %3 methods
    m
    for p=1:4 %4 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1 
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'1');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'1');
        whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
        %sensor2
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'2');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'2');
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
        %sensor3
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'3');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'3');
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
        %sensor7
EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'7');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'7');
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
                %sensor9
EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'9');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'9');
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
                        %sensor10
EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'10');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'10');
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);
        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        %figure, bar(cumbaras);
        
        %Median
        TableT(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        TableT(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        TableT(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        TableT(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end


xlswrite('D:\JawAnalysis_part2\Tables',Table9,'Table9','D30:S35');
xlswrite('D:\JawAnalysis_part2\Tables',Table10,'Table10','D30:S35');
xlswrite('D:\JawAnalysis_part2\Tables',TableT,'TableT','D30:S35');