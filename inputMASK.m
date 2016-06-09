function [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
          y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
          phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
          theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
          theta10,theta11,theta12] =...
          inputMASK(positionfile)
      
x1=positionfile(1,1,:); y1=positionfile(2,1,:); z1=positionfile(3,1,:); phi1=0; theta1=0;
x2=positionfile(1,2,:); y2=positionfile(2,2,:); z2=positionfile(3,2,:); phi2=0; theta2=0;
x3=positionfile(1,3,:); y3=positionfile(2,3,:); z3=positionfile(3,3,:); phi3=0; theta3=0;
x4=positionfile(1,4,:); y4=positionfile(2,4,:); z4=positionfile(3,4,:); phi4=0; theta4=0;
x5=positionfile(1,5,:); y5=positionfile(2,5,:); z5=positionfile(3,5,:); phi5=0; theta5=0;
x6=positionfile(1,6,:); y6=positionfile(2,6,:); z6=positionfile(3,6,:); phi6=0; theta6=0;
x7=0; y7=0; z7=0; phi7=0; theta7=0;
x8=0; y8=0; z8=0; phi8=0; theta8=0;
x9=0; y9=0; z9=0; phi9=0; theta9=0;
x10=0; y10=0; z10=0; phi10=0; theta10=0;
x11=0; y11=0; z11=0; phi11=0; theta11=0;
x12=0; y12=0; z12=0; phi12=0; theta12=0;

x1 = squeeze(x1);
x2 = squeeze(x2);
x3 = squeeze(x3);
x4 = squeeze(x4);
x5 = squeeze(x5);
x6 = squeeze(x6);
y1 = squeeze(y1);
y2 = squeeze(y2);
y3 = squeeze(y3);
y4 = squeeze(y4);
y5 = squeeze(y5);
y6 = squeeze(y6);
z1 = squeeze(z1);
z2 = squeeze(z2);
z3 = squeeze(z3);
z4 = squeeze(z4);
z5 = squeeze(z5);
z6 = squeeze(z6);

end
