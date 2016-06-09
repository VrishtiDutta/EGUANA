function hurst_rh(x,xname,rate)
%x is the temporal serie
% rate sample frequency
%done in dst project by Rafael Henriques september 2010 ODL

%% first plot to spectrum analyse
spectrumcheck_rh(x,xname,rate)

%% selection of hurst method
sel=hurstmethodssel;

%% Calculate RMS in function to window size and then after select the linear
%% region the hurst exponent is estimated. All this in done acording  to
%% the method selected

switch sel
    case 1
        
        HurstEstimation(x,xname)
        
    case 2
        
        HurstEstimation2(x,xname)
        
    case 3
        
        DaveDFAEstimation(x,xname)
        
    case 4
        FastEstimation(x,xname)
        
end


end





    