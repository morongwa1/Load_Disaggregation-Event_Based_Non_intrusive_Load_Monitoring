function [outliers] = OutlierDetection(Power)

    
    len = length(Power);
    S = zeros(len,1);
    M = zeros(len,1);
    outliers = zeros(len,1);
    for i= 1:1:len
        minimum = min(Power);
        maximum = max(Power);

        if maximum == 0
            S(i) = 0;
        else
            S(i) = minimum/maximum;
        end

        M(i) = 1 - S(i);
    end

    sd = std(M);
    
    for j = 1:1:len
        if M(j) > sd
            outliers(j) = j;
        end
    end

end