% function [z,nz,zfirst,zlast]=zero_crossings(signal);
%
% Bepaald de index waarden in een array bij zero crossings 
%
% Input  : signal (array; 1 : n)
% Output : z      (array; 1 : n met indexen van zero crossings)
%          note: z is not the real time for zero crossing, it is the
%							index of array of data for zero crossing.
%          nz      (constante: aantal zero crossings)
%
% Syntax : [z,nz,zfirst,zlast]=zero_crossings(signal)
%

% last update: 3/08/10 by Rafael H, 2 zero

% last version
function [newz,zneg,zpos,nz,zfirst,zlast]=zero_crossings_rh(signal,interval,rate)
s = signal;
n = length(s); 
if ((interval*rate)>(n-2))
   disp('interval is too large. No result')
else
 
% use interval to decide the zero_crossings
% pick up the negative and positive points which are closest to the zero
% as zero_crossing.

%pick up the point which is closest to the zero as zero_crossing.    


j=0;
for i = 1:n-1,
    if ((s(i)<=0) && (s(i+1)>0))
        j=j+1;
        zneg(j)=i;
        if (abs(s(i))>abs(s(i+1)))
            z(j)=i+1;
        else
            z(j)=1;
        end
    end
end

newzneg(1)=zneg(1);
newz(1)=z(1);
m=2;
for i1 = 1:n-1,
    if ((s(i1)<=0) && (s(i1+1)>0) && ((i1-newz(m-1))>(interval*rate)) )
        newzneg(m)=i1;
        if (abs(s(i1))>abs(s(i1+1)))
            newz(m)=i1+1;
        else
            newz(m)=i1;
        end
        m=m+1;
    end
end

zneg=newzneg;
zpos=zneg+1;


% number of zero crossings found

nz=length(newz);
zfirst=zneg(1);
zlast=zneg(nz);
end


%% last version
% function [newz,nz,zfirst,zlast]=zero_crossings_rh(signal,interval,rate)
% s = signal;
% n = length(s); 
% if ((interval*rate)>(n-2))
%    disp('interval is too large. No result')
% else
%  
%     
% %pick up the point which is closest to the zero as zero_crossing.    
% j=0;
% for i = 1:n-1,
%     if ((s(i)<=0) && (s(i+1)>0))
%         j=j+1;
%         z(j)=i;
%         if (abs(s(i))>abs(s(i+1)))
%             z(j)=i+1;
%         end
%     end
% end
% 
% % use interval to decide the zero_crossings
% %pick up the point which is closest to the zero as zero_crossing.
% newz(1)=z(1);
% m=2;
% for i1 = 1:n-1,
%     if ((s(i1)<=0) && (s(i1+1)>0) && ((i1-newz(m-1))>(interval*rate)) )
%         newz(m)=i1;
%         if (abs(s(i1))>abs(s(i1+1)))
%             newz(m)=i1+1;
%         end
%         m=m+1;
%     end
% end
% 
% 
% % number of zero crossings found
% 
% nz=length(newz);
% zfirst=newz(1);
% zlast=newz(nz);
% end
