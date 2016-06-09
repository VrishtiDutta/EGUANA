
%chris
sub='chris'
base_path='E:\FCUL 3ºano 2semestre\Estagio_ODL\estagio\3Ddata\chris pilot 3\rawpos\';

trials={'03','04','05','07','08','09','10','11','12','14'};
tri=[3,4,5,7,8,9,10,11,12,14];    
ch=0;
audio = 1;
    
for i=1:length(tri)
    
    %% OPEN DATA TO ANALYSIS
    path = strcat(base_path,'00', trials{i},'.pos');
    
    [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
        y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
        phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
        theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
        theta10,theta11,theta12] =...
      inputemma3D_jaw_rh(path, ch,audio, 1);
  
    x3d_raw = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12];
    y3d_raw = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12];
    z3d_raw = [z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12];
    
    phi_rawi = [phi1,phi2,phi3,phi4,phi5,phi6,...
                       phi7,phi8,phi9,phi10,phi11,phi12];
    theta_rawi = [ theta1,theta2,theta3,theta4,theta5,theta6,...
                          theta7,theta8,theta9,theta10,theta11,theta12];
    
    siz=size(x3d_raw);                
    x3d_lp=zeros(siz);%
    y3d_lp=zeros(siz);%
    z3d_lp=zeros(siz);%
    phi_raw=zeros(siz);%
    theta_raw=zeros(siz);%
    phi_lp=zeros(siz);%
    theta_lp=zeros(siz);%
    
     for k = 1:siz(2)
        %   waitbarh(k/siz(2),h);
        
        x3d_lp(:,k) = filter_array_rhv2(x3d_raw(:,k),200, 6,0);
        y3d_lp(:,k) = filter_array_rhv2(y3d_raw(:,k),200, 6,0);
        z3d_lp(:,k) = filter_array_rhv2(z3d_raw(:,k),200, 6,0);
        
        phi_raw(:,k)=unwrap(phi_rawi(:,k)*pi/180);
        theta_raw(:,k)=unwrap(theta_rawi(:,k)*pi/180);
        phi_lp(:,k) = filter_array_rhv2(phi_raw(:,k),200, 6,0);
        theta_lp(:,k) = filter_array_rhv2(theta_raw(:,k),200, 6,0);
     end
     
     %% MAKE Analysis
     
    % INFO
    % Bite Plane Trial     2				Resting Position Trial   1
    % Numbers of Ref       4 12 11			Numbers of Ref Coils     8 10 9  (A C)
	%                               								 8 12 11 (R H)
     numbercoiljaw=[8,10,9];
     numbercoilhead=[4,12,11];
     
     PaperHistogramv2(x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,...
         base_path,'2', numbercoiljaw, numbercoilhead,sub,tri(i))

i,   
end
'chris done'



numbercoiljaw=[8,10,9];
 numbercoilhead=[4,12,11];
%rafael
sub='rafael'
base_path='E:\FCUL 3ºano 2semestre\Estagio_ODL\estagio\3Ddata\Jawtest 1 session 1\rawpos\';
%33:36 already done

trials={'33','34','35','36','37','38','39','40','41','42','43','44', '45', '47', '48', '49', '50'};
tri=[33,34,35,36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 47, 48, 49, 50];
ch=0;
audio = 1;

for i=1:length(tri)
    

    
    %% OPEN DATA TO ANALYSIS
    path = strcat(base_path,'00', trials{i},'.pos');
    
    [ac,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,y1,y2,y3,y4,y5,y6,y7,...
        y8,y9,y10,y11,y12,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,...
        phi1,phi2,phi3,phi4,phi5,phi6,phi7,phi8,phi9,phi10,phi11,phi12,...
        theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8,theta9,...
        theta10,theta11,theta12] =...
      inputemma3D_jaw_rh(path, ch,audio, 1);
  
    x3d_raw = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12];
    y3d_raw = [y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12];
    z3d_raw = [z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12];
    
    phi_rawi = [phi1,phi2,phi3,phi4,phi5,phi6,...
                       phi7,phi8,phi9,phi10,phi11,phi12];
    theta_rawi = [ theta1,theta2,theta3,theta4,theta5,theta6,...
                          theta7,theta8,theta9,theta10,theta11,theta12];
    
    siz=size(x3d_raw);                
    x3d_lp=zeros(siz);%
    y3d_lp=zeros(siz);%
    z3d_lp=zeros(siz);%
    phi_raw=zeros(siz);%
    theta_raw=zeros(siz);%
    phi_lp=zeros(siz);%
    theta_lp=zeros(siz);%
    
     for k = 1:siz(2)
        %   waitbarh(k/siz(2),h);
        
        x3d_lp(:,k) = filter_array_rhv2(x3d_raw(:,k),200, 6,0);
        y3d_lp(:,k) = filter_array_rhv2(y3d_raw(:,k),200, 6,0);
        z3d_lp(:,k) = filter_array_rhv2(z3d_raw(:,k),200, 6,0);
        
        phi_raw(:,k)=unwrap(phi_rawi(:,k)*pi/180);
        theta_raw(:,k)=unwrap(theta_rawi(:,k)*pi/180);
        phi_lp(:,k) = filter_array_rhv2(phi_raw(:,k),200, 6,0);
        theta_lp(:,k) = filter_array_rhv2(theta_raw(:,k),200, 6,0);
     end
     
     %% MAKE Analysis
     
    % INFO
    % Bite Plane Trial     11				Resting Position Trial   10 (others 9 12)
    % Numbers of Ref       4 12 11			Numbers of Ref Coils     8 10 9  (A C)
	%                               								 8 12 11 (R H)
    % numbercoiljaw=[8,10,9];
     
     
     % this code is specific to the data, when trial past to the last ones,
     % head coils used are 5 instead of 4, because 4 is broken in this last
     % trials
     if(tri(i)==47) 
         numbercoilhead=[5,12,11]
     end
     
     PaperHistogramv2(x3d_lp,y3d_lp,z3d_lp,phi_lp,theta_lp,...
         base_path,'11', numbercoiljaw, numbercoilhead,sub,tri(i))

i,
'done',   
end
'rafael done' 