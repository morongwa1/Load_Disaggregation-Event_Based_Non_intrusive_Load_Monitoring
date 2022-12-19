clc
close all
data =  readtable("DishWasher_trend.csv")
VarNames = data.Properties.VariableNames;
colId = find(strcmp(VarNames, 'PowerP_L1_avg'));
Start = transpose(data.Start_SouthAfricaStandardTime_);
Power = transpose(data.PowerP_L1_avg);


len = length(Power);

for i = 1:len
        if Power(i) < 0
            Power(i) = 0;
        end
end

% Power = Power(Power>=0);

% display(Power)
% %% KMeans
% % k = 10;
% % idx = zeros(1,k);
% % devider = (len/k);
% %
% % for i = 1:k
% %     incre = devider*i;
% %     idx(i) = incre;
% % end
% % idx
%
% idx = [180 360 540 720 900 1080 1260 1440 1620 1746];
% S = Power([idx]);
% temp = 0;
% cluster1 = [];
% cluster2 = [];
% cluster3 = [];
% cluster4 = [];
% cluster5 = [];
% cluster6 = [];
% cluster7 = [];
% cluster8 = [];
% cluster9 = [];
% cluster10 = [];
%
% centroid1_new = S(1);
% centroid2_new =  S(2);
% centroid3_new =  S(3);
% centroid4_new =  S(4);
% centroid5_new =  S(5);
% centroid6_new =  S(6);
% centroid7_new =  S(7);
% centroid8_new =  S(8);
% centroid9_new =  S(9);
% centroid10_new =  S(10);
%
% while (temp == 0)
%     S = [centroid1_new centroid2_new centroid3_new centroid4_new centroid5_new centroid6_new centroid7_new centroid8_new centroid9_new centroid10_new];
%     centroid1_old = S(1);
%     centroid2_old = S(2);
%     centroid3_old = S(3);
%     centroid4_old = S(4);
%     centroid5_old = S(5);
%     centroid6_old = S(6);
%     centroid7_old = S(7);
%     centroid8_old = S(8);
%     centroid9_old = S(9);
%     centroid10_old = S(10);
%
%     for i = 1:len
%
%         dist1 = abs(Power(i) - centroid1_old);
%         dist2 = abs(Power(i) - centroid2_old);
%         dist3 = abs(Power(i) - centroid3_old);
%         dist4 = abs(Power(i) - centroid4_old);
%         dist5 = abs(Power(i) - centroid5_old);
%         dist6 = abs(Power(i) - centroid6_old);
%         dist7 = abs(Power(i) - centroid7_old);
%         dist8 = abs(Power(i) - centroid8_old);
%         dist9 = abs(Power(i) - centroid9_old);
%         dist10 = abs(Power(i) - centroid10_old);
%
%         dist_array = sort([dist1 dist2 dist3 dist4 dist5 dist6 dist7 dist8 dist9 dist10]);
%
%         if dist_array(1) == dist1
%             cluster1 = [cluster1 Power(i)];
%         end
%         if dist_array(1) == dist2
%             cluster2 = [cluster2 Power(i)];
%         end
%         if dist_array(1) == dist3
%             cluster3 = [cluster1 Power(i)];
%         end
%         if dist_array(1) == dist4
%             cluster4 = [cluster4 Power(i)];
%         end
%         if dist_array(1) == dist5
%             cluster5 = [cluster5 Power(i)];
%         end
%         if dist_array(1) == dist6
%             cluster6 = [cluster6 Power(i)];
%         end
%         if dist_array(1) == dist7
%             cluster7 = [cluster7 Power(i)];
%         end
%         if dist_array(1) == dist8
%             cluster8 = [cluster8 Power(i)];
%         end
%         if dist_array(1) == dist9
%             cluster9 = [cluster9 Power(i)];
%         end
%         if dist_array(1) == dist10
%             cluster10 = [cluster10 Power(i)];
%         end
%
%     end
%
%
%     centroid1_new = mean(cluster1); %A(A>=0)
%     centroid2_new = mean(cluster2);
%     centroid3_new = mean(cluster3);
%     centroid4_new = mean(cluster4);
%     centroid5_new = mean(cluster5);
%     centroid6_new = mean(cluster6);
%     centroid7_new = mean(cluster7);
%     centroid8_new = mean(cluster8);
%     centroid9_new = mean(cluster9);
%     centroid10_new = mean(cluster10);
%
%
%     if (centroid1_new ~= centroid1_old && centroid2_new ~= centroid2_old && centroid3_new ~= centroid3_old && centroid4_new ~= centroid4_old && centroid5_new ~= centroid5_old && centroid6_new ~= centroid6_old)
%         cluster1 = [];
%         cluster2 = [];
%         cluster3 = [];
%         cluster4 = [];
%         cluster5 = [];
%         cluster6 = [];
%         cluster7 = [];
%         cluster8 = [];
%         cluster9 = [];
%         cluster10 = [];
%     else
%         temp = 1;
%     end
% end

% [outliers] = OutlierDetection(Power);
%% Outlier detection

len = length(Power);
S = zeros(len,1);
M = zeros(len,1);
outliers = zeros(len,1);

for i= 1:1:len-1
    
    minimum = min(Power(i),Power(i+1));
    maximum = max(Power(i),Power(i+1));

    if(maximum == 0)
        S(i) = 0;
    else
        S(i) = minimum/maximum;
    end

    M(i) = 1 - S(i);
end

sd = std(M)

for j = 1:1:len
    if M(j) > sd
        outliers(j) = j;
    end
end

% display(M);
%% Extracting outliers
values = zeros(len,1);
for i= 1:len
    if outliers(i) ~= 0
        values(i) = Power(i);
    end
end

% display(values);
%% signal filtering

filteredSignal = zeros(len,1);

for i = 1:1:len
    if outliers(i) == 0
        filteredSignal(i) = Power(i);
    elseif outliers(i) ~= 0
        k = i+1;
        sum = 0;
        while (k < len && Power(k) == 0)
            sum = sum + Power(k);
            k = k + 1;
        end
        mean = sum/k-i;

        filteredSignal(i) = mean;
    end
end
%     filteredSignal

%% Event detection
events = zeros(len,1);
for i= 1:len
    if outliers(i) ~= 0
        events(i) = Power(i);
    end
end


figure
subplot(2,1,1)
plot(Start,Power)
hold on
scatter(Start,values)
xlabel('Time');
ylabel('Active Power');
title('Original Signal vs Detected Ouliers for a dishwasher power signal');
legend('Original signal', 'Detected Outliers')

subplot(2,1,2)
plot(Start,Power)
hold on
plot(Start,filteredSignal);
xlabel('Time ');
ylabel('Active Power');
title('Original Signal vs Filtered signal for a dishwasher power signal');
legend('Original SIgnal', 'Filtered signal')
