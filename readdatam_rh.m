%function [x1,x2,x3,x4,x5,y1,y2,y3,y4,y5]=readdatam(filename)
%read movement data
function [x1,x2,x3,x4,x5,y1,y2,y3,y4,y5]=readdatam_rh(filename)
fp=fopen(filename,'r');%open the binary file.
if (fp==-1)% error message.
   qstring='File not found. You might enter wrong file name.';
   %reply=...
   questdlg(qstring,'ERROR','OK','OK');
end

listsize=1;
A=fread(fp,10,'uint16'); % read in data.
% assign data to each channel
while ~isempty(A)
x1(listsize)=A(1);
x2(listsize)=A(2);
x3(listsize)=A(3);
x4(listsize)=A(4);
x5(listsize)=A(5);
y1(listsize)=A(6);
y2(listsize)=A(7);
y3(listsize)=A(8);
y4(listsize)=A(9);
y5(listsize)=A(10);
listsize=listsize+1;
A=fread(fp,10,'uint16');
end
fclose(fp);
x1=(x1)';% change the row to the column on each channel.
x2=(x2)';
x3=(x3)';
x4=(x4)';
x5=(x5)';
y1=(y1)';
y2=(y2)';
y3=(y3)';
y4=(y4)';
y5=(y5)';
