
%% Set paths
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/')
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;

%% Load data
out20bw = load('Series0001_Trial0002__Itrs0020_vortex_LUVOIR_B_2DM32_z0.2_IWA2_OWA10_5lams650nm_BW20_gridsearchEFC_all.mat', 'out').('out');
out10bw = load('Series0001_Trial0002__Itrs0020_vortex_LUVOIR_B_2DM32_z0.2_IWA2_OWA10_5lams650nm_BW10_gridsearchEFC_all.mat', 'out').('out');
out30itr = load('Series0001_Trial0004__Itrs0030_vortex_LUVOIR_B_2DM32_z0.2_IWA2_OWA10_5lams650nm_BW15_gridsearchEFC_all.mat', 'out').('out');
out50itr = load('Series0001_Trial0005__Itrs0050_vortex_LUVOIR_B_2DM32_z0.2_IWA2_OWA10_5lams650nm_BW15_gridsearchEFC_all.mat', 'out').('out');

inormvals30 = out30itr.InormFiberHist;
inormvals20 = out20bw.InormFiberHist;
inormvals10 = out10bw.InormFiberHist;
inormvals50 = out50itr.InormFiberHist;

itrs = linspace(0, 20, 21);

%% Plot data
figure();

% loglog(itrs, inormvals50, '-o', 'DisplayName', 'BW = 15%')
% xlabel('Iteration')
% ylabel('log(Normalized Intensity)')

loglog(itrs, inormvals10, '-o', 'DisplayName', 'BW = 10%')
xlabel('Iteration')
ylabel('log(Normalized Intensity)')

hold on

loglog(itrs, inormvals20, '-o', 'DisplayName', 'BW = 20%')

hold off 
legend('Location', 'northeast')
set(gca,'XTick', 0:5:20)
set(gca,'XTickLabel',0:5:20)

saveas(gcf, '/media/Data_Drive/KPIC/dev/dechever/TTJitCharac/Algo_Dev/algo_charac/results/algo_log_all.png')

