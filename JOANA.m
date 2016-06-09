function [x3dc,y3dc,z3dc,phic,thetac]=JOANA(...
    numbercoil, x3d,y3d,z3d,phi,theta,sel,phical,thetacal)
% JOANA (Jaw Oral Dynamic ANAlysis)
% sel is to select the simplified vertion 0 or the more complex vertion with
% angular correction

%project virtual points need to correct angles
[nax,nay,naz]=sph2cart(phi,theta,1);
napx=x3d+nax;
napy=y3d+nay;
napz=z3d+naz;


     %% Jaw correction acording to simple or bite & Rest position files
     %% correction
if (sel==0)
    %% simple correction
    
    
    le=size(phi,1);
    JCP=zeros(24,3,le);
    %correction with head coils
    for i=1:le
        P=[x3d(i,1),y3d(i,1),z3d(i,1);
            x3d(i,2),y3d(i,2),z3d(i,2);
            x3d(i,3),y3d(i,3),z3d(i,3);
            x3d(i,4),y3d(i,4),z3d(i,4);
            x3d(i,5),y3d(i,5),z3d(i,5);
            x3d(i,6),y3d(i,6),z3d(i,6);
            x3d(i,7),y3d(i,7),z3d(i,7);
            x3d(i,8),y3d(i,8),z3d(i,8);
            x3d(i,9),y3d(i,9),z3d(i,9) ;
            x3d(i,10),y3d(i,10),z3d(i,10);
            x3d(i,11),y3d(i,11),z3d(i,11);
            x3d(i,12),y3d(i,12),z3d(i,12);
            napx(i,1),napy(i,1),z3d(i,1);
            napx(i,2),napy(i,2),napz(i,2);
            napx(i,3),napy(i,3),napz(i,3);
            napx(i,4),napy(i,4),napz(i,4);
            napx(i,5),napy(i,5),napz(i,5);
            napx(i,6),napy(i,6),napz(i,6);
            napx(i,7),napy(i,7),napz(i,7);
            napx(i,8),napy(i,8),napz(i,8);
            napx(i,9),napy(i,9),napz(i,9) ;
            napx(i,10),napy(i,10),napz(i,10);
            napx(i,11),napy(i,11),napz(i,11);
            napx(i,12),napy(i,12),napz(i,12);
            ];
        JP=[x3d(i,numbercoil(1)),y3d(i,numbercoil(1)),z3d(i,numbercoil(1))];
        EPL=[x3d(i,numbercoil(3)),y3d(i,numbercoil(3)),z3d(i,numbercoil(3))];
        EPR=[x3d(i,numbercoil(2)),y3d(i,numbercoil(2)),z3d(i,numbercoil(2))];
        [JCP(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phi(i,numbercoil(1)),theta(i,numbercoil(1)));
        
    end
    
    x3dc=squeeze(JCP(1:12,1,:))';
    y3dc=squeeze(JCP(1:12,2,:))';
    z3dc=squeeze(JCP(1:12,3,:))';
    napx = squeeze(JCP(13:24,1,:))';
    napy = squeeze(JCP(13:24,2,:))';
    napz = squeeze(JCP(13:24,3,:))';
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;
    
    [phic,thetac,r]=cart2sph(nax,nay,naz);
    
elseif(sel==1)

    if(nargin<9)
        p={ 'angle to correct phi direction of front jaw coil (rad)',...
            'angle to correct theta direction of front jaw coil (rad)'};
        t='Input data';
        def = {'0','0'};
        
        r=inputdlg(p,t,1,def);
        
        phical=eval(r{1});
        thetacal=eval(r{2});
    end
    
    le=size(phi,1);
    JCP=zeros(24,3,le);
    %correction with head coils
    for i=1:le
        P=[x3d(i,1),y3d(i,1),z3d(i,1);
            x3d(i,2),y3d(i,2),z3d(i,2);
            x3d(i,3),y3d(i,3),z3d(i,3);
            x3d(i,4),y3d(i,4),z3d(i,4);
            x3d(i,5),y3d(i,5),z3d(i,5);
            x3d(i,6),y3d(i,6),z3d(i,6);
            x3d(i,7),y3d(i,7),z3d(i,7);
            x3d(i,8),y3d(i,8),z3d(i,8);
            x3d(i,9),y3d(i,9),z3d(i,9) ;
            x3d(i,10),y3d(i,10),z3d(i,10);
            x3d(i,11),y3d(i,11),z3d(i,11);
            x3d(i,12),y3d(i,12),z3d(i,12);
            napx(i,1),napy(i,1),z3d(i,1);
            napx(i,2),napy(i,2),napz(i,2);
            napx(i,3),napy(i,3),napz(i,3);
            napx(i,4),napy(i,4),napz(i,4);
            napx(i,5),napy(i,5),napz(i,5);
            napx(i,6),napy(i,6),napz(i,6);
            napx(i,7),napy(i,7),napz(i,7);
            napx(i,8),napy(i,8),napz(i,8);
            napx(i,9),napy(i,9),napz(i,9) ;
            napx(i,10),napy(i,10),napz(i,10);
            napx(i,11),napy(i,11),napz(i,11);
            napx(i,12),napy(i,12),napz(i,12);
            ];
        JP=[x3d(i,numbercoil(1)),y3d(i,numbercoil(1)),z3d(i,numbercoil(1))];
        EPL=[x3d(i,numbercoil(3)),y3d(i,numbercoil(3)),z3d(i,numbercoil(3))];
        EPR=[x3d(i,numbercoil(2)),y3d(i,numbercoil(2)),z3d(i,numbercoil(2))];
        [JCP(:,:,i)]=JAWCRAM(P,JP,EPL,EPR,phi(i,numbercoil(1))-phical,theta(i,numbercoil(1))-thetacal);
        
    end
    
    x3dc=squeeze(JCP(1:12,1,:))';
    y3dc=squeeze(JCP(1:12,2,:))';
    z3dc=squeeze(JCP(1:12,3,:))';
    napx = squeeze(JCP(13:24,1,:))';
    napy = squeeze(JCP(13:24,2,:))';
    napz = squeeze(JCP(13:24,3,:))';
    
    nax=napx-x3dc;
    nay=napy-y3dc;
    naz=napz-z3dc;
    
    [phic,thetac,r]=cart2sph(nax,nay,naz);
    
end

