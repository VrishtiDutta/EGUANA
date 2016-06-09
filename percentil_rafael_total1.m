close all
clear all
%
f='folha';
pos='xyz';
method={'RAF','WMR','SSR'};
barh=-15:0.1:15;
TableT=zeros(3,9);

%% bloco residual

for m=1:3 %3 methods
    TableT
    for p=1:3 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1 
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '1', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '1', pos(p));
        whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        %sensor2
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '2', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '2', pos(p));
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        %sensor3
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '3', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '3', pos(p));
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        %sensor7
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '7', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '7', pos(p));
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
        % Quartil Range
        TableT(m,3*(p-1)+1)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        TableT(m,3*(p-1)+2)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        TableT(m,3*(p-1)+3)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end