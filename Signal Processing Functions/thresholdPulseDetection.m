function [risingEdgesIndexes,risingEdgesSignal] = thresholdPulseDetection(signal,threshold,lag)
risingEdgesIndexes=[];
risingEdgesSignal=zeros(1,length(signal));
inPulse=0;
belowThresholdfor=0;

for i=1:1:length(signal)
    if signal(i)>threshold %if above threshold
        if inPulse==0 %if newly above threshold
            inPulse=1;
            risingEdgesIndexes=[risingEdgesIndexes,i];
            risingEdgesSignal(i)=1;
        else
            belowThresholdfor=0; %reset counter
        end
    else %if below threshold
        if inPulse==1
            if belowThresholdfor>lag %youre outside a pulse
                inPulse=0;
                belowThresholdfor=0;
            else % assume still in a pulse
                belowThresholdfor=belowThresholdfor+1;
            end
        end
    end
end
end