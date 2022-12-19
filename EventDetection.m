function events = EventDetection(Power, outliers)
    len = length(Power)
    events = zeros(len)
    for i= 1:len
        if outliers(i) ~= 0
            events(i) = Power(i)
        end
    end
end