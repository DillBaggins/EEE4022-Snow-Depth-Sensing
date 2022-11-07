
% get signal

function [distance]=get_distance_using_thresholding(transmitted,received,sampleRate,temperature,plotSignals)


% filter and normalise signals
transmitThreshold=0.5;
Receivethreshold=0.5; % initial signal
receiveLag=100;


% test on transmission
[ti,ts]=thresholdPulseDetection(transmitted,transmitThreshold,100);

% test on received
[ri,rs]=thresholdPulseDetection(received,Receivethreshold,receiveLag);

%%

% make it so only most significant echo is delt with
while (length(ri)>length(ti))
    Receivethreshold=Receivethreshold+0.0001;
    [ri,rs]=thresholdPulseDetection(received,Receivethreshold,receiveLag);
    
    if plotSignals==1
    %plot signals
        figure;
        subplot(2,2,1);plot(transmitted);
        subplot(2,2,2);plot(received);
        subplot(2,2,3);plot(ts);
        subplot(2,2,4);plot(rs);
    end
    
    % get rid of transmit crosstalk, might be a bold assumption but fuck it
    if length(ri)==2*length(ti)
        %disp(" yeah")
        ri=ri(2:2:end);
    end
    
    
end





ri=ri-1; % because of round robin sampling (makes minimal difference)

%{
figure;
subplot(2,2,1);plot(transmitted);
subplot(2,2,2);plot(received);
subplot(2,2,3);plot(ts);
subplot(2,2,4);plot(rs);
%}

% get range
dt=1/sampleRate;
if (temperature<20 | temperature>28)
    temperature=24;
end
speedOfSound=20.05*sqrt((273.16 + temperature));
distances=zeros(1,length(ti));


if(length(ri)~=length(ti))
    disp("error: number of transmitted and recieved pulses do not match")
    fprintf("length of ri %d, length of ti %d\n",length(ri),length(ti));
    
    % work with what we do have
    distances=zeros(1,length(ri));
    for i=1:1:length(ri)
        % find the nearest ti before it
        sampleDifference=100000;
        for o=1:1:length(ti)
            testDifference=(ri(i)-ti(o));
            if (testDifference<sampleDifference & testDifference>0)
                sampleDifference=testDifference;
            end
        end
        timeDifference=sampleDifference*dt;
        distances(i)=speedOfSound*timeDifference/2;
    end


    timeDifference=(ri(1)-ti(1))*dt;
    distance=speedOfSound*timeDifference/2;
    distances=distance.*ones(1,length(ti));
    %distance=nan;

else
    for i=1:1:length(ri)
        timeDifference=(ri(i)-ti(i))*dt;
        distances(i)=speedOfSound*timeDifference/2;
    end
end
distance=mean(distances);
end



