close all;
figure;

%------------------- Define s1(t) and s2(t)------------------------%
NS = 100;
t = linspace(0,1,NS);
s1 = rectpuls(t-0.5,1);
s1(1) = 0;
s1(end) = 0;
s2 = 2*rectpuls(t,1.5) - rectpuls(t,2);
s2(1)=0;
s2(end)=0;
% Plot the sum signal s1
plot(t, s1, 'r', 'LineWidth', 2);
xlabel('Time');
ylabel('s1');
title('Input signals s1(t)');
figure;

% Plot the sum signal s2
plot(t, s2, 'r', 'LineWidth', 2);
xlabel('Time');
ylabel('s2');
title('Input signals s2(t)');



%---------------------------GM_Bases----------------------------%
[phi_1,phi_2]=GM_Bases(s1,s2);
figure;

plot(t, phi_1, 'b', 'LineWidth', 2);
xlabel('Time');
ylabel('phi1');
title('Orthonormal Basis Function phi1');
xlim([0 1.2]);

 figure;
plot(t, phi_2, 'r', 'LineWidth', 2);
xlabel('Time');
ylabel('phi2');
title('Orthonormal Basis Function phi2');
xlim([0 1.2]);


%-------------- Call the signal_space function----------------------%
[v11, v12] = signal_space(s1, phi_1, phi_2);
[v21, v22] = signal_space(s2, phi_1, phi_2);

figure;
plot([0 v11], [0 v12], 'b',[0 v21], [0 v22], 'r', 'LineWidth',2);
hold on;



% -------------Plot the signal space representation---------------%

scatter(v11, v12, 'MarkerFaceColor', 'none', 'Marker', 'o', 'SizeData', 70);

hold on;
scatter(v21, v22, 'MarkerFaceColor', 'none', 'Marker', 'o', 'SizeData', 70);

xlabel('phi1');
ylabel('phi2');
title('Signal space representation of s1&s2');
% Legend with custom labels
legend('Signal 1', 'Signal 2');





% -----------Effect of AWGN on signal space representation------------%
energies = [-5, 0, 10];  % Energy levels in dB
num_samples= 50;
for j=1:length(energies)
    figure;
    scatter(v11, v12,  'filled', 'MarkerFaceColor', 'b', 'Marker', 'o', 'SizeData', 100);

    hold on;
    scatter(v21, v22, 'filled', 'MarkerFaceColor', 'r', 'Marker', 'o', 'SizeData', 100);
    hold on;
    for i = 1:50
            % Generate r1(t) and r2(t) by adding AWGN to s1(t) and s2(t)
            r1=awgn(s1,energies(j),'measured');
            r2=awgn(s2,energies(j),'measured');
    
            % Calculate the signal space representation of r1(t) and r2(t)
            [v11_s1, v12_s1] = signal_space(r1, phi_1, phi_2);
            [v21_s2, v22_s2] = signal_space(r2, phi_1, phi_2);
    
            % Plot the signal points of r1(t) and r2(t)           
            scatter([0 v11_s1], [0 v12_s1], 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'y', 'Marker', 'o');
            hold on;
           
            scatter([0 v21_s2], [0 v22_s2], 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'Marker', 'o');
            hold on;
            
            xlabel('phi1');
            ylabel('phi2');
            title(sprintf('Signal Points for r1(t) and r2(t) at E/variance = %d dB', energies(j)));
    end
    scatter(v11, v12,  'filled', 'MarkerFaceColor', 'b', 'Marker', 'o', 'SizeData', 100);
    hold on;
    scatter(v21, v22, 'filled', 'MarkerFaceColor', 'r', 'Marker', 'o', 'SizeData', 100);
    legend("signal 1","signal 2","signal1+noise","signal2+noise");

end


