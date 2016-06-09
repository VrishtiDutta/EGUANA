function [outsignal]=pca_pvl1rh(signal1)

% Principal components program

[N,p]=size(signal1);
j=ones(N,1);
XBAR=j'*signal1/N;
Y=signal1-j*XBAR;
varcov=Y'*Y/(N-1);
[U,L,U]=svd(varcov);
%pause
%L=[diag(L) 100*cumsum(diag(L)/sum(diag(L)))]
%U
Scores=Y*U;
%clf
%pause
%figure(28);
%whitebg(28,'white');

%plot(Scores(:,1),Scores(:,2),'r',signal1(:,1),signal1(:,2),'g');
%xlabel('PC1/X-ori');
%ylabel('PC2/Y-ori');
%title('Plot of PC2 agains PC1 in red; original X and Y in green');
outsignal=Scores(:,1);