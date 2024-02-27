clear
close all;
%% Set paths
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/efc_smf_34act/contrast_v_modes_final/')
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_smf_34act/contrast_v_modes_final/')

% addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;

%% Load data

% % BB EFC
out_efc_1 = load('efc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_20_iters_all.mat', 'out').('out').InormFiberHist;
% out_efc_2 = load('efc_smf_34act/efc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'mp').('mp');
% out_efc_3 = load('efc_smf_NEW_32act/efc_D_shape_hex_smf_wfe_nm_BW10_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
% out_efc_4 = load('efc_smf_NEW_32act/efc_D_shape_hex_smf_wfe_nm_BW10_Xpos5.5_Ypos0_Xoff5.5_Yoff0_all.mat', 'out').('out').InormFiberHist(9);
% 


% BB 20 EFC
% out_efc_1 = load('efc_smf_NEW_32act/efc_D_shape_hex_smf_wfe_nm_BW20_Xpos0_Ypos6_Xoff0_Yoff6_all.mat', 'out').('out');

% % BB iEFC
% out_iefc_1 = load('iefc_smf_34act/iefc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_6modes_all.mat', 'out').('out').InormFiberHist;
out_iefc_2 = load('iefc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_20iters_all.mat', 'out').('out').InormFiberHist;
out_iefc_3 = load('iefc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_64modes_20iters_all.mat', 'out').('out').InormFiberHist;
out_iefc_4 = load('iefc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_112modes_20iters_all.mat', 'out').('out').InormFiberHist;
% out_iefc_3 = load('iefc_smf_34act/iefc_test_all.mat');


% out_iefc_5 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW10_Xpos7_Ypos0_Xoff7_Yoff0_all.mat', 'out').('out').InormFiberHist(9);
% out_iefc_6 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW10_Xpos4_Ypos0_Xoff4_Yoff0_all.mat', 'out').('out').InormFiberHist(9);
% out_iefc_7 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW10_Xpos4.5_Ypos-4.5_Xoff4.5_Yoff-4.5_all.mat', 'out').('out').InormFiberHist(9);
% out_iefc_8 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW10_Xpos4.5_Ypos4.5_Xoff4.5_Yoff4.5_all.mat', 'out').('out').InormFiberHist(9);
% out_iefc_9 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW10_Xpos-6_Ypos0_Xoff-6_Yoff0_all.mat', 'out').('out').InormFiberHist(9);
% out_iefc_10 = load('iefc_smf_NEW_32act/iefc_hex_smf_wfe_nm_BW10_Xpos0_Ypos4.5_Xoff0_Yoff4.5_all.mat', 'out').('out').InormFiberHist(9);


% BB 20 iEFC
% out_iefc_1 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW20_Xpos0_Ypos6_Xoff0_Yoff6_all.mat', 'out').('out');
% out_iefc_2 = load('iefc_smf_NEW_32act/iefc_D_shape_hex_smf_wfe_nm_BW20_Xpos0_Ypos6_Xoff0_Yoff6_fewermodes_all.mat', 'out').('out');


% efc_fin_ni = [out_efc_1, out_efc_2, out_efc_3, out_efc_4, out_efc_5, out_efc_6, out_efc_7, out_efc_8, out_efc_9];
% efc_fin_ni = [out_efc_1, out_efc_6, out_efc_10, out_efc_4, out_efc_2, out_efc_9, out_efc_7, out_efc_8, out_efc_5, out_efc_3];

% iefc_fin_ni = [out_iefc_1, out_iefc_6, out_iefc_10, out_iefc_4, out_iefc_2, out_iefc_9, out_iefc_7, out_iefc_8, out_iefc_5, out_iefc_3];

% iefc_fin_ni = [out_iefc_1, out_iefc_2, out_iefc_3, out_iefc_4, out_iefc_5, out_iefc_6, out_iefc_7, out_iefc_8, out_iefc_9];

% abs_distance = [3.5, 6, 8, 5.5, 7, 4, 6.36, 6.36, 6];
% abs_distance = [3.5, 4, 4.5, 5.5, 6, 6, 6.36, 6.36, 7, 8];

% 
% inormvals_iefc_1 = out_iefc_1.InormFiberHist;
% inormvals_iefc_2 = out_iefc_2.InormFiberHist;
% inormvals_iefc_3 = out_iefc_3.InormFiberHist;
% inormvals_iefc_4 = out_iefc_4.InormFiberHist;
% inormvals_iefc_5 = out_iefc_5.InormFiberHist;


% inormvals_iefc_smf1 = out_iefc_smf1.InormFiberHist;
% inormvals_iefc_smf2 = out_iefc_smf2.InormFiberHist;
% inormvals_iefc_smf3 = out_iefc_smf3.InormFiberHist;


itrs = linspace(0, 20, 21);
% itrs = linspace(0, 15, 16);

%% Plot data
figure();

set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter', 'latex','FontSize',16);

Cmap1 = lines(4);

semilogy(itrs, out_efc_1, '-o', 'color', Cmap1(1,:), 'DisplayName', 'EFC')

title('EFC/IEFC SMF Comparison at (0, -8) $\lambda/D$ (10 nm WFE) ($30\%$ BW)')

xlabel('Iteration')
ylabel('Normalized Intensity')
% 
hold on
% 
% semilogy(itrs, out_iefc_1, '--o', 'color', Cmap1(2,:), 'DisplayName', 'iEFC (6 modes)')


semilogy(itrs, out_iefc_2, '--o', 'color', Cmap1(2,:), 'DisplayName', 'iEFC (24 modes)')
% 
% xlabel('Iteration')
% ylabel('log(Normalized Intensity)')

semilogy(itrs, out_iefc_3, '--o', 'color', Cmap1(3,:), 'DisplayName', 'iEFC (64 modes)')
% semilogy(itrs, inormvals_iefc_1, '--o', 'color', 'cyan', 'DisplayName', 'iEFC (7, 0) \lambda/D')
semilogy(itrs, out_iefc_4, '--o', 'color', Cmap1(4,:), 'DisplayName', 'iEFC (112 modes)')

% semilogy(itrs, out_iefc_5, '--o', 'color', Cmap1(5,:), 'DisplayName', 'iEFC (112 modes)')

% title('EFC/IEFC SMF Comparison (10nm WFE) (BW-10%)')
% 
% xlabel('Radial Distance From Vortex Center (\lambda/D)')
% ylabel('log(Normalized Intensity)')
% 
% hold on
% semilogy(abs_distance, iefc_fin_ni, '-o', 'color', 'cyan', 'DisplayName', 'iEFC ')
% % semilogy(itrs, inormvals_iefc_2, '--o', 'color', 'red', 'DisplayName', 'iEFC (0, 6) \lambda/D')
% % semilogy(itrs, inormvals_iefc_3, '--o', 'color', 'magenta', 'DisplayName', 'iEFC (0, -8) \lambda/D')
% % semilogy(itrs, inormvals_iefc_4, '--o', 'color', 'blue', 'DisplayName', 'iEFC (5.5, 0) \lambda/D')
% % 
% % semilogy(itrs, inormvals_efc_1, '-o', 'color', 'cyan', 'DisplayName', 'EFC (0, 3.5) \lambda/D')
% % semilogy(itrs, inormvals_efc_2, '-o', 'color', 'red', 'DisplayName', 'EFC (0, 6) \lambda/D')
% % semilogy(itrs, inormvals_efc_3, '-o', 'color', 'magenta', 'DisplayName', 'EFC (0, -8) \lambda/D')
% % semilogy(itrs, inormvals_efc_4, '-o', 'color', 'blue', 'DisplayName', 'EFC (5.5, 0) \lambda/D')
% 
% % semilogy(itrs, inormvals_iefc_2, '--o', 'color', 'red', 'DisplayName', 'iEFC (4, 0) \lambda/D')
% % semilogy(itrs, inormvals_iefc_3, '--o', 'color', 'magenta', 'DisplayName', 'iEFC (4.5, -4.5) \lambda/D')
% % semilogy(itrs, inormvals_iefc_4, '--o', 'color', 'blue', 'DisplayName', 'iEFC (4.5, 4.5) \lambda/D')
% % semilogy(itrs, inormvals_iefc_5, '--o', 'color', 'green', 'DisplayName', 'iEFC (-6, 0) \lambda/D')
% % 
% % semilogy(itrs, inormvals_efc_1, '-o', 'color', 'red', 'DisplayName', 'EFC (0, 6) \lambda/D')
% % semilogy(itrs, inormvals_efc_1, '-o', 'color', 'cyan', 'DisplayName', 'EFC (7, 0) \lambda/D')
% % semilogy(itrs, inormvals_efc_2, '-o', 'color', 'red', 'DisplayName', 'EFC (4, 0) \lambda/D')
% % semilogy(itrs, inormvals_efc_3, '-o', 'color', 'magenta', 'DisplayName', 'EFC (4.5, -4.5) \lambda/D')
% % semilogy(itrs, inormvals_efc_4, '-o', 'color', 'blue', 'DisplayName', 'EFC (-6, 0) \lambda/D')
% % semilogy(itrs, inormvals_efc_5, '-o', 'color', 'green', 'DisplayName', 'EFC (-6, 0) \lambda/D')

hold off
% 
legend('Location', 'northeast')

% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/contrast_v_modes_10nmwfe_bb30.png')
% print('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/contrast_v_modes_10nmwfe_bb30_5cases', '-dsvg')
% exportgraphics(gcf,'/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/contrast_v_modes_10nmwfe_bb30_NEW.eps','BackgroundColor','none','ContentType','vector')
