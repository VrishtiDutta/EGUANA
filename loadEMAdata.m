function[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
    y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
    phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
    theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
    theta10,theta11,theta12] = loadEMAdata(filename)

array = loaddata(filename);

x1=array(:,1);y1=array(:,2);z1=array(:,3);phi1=array(:,4);theta1=array(:,5);
x2=array(:,8);y2=array(:,9);z2=array(:,10);phi2=array(:,11);theta2=array(:,12);
x3=array(:,15);y3=array(:,16);z3=array(:,17);phi3=array(:,18);theta3=array(:,19);
x4=array(:,22);y4=array(:,23);z4=array(:,24);phi4=array(:,25);theta4=array(:,26);
x5=array(:,29);y5=array(:,30);z5=array(:,31);phi5=array(:,32);theta5=array(:,33);
x6=array(:,36);y6=array(:,37);z6=array(:,38);phi6=array(:,39);theta6=array(:,40);
x7=array(:,43);y7=array(:,44);z7=array(:,45);phi7=array(:,46);theta7=array(:,47);
x8=array(:,50);y8=array(:,51);z8=array(:,52);phi8=array(:,53);theta8=array(:,54);
x9=array(:,57);y9=array(:,58);z9=array(:,59);phi9=array(:,60);theta9=array(:,61);
x10=array(:,64);y10=array(:,65);z10=array(:,66);phi10=array(:,67);theta10=array(:,68);
x11=array(:,71);y11=array(:,72);z11=array(:,73);phi11=array(:,74);theta11=array(:,75);
x12=array(:,78);y12=array(:,79);z12=array(:,80);phi12=array(:,81);theta12=array(:,82);

end

function [array, srate] = loaddata(filename)
if fopen(filename,'r') == -1
    questdlg('File does not exist.  Please ensure PATH is correct.',...
        'ERROR','OK','OK');
    array = -1;
else
    f = fopen(filename, 'r');
    check = fread(f,[1,2],'*char');
    if strcmp(check,'AG') == 1
        fseek(f,70,'bof');
        array = fread(f,[112 inf],'single');
        srate = 250;
    else
        fseek(f,0,'bof');
        array = fread(f,[84 inf], 'single');
        srate = 200;
    end
    array = array';
    fclose(f);
    
end

end