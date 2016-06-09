close all
clear all
%
f='folha';
pos='xyze';
method={'RG','WG','SG','RW','RS','WS'};
barh=-15:0.1:15;
Table1=zeros(6,16);
Table2=zeros(6,16);
Table3=zeros(6,16);
Table7=zeros(6,16);


%% bloco coil1

for m=1:6 %6 comparation of methods
    Table1
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'1');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'1');
        %whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
        %Median
        Table1(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table1(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table1(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table1(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end

for m=1:6 %4 methods
    Table2
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m},  pos(p),'2');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'2');
        %%whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
        %Median
        Table2(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table2(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table2(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table2(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end

for m=1:6 %4 methods
    Table3
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'3');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'3');
        %whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
        %Median
        Table3(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table3(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table3(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table3(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end

for m=1:6 %4 methods
    Table7
    for p=1:4 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part2\rafael', method{m}, pos(p),'7');
        EnameC=strcat('D:\JawAnalysis_part2\chris', method{m}, pos(p),'7');
        %whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
         %Median
        Table7(m,4*(p-1)+1)=min(barh(cumbaras>0.5));
        % Quartil Range
        Table7(m,4*(p-1)+2)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        Table7(m,4*(p-1)+3)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        Table7(m,4*(p-1)+4)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end

