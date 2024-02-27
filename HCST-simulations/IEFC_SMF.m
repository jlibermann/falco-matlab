% Copyright 2018-2021 by the California Institute of Technology. ALL RIGHTS
% RESERVED. United States Government Sponsorship acknowledged. Any
% commercial use must be negotiated with the Office of Technology Transfer
% at the California Institute of Technology.
% -------------------------------------------------------------------------
%
% Script to run wavefront control on a vortex coronagraph with a segmented
% input pupil.

clear
clc
close all;

%% Step 1: Define Necessary Paths on Your Computer System

%--Required packages are FALCO and PROPER. 
% Add FALCO to the MATLAB path with the command:  addpath(genpath(full_path_to_falco)); savepath;

addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/')
% addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;


%%--Output Data Directories (Comment these lines out to use defaults within falco-matlab/data/ directory.)
% mp.path.config = ; %--Location of config files and minimal output files. Default is [mp.path.falco filesep 'data' filesep 'brief' filesep]
mp.path.ws = '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc_smf_34act/contrast_v_modes_final/'; % (Mostly) complete workspace from end of trial. Default is [mp.path.falco filesep 'data' filesep 'ws' filesep];
mp.flagSaveWS = true;  %--Whether to save out entire (large) workspace at the end of trial. Default is false


%% Step 2: Load model parameters

% mp.dm1.Nact = 16;               % # of actuators across DM array
% % % % 
% mp.fracBW = 0.01;
% mp.Nsbp = 1;
% % 

mp.fracBW = 0.3;
mp.Nsbp = 13;
% mp.fracBW = 0.2;
% mp.Nsbp = 9;
mp.Nwpsbp = 1;          %--Number of wavelengths to used to approximate an image in each sub-bandpass

mp.Fend.x_fiber = [0];
mp.Fend.y_fiber = [-8];%[-3 0 4.625 -4.625];
mp.Fend.Nfiber = numel(mp.Fend.x_fiber);

HCST_SMF_model_IEFC_NEW;
% HCST_SMF_model_IEFC_Dshape;
% HCST_noSMF_model_iEFC_final;
mp.estimator = 'iefc';
mp.ctrl.flagUseModel = false; 


% % Fiber parameters
mp.flagFiber = true;
mp.flagLenslet = false;

mp.thput_eval_x = mp.Fend.x_fiber;
mp.thput_eval_y = mp.Fend.y_fiber;

mp.source_x_offset_norm = mp.Fend.x_fiber;
mp.source_y_offset_norm = mp.Fend.y_fiber;
% Josh: Changed fober position to center fiber within DH
% [8] [5 5.3405 -2.6702 -2.6702]; %Fiber core center positions in lambda_0/D
% mp.Fend.x_fiber = [7];% [8] [5 5.3405 -2.6702 -2.6702]; %Fiber core center positions in lambda_0/D

mp.fiber.a = 0.507;%0.875;%0.66; %Radius of the fiber core in lambda_0/D
mp.fiber.a_phys = 1.75e-6; %Physical radius of the fiber core in meters
mp.fiber.NA = 0.12; %Numerical aperture of the fiber

% %% Specify bandwidths
% bws = [0.01, 0.05, 0.15];
% nsbps = [5, 5, 5];

%% Step 3: Overwrite default values as desired

%%--Special Computational Settings
mp.flagParfor = false; %--whether to use parfor for Jacobian calculation
mp.flagPlot = true;

%--Record Keeping     Series 3 = shifted fiber position
%                        Series 4 = Changed DH region to circular, changed
%                        # of actuators
mp.SeriesNum = 1;
mp.TrialNum = 1;

% mp.lambda0 = 750e-9;    %--Central wavelength of the whole spectral bandpass [meters]

%--Use just 1 wavelength for initial debugging/testing of code
% mp.fracBW = [0.01, 0.01, 0.05, 0.1, 0.15, 0.2];       %--fractional bandwidth of the whole bandpass (Delta lambda / lambda0)


% Start w/ monochromatic and then move to polychromatic (10, 15, 20%)


% mp.fracBW = 0.2;
% mp.Nsbp = 9;

% mp.Nsbp = [1, 3, 5, 5, 7, 9];            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control
% mp.Nsbp = ones(1, 6)*5;            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control


mp.Nitr = 20; %--Number of wavefront control iterations
% mp.Nitr = 8; %--(Uncomment for fiber)
% mp.Nitr = 2; %--(Uncomment for fiber)


% mp.est.probe.radius = 8;    % Max x/y extent of probed region [lambda/D].

% mp.ctrl.log10regVec = -6:1:-1; %--log10 of the regularization exponents (often called Beta values)

mp.jac.fn = 'jac_iefc_24modes_BW30.mat'; %'jac_iefc_test.mat'; % Name of the Jacobian file to save or that is already saved. The path to this file is set by mp.path.jac.

