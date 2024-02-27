clear
clc
close all;
%% Set paths
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/')
% addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;

%% Load data

% % BB EFC
% out_efc_1 = load('efc_smf_34act/efc_hex_smf_150nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out');


out_efc_1 = load('efc_smf_34act/efc_hex_smf_0nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_128modes_all.mat', 'out').('out').InormFiberHist(9);
out_efc_2 = load('efc_smf_34act/efc_hex_smf_20nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_128modes_all.mat', 'out').('out').InormFiberHist(9);
out_efc_3 = load('efc_smf_34act/efc_hex_smf_40nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
out_efc_4 = load('efc_smf_34act/efc_hex_smf_60nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
out_efc_5 = load('efc_smf_34act/efc_hex_smf_80nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
out_efc_6 = load('efc_smf_34act/efc_hex_smf_100nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_128modes_all.mat', 'out').('out').InormFiberHist(9);
out_efc_7 = load('efc_smf_34act/efc_hex_smf_150nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
out_efc_8 = load('efc_smf_34act/efc_hex_smf_200nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);



% BB 20 EFC
% out_efc_1 = load('efc_smf_NEW_32act/efc_D_shape_hex_smf_wfe_nm_BW20_Xpos0_Ypos6_Xoff0_Yoff6_all.mat', 'out').('out');

% % BB iEFC
out_iefc_7 = load('iefc_smf_34act/iefc_hex_smf_200nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out');


out_iefc_1 = load('iefc_smf_34act/iefc_hex_smf_0nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_2 = load('iefc_smf_34act/iefc_hex_smf_20nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_3 = load('iefc_smf_34act/iefc_hex_smf_40nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_4 = load('iefc_smf_34act/iefc_hex_smf_60nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_5 = load('iefc_smf_34act/iefc_hex_smf_80nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_6 = load('iefc_smf_34act/iefc_hex_smf_100nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_7 = load('iefc_smf_34act/iefc_hex_smf_150nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);
out_iefc_8 = load('iefc_smf_34act/iefc_hex_smf_200nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_24modes_all.mat', 'out').('out').InormFiberHist(9);

% out_iefc_4 = load('ief_smf_NEW_34act/iefc_hex_smf_10nmwfe_BW30_Xpos0_Ypos-8_Xoff0_Yoff-8_112modes_all.mat', 'out').('out').InormFiberHist;

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

Cmap1 = parula(2);
% itrs = linspace(0, 20, 21);
% itrs = linspace(0, 8, 9);
efc_fin_ni = [out_efc_1, out_efc_2, out_efc_3, out_efc_4, out_efc_5, out_efc_6, out_efc_7, out_efc_8];
iefc_fin_ni = [out_iefc_1, out_iefc_2, out_iefc_3, out_iefc_4, out_iefc_5, out_iefc_6, out_iefc_7, out_iefc_8];

wfe = [0, 20, 40, 60, 80, 100, 150, 200];

%% Plot data
figure();

set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter', 'latex','FontSize',16);

semilogy(wfe, efc_fin_ni, '-o', 'color', '#fc8d62', 'DisplayName', 'EFC')

% semilogy(itrs, out_efc_1, '-o', 'DisplayName', 'EFC (0 nm WFE)')
title('iEFC/EFC SMF Comparison at (0, -8) $\lambda/D$ (30$\%$ BW)')

xlabel('RMS Wavefront Error (nm)')
ylabel('Final Normalized Intensity')
% 
hold on

% semilogy(itrs, out_efc_2, '-o', 'DisplayName', 'EFC (10 nm WFE)')
% 
% semilogy(itrs, out_efc_3, '-o', 'DisplayName', 'EFC (20 nm WFE)')
% 
% semilogy(itrs, out_efc_4, '-o', 'DisplayName', 'EFC (30 nm WFE)')
% 
% semilogy(itrs, out_efc_5, '-o', 'DisplayName', 'EFC (100 nm WFE)')


% 
semilogy(wfe, iefc_fin_ni, '-o', 'color', '#66c2a5', 'DisplayName', 'iEFC')


% semilogy(itrs, out_iefc_3, '--o', 'color', 'cyan', 'DisplayName', 'iEFC (20 nm WFE)')
% % semilogy(itrs, inormvals_iefc_1, '--o', 'color', 'cyan', 'DisplayName', 'iEFC (7, 0) \lambda/D')
% semilogy(itrs, out_iefc_4, '--o', 'color', 'magenta', 'DisplayName', 'iEFC (30 nm WFE)')
% 
% semilogy(itrs, out_iefc_5, '--o', 'DisplayName', 'iEFC (100 nm WFE)')

hold off
% 
legend('Location', 'southeast')

% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/iefc_smf_fincontrast_diffwfe_bb30.png')
% print('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/iefc_smf_fincontrast_diffwfe_bb30', '-dsvg')
% exportgraphics(gcf,'/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_efc_figs/iefc_smf_fincontrast_diffwfe_bb30.eps','BackgroundColor','none','ContentType','vector')
