clc
close all
clear all

data =  readtable("MultiLightsMin20W_trend.csv");
VarNames = data.Properties.VariableNames;
colId = find(strcmp(VarNames, 'PowerP_L1_avg'));
Start = transpose(data.Start_SouthAfricaStandardTime_);
Power = transpose(data.PowerP_L1_avg);
Power = Power(Power>=0);

len = length(Power);
% k = 10;
% idx = zeros(k);
% devider = (len/k);
%
% for i = 1:k
%     incre = devider*i;
%     idx(i) = incre;
% end

idx = [180 360 540 720 900 1080 1260 1440 1620 1746];
S = Power([idx]);
temp = 0;
cluster1 = [];
cluster2 = [];
cluster3 = [];
cluster4 = [];
cluster5 = [];
cluster6 = [];
cluster7 = [];
cluster8 = [];
cluster9 = [];
cluster10 = [];

centroid1_new = S(1);
centroid2_new =  S(2);
centroid3_new =  S(3);
centroid4_new =  S(4);
centroid5_new =  S(5);
centroid6_new =  S(6);
centroid7_new =  S(7);
centroid8_new =  S(8);
centroid9_new =  S(9);
centroid10_new =  S(10);

while (temp == 0)
    S = [centroid1_new centroid2_new centroid3_new centroid4_new centroid5_new centroid6_new centroid7_new centroid8_new centroid9_new centroid10_new];
    centroid1_old = S(1);
    centroid2_old = S(2);
    centroid3_old = S(3);
    centroid4_old = S(4);
    centroid5_old = S(5);
    centroid6_old = S(6);
    centroid7_old = S(7);
    centroid8_old = S(8);
    centroid9_old = S(9);
    centroid10_old = S(10);

    for i = 1:len

        dist1 = abs(Power(i) - centroid1_old);
        dist2 = abs(Power(i) - centroid2_old);
        dist3 = abs(Power(i) - centroid3_old);
        dist4 = abs(Power(i) - centroid4_old);
        dist5 = abs(Power(i) - centroid5_old);
        dist6 = abs(Power(i) - centroid6_old);
        dist7 = abs(Power(i) - centroid7_old);
        dist8 = abs(Power(i) - centroid8_old);
        dist9 = abs(Power(i) - centroid9_old);
        dist10 = abs(Power(i) - centroid10_old);

        dist_array = sort([dist1 dist2 dist3 dist4 dist5 dist6 dist7 dist8 dist9 dist10]);

        if dist_array(1) == dist1
            cluster1 = [cluster1 Power(i)];
        end
        if dist_array(1) == dist2
            cluster2 = [cluster2 Power(i)];
        end
        if dist_array(1) == dist3
            cluster3 = [cluster1 Power(i)];
        end
        if dist_array(1) == dist4
            cluster4 = [cluster4 Power(i)];
        end
        if dist_array(1) == dist5
            cluster5 = [cluster5 Power(i)];
        end
        if dist_array(1) == dist6
            cluster6 = [cluster6 Power(i)];
        end
        if dist_array(1) == dist7
            cluster7 = [cluster7 Power(i)];
        end
        if dist_array(1) == dist8
            cluster8 = [cluster8 Power(i)];
        end
        if dist_array(1) == dist9
            cluster9 = [cluster9 Power(i)];
        end
        if dist_array(1) == dist10
            cluster10 = [cluster10 Power(i)];
        end

    end


    centroid1_new = mean(cluster1); %A(A>=0)
    centroid2_new = mean(cluster2);
    centroid3_new = mean(cluster3);
    centroid4_new = mean(cluster4);
    centroid5_new = mean(cluster5);
    centroid6_new = mean(cluster6);
    centroid7_new = mean(cluster7);
    centroid8_new = mean(cluster8);
    centroid9_new = mean(cluster9);
    centroid10_new = mean(cluster10);


    if (centroid1_new ~= centroid1_old && centroid2_new ~= centroid2_old && centroid3_new ~= centroid3_old && centroid4_new ~= centroid4_old && centroid5_new ~= centroid5_old && centroid6_new ~= centroid6_old)
        cluster1 = [];
        cluster2 = [];
        cluster3 = [];
        cluster4 = [];
        cluster5 = [];
        cluster6 = [];
        cluster7 = [];
        cluster8 = [];
        cluster9 = [];
        cluster10 = [];
    else
        temp = 1;
    end
end



M_m = [];
Mode = [];
N = length(S);

clusters = {cluster1; cluster2; cluster3; cluster4; cluster5; cluster6; cluster7; cluster8; cluster9; cluster10};

% while N > 0
    N = length(S);
    S_c = sort(S,'descend');
    C_r = S_c(1);
    for i = 1:N
        C_i = S_c(i);
        dist = abs(C_r - C_i);

        if (dist < (0.15*C_r))
            M_m = [M_m C_i];
        else
            %delete M_m from S
        end
    end
    %Mode_i = members of the clusters if the centroids saved in M_m 
    C_idx = find(S == M_m);
    Mode = [Mode clusters(C_idx,1) ]
    
%     display(clusters);
%     Mode()
    %delete M_m from S
% end

% display(M_m)
display(S)
% display(cluster4)