% mp.relinItrVec = []; %[];%1; %[];  %--Correction iterations at which to re-compute the Jacobian. Make an empty vector to load mp.jac.fn

mp.relinItrVec = 1;

%% Flesh out the workspace
[mp, out] = falco_flesh_out_workspace(mp);


%% Define the probes to use 

dmVsin = sum(mp.dm1.basisCube(:, :, 1:mp.dm1.NbasisModes/2), 3);
figure(31); imagesc(dmVsin); axis xy equal tight; colorbar; colormap parula;
dmVcos = sum(mp.dm1.basisCube(:, :, mp.dm1.NbasisModes/2+1:end), 3);
figure(32); imagesc(dmVcos); axis xy equal tight; colorbar; colormap parula;

mp.iefc.probeCube = zeros(mp.dm1.Nact, mp.dm1.Nact, 2);
mp.iefc.probeCube(:, :, 1) = dmVsin;
mp.iefc.probeCube(:, :, 2) = dmVcos;

mp.iefc.modeCoef = 1e-3; %--Gain coefficient to apply to the normalized DM basis sets for the empirical SCC calibration.
mp.iefc.probeCoef = 1e-3; %--Gain coefficient to apply to the stored probe commands used for IEFC state estimation.

% mp.iefc.modeCoef = 1e-4; %--Gain coefficient to apply to the normalized DM basis sets for the empirical SCC calibration.
% mp.iefc.probeCoef = 1e-4; 

mp.iefc.probeDM = 1; %--Which DM to use when probing for IEFC.


%% Verify visually that the Fourier modes fully cover the dark hole

freqMax = max([max(mp.dm1.fourier_basis_xis), max(mp.dm1.fourier_basis_etas)]);

set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter', 'latex','FontSize',20);

figure(111);
imagesc(mp.Fend.xisDL, mp.Fend.etasDL, mp.Fend.corr.maskBool); colormap gray;
set(gca, 'Fontsize', 20);
set(gcf, 'Color', 'w');
hold on;
h111 = plot(mp.dm1.fourier_basis_xis , mp.dm1.fourier_basis_etas, 'or');
set(h111, 'MarkerFaceColor', 'r', 'MarkerSize', 5);
ylabel('$\lambda_0$/D','FontSize',20,'Interpreter','LaTeX');
xlabel('$\lambda_0$/D','FontSize',20,'Interpreter','LaTeX');
title('Overlay of Fourier Modes on the Dark Hole')
axis xy equal tight;
hold off;
drawnow;
% saveas(h111, '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/fourier_dh.png')
%% Step 4: Generate the label associated with this trial

% mp.runLabel = ['Series',num2str(mp.SeriesNum,'%04d'),'_Trial',num2str(mp.TrialNum,'%04d_'), '_Itrs',num2str(mp.Nitr,'%04d_'),...
%     mp.coro,'_',mp.whichPupil,'_',num2str(numel(mp.dm_ind)),'DM',num2str(mp.dm1.Nact),'_z',num2str(mp.d_dm1_dm2),...
%     '_IWA',num2str(mp.Fend.corr.Rin),'_OWA',num2str(mp.Fend.corr.Rout),...
%     '_',num2str(mp.Nsbp),'lams',num2str(round(1e9*mp.lambda0)),'nm_BW',num2str(mp.fracBW*100),...
%     '_SubBP', num2str(mp.Nsbp), '_', mp.controller, '_DM', num2str(mp.dm_ind)];

% mp.runLabel = ['iefc_', mp.dm1.fourier_gridType, '_smf_wfe_', 'nm_BW',num2str(mp.fracBW*100), '_Xpos', num2str(mp.Fend.x_fiber),...
%     '_Ypos', num2str(mp.Fend.y_fiber), '_Xoff', num2str(mp.Fend.xiOffset), '_Yoff', num2str(mp.Fend.etaOffset), '_112modes'];

mp.runLabel = ['iefc_', mp.dm1.fourier_gridType, '_smf_', num2str(zern_error_rms*1e9), 'nmwfe_', 'BW',num2str(mp.fracBW*100), '_Xpos', num2str(mp.Fend.x_fiber),...
    '_Ypos', num2str(mp.Fend.y_fiber), '_Xoff', num2str(mp.Fend.xiOffset), '_Yoff', num2str(mp.Fend.etaOffset), '_', num2str(mp.dm1.NbasisModes), 'modes', '_', num2str(mp.Nitr), 'iters'];

% mp.runLabel = ['iefc_test'];

% print('-f111', append(mp.path.ws, mp.runLabel, '_Fourier_overlay.svg'), '-dsvg')
%% Step 5: Perform the Wavefront Sensing and Control

% f = @() falco_wfsc_loop(mp, out);

mp.tstart = tic;
[mp, out] = falco_wfsc_loop(mp, out);
% mp.tEnd = toc(tstart);

% t = timeit(f, 2);
% %% Step 6: Plot result
% itrs = linspace(1, 20, 20);
% inormVals = out.Inormhist;


