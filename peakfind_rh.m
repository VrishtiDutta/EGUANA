function [y,peaklocpvl] = peakfind_rh(xn, tol)

% Peak finding function
%
% xn   is the vector to search for peaks in (index vector)
% tol  is the tolerance, the lower the tolerance
%      the closer the peak must be to the maximum
%      amplitude to be detected
%
%
% y    is the number of peaks found
%      a value of 0 or is a failure

% last update: Rafael H 26/07/10

normx = xn / max(xn);

tolval = max(normx) - (tol * max(normx));

numpeak = 0;
teller=0;
for k = 1:1:length(xn),
   if (k > 1)
      lval = normx(k-1);
   else
      lval = normx(1);
   end;

   if (k == length(xn))
      nval = normx(k);
   else
      nval = normx(k+1);
   end;

   xval = normx(k);

   if (xval >= tolval)
      if (xval >= lval && xval > nval)
         numpeak = numpeak + 1;
         teller=teller+1;
		 peaklocpvl(teller)=k;
      end;
   end;
end;
%peaklocpvl(teller)=peaklocpvl(teller-1);
y = numpeak;
