close all
clear all
%
f='folha';
pos='xyz';
method={'GOLD', 'RAF','WMR','SSR'};
barh=-15:0.1:15;
TableR=zeros(4,9);

%% bloco residual

for m=1:4 %4 methods
    TableR
    for p=1:3 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor10
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '10', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '10', pos(p));
        whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        %sensor9
        EnameR=strcat('D:\JawAnalysis\rafael', method{m}, '9', pos(p));
        EnameC=strcat('D:\JawAnalysis\chris', method{m}, '9', pos(p));
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:N301'),2);
        
        %% Quantification and Save
        cumbaras=cumsum(baras);
        cumbaras=cumbaras/max(cumbaras);
        figure, bar(cumbaras);
        
        % Quartil Range
        TableR(m,3*(p-1)+1)=min(barh(cumbaras>=0.75))-max(barh(cumbaras<=0.25));
        % Percentil Range
        TableR(m,3*(p-1)+2)=min(barh(cumbaras>=0.95))-max(barh(cumbaras<=0.05));
        % Worst Case
        TableR(m,3*(p-1)+3)=max([abs(min(barh(cumbaras==1))),abs(min(barh(cumbaras~=0)))]);
    end
end