clear
clc
close all;
%% Set paths
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/')
% addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;   % Paths to FALCO, PROPER installations

%% Jacobian Construction Params (EFC)
jac_comp_time = 12.74;                  % FALCO's Jacobian computation time/bandpass (s)
nSbp = 9;                               % Number of Sub-bandpasses (assume a 20% BW)

tot_jac_time = jac_comp_time * nSbp/60; % EFC Jacobian Construruction Time (minutes)

%% Jacobian Construction Params (iEFC)

nSbp = nSbp;                              
nModes = [4, 24, 64, 112];
nProbes = 2;
nImages = 4 * nSbp * nModes * nProbes;
iTime = 1;                              % Integration time (s)
jac_time = nImages * iTime/60;          % iEFC Jacobian Construction Time (minutes) 

%% Plot data
figure();

set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter', 'latex','FontSize',16);
% set(gca,'XScale','log')

Cmap = lines(2);

tot_jac_time = tot_jac_time * ones(size(nModes));

semilogy(nModes, tot_jac_time, '-o', 'color', Cmap(1,:), 'DisplayName', 'EFC Jacobian')

for i = 1:3:length(nModes)
    % Add text label above the data point
%     text(nModes(i), tot_jac_time(i), num2str(tot_jac_time(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
    text(nModes(i), tot_jac_time(i), num2str(round(tot_jac_time(i))), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');

end

title('EFC/iEFC Runtime Comparison (20$\%$ BW)')

xlabel('Number of Modes')
ylabel('log(Runtime) (minutes)')

hold on
semilogy(nModes, jac_time, '-o', 'color', Cmap(2,:), 'DisplayName', 'iEFC Jacobian')
ylim([1, 180])

for i = 1:length(nModes)
    % Add text label above the data point
    text(nModes(i), jac_time(i), num2str(jac_time(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
end

hold off

legend('Location', 'northwest')

exportgraphics(gcf,'/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/iefc_efc_runtime_comp.eps','BackgroundColor','none','ContentType','vector')
