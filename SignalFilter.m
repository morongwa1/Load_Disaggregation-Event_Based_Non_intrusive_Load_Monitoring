function filteredSignal = SignalFilter(Power,outliers)

    len = length(Power);
    filteredSignal = zeros(len);

    for i = 1:len
        if outliers(i) == 0
            filteredSignal(i) = Power(i);
        else
            j = i+1
            sum = 0
            while outliers(j) == 0 & j <len
                sum = sum + power(j);
                j = j + 1;
            end
            mean = sum/j
            outliers(i) = mean
        end
    end
end