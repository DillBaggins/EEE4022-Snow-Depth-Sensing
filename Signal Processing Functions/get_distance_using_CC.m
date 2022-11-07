function [distance]=get_distance_using_CC(transmitted,received,sampleRate,temperature,plotSignals)

%% xCorr
[x,lags]=xcorr(received,transmitted);
subplot(3,1,3);plot(lags,x);
[t,i]=max(x);
time=lags(i);



%% distance
speedOfSound=20.05*sqrt((273.16 + temperature));
distance=time*(1/sampleRate)*speedOfSound*0.5;

if plotSignals==1
    figure;
    subplot(3,1,1); plot(transmitted); legend("transmitted");
    subplot(3,1,2); plot(received); legend("received");
    subplot(3,1,3); plot(lags,x);
    title(sprintf("Distance=%d",distance));
end

