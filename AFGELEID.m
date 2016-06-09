function [afgeleide]=AFGELEID(data,sf)

% AFGELEID.M
% dit programma differentieert een willekeurige data set
% data die staat in een matrix
% sf = samplefrequentie in Hz
% Ron Jacobs, juli 1989

[m,n]=size(data);
afgeleide=zeros(m,n);

for i=3:m-2,
 afgeleide(i,:)=(-data(i-2,:)*1.5-data(i-1,:)*4+data(i+1,:)*4+data(i+2,:)*1.5)*(sf/14);
end

afgeleide(1,:) = afgeleide(3,:);   afgeleide(2,:)   = afgeleide(3,:);
afgeleide(m,:) = afgeleide(m-2,:); afgeleide(m-1,:) = afgeleide(m-2,:);

