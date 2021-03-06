close all
clear all
clc
%
f='folha';
pos='e';
method={'G','R','W','S'};
barh=-15:0.1:15;
Table1=zeros(4,4);



%% bloco coil1

for m=1:4 %6 comparation of methods
    Table1
    for p=1 %3 position
        %% Inicializing
        baras=zeros(301,1);
        %% Reading
        % sensor1
        EnameR=strcat('D:\JawAnalysis_part3\rafaelResidual', method{m}, pos(p),'9');
        EnameC=strcat('D:\JawAnalysis_part3\chrisResidual', method{m}, pos(p),'9');
        %whos EnameR EnameC
        baras=baras+sum(xlsread(EnameR,f,'AG1:AS301'),2)+...
            sum(xlsread(EnameR,f,'AU1:AX301'),2);
        baras=baras+sum(xlsread(EnameC,f,'C1:E301'),2)+...
            sum(xlsread(EnameC,f,'G1:L301'),2);

        EnameR=strcat('D:\JawAnalysis_part3\rafaelResidual', method{m}, pos(p),'10');
        EnameC=strcat('D:\JawAnalysis_part3\chrisResidual', method{m}, pos(p),'10');
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


