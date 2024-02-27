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
mp.path.ws = '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/efc_smf_34act/contrast_v_modes_final/'; % (Mostly) complete workspace from end of trial. Default is [mp.path.falco filesep 'data' filesep 'ws' filesep];
mp.flagSaveWS = false;  %--Whether to save out entire (large) workspace at the end of trial. Default is false

% ws_new = load('Series0001_Trial0005__Itrs0020_vortex_LUVOIR_B_1DM32_z0.2_IWA2_OWA10_5lams650nm_BW10_gridsearchEFCDM1_all.mat');
% Step 2: Load model parameters
% % 
% mp.fracBW = 0.2;
% mp.Nsbp = 9;
% 
mp.fracBW = 0.3;
mp.Nsbp = 13;
% 
% mp.fracBW = 0.1;
% mp.Nsbp = 5;
% % 
% mp.fracBW = 0.01;
% mp.Nsbp = 1;
mp.Nwpsbp = 1;          %--Number of wavelengths to used to approximate an image in each sub-bandpass

mp.Fend.x_fiber = [0];
mp.Fend.y_fiber = [-8];%[-3 0 4.625 -4.625];
mp.Fend.Nfiber = numel(mp.Fend.x_fiber);

HCST_SMF_model_IEFC_NEW;

% HCST_noSMF_model_iEFC_final;

mp.dm1.basisType = 'actuator';
mp.dm2.basisType = 'actuator';


mp.estimator = 'perfect';


% % Fiber parameters
mp.flagFiber = true;
mp.flagLenslet = false;

mp.thput_eval_x = mp.Fend.x_fiber;
mp.thput_eval_y = mp.Fend.y_fiber;

mp.source_x_offset_norm = mp.Fend.x_fiber;
mp.source_y_offset_norm = mp.Fend.y_fiber;

% mp.Fend.x_fiber = [1]; %[7];%[8 5 5.3405 -2.6702 -2.6702]; %Fiber core center positions in lambda_0/D
% mp.Fend.y_fiber = [0];%[-3 0 4.625 -4.625];
% mp.Fend.Nfiber = numel(mp.Fend.x_fiber);

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

%--Record Keeping
mp.SeriesNum = 3;
mp.TrialNum = 1;

% mp.lambda0 = 750e-9;    %--Central wavelength of the whole spectral bandpass [meters]

%--Use just 1 wavelength for initial debugging/testing of code
% mp.fracBW = [0.01, 0.01, 0.05, 0.1, 0.15, 0.2];       %--fractional bandwidth of the whole bandpass (Delta lambda / lambda0)
% mp.fracBW = 0.1;
% mp.Nsbp = 5;

% mp.fracBW = 0.2;
% mp.Nsbp = 9;

% mp.fracBW = 0.01;
% mp.Nsbp = 1;
% mp.Nsbp = 10;
% mp.Nsbp = [1, 3, 5, 5, 7, 9];            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control
% mp.Nsbp = ones(1, 6)*5;            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control

% mp.est.probe.radius = 8;    % Max x/y extent of probed region [lambda/D].


mp.Nwpsbp = 1;          %--Number of wavelengths to used to approximate an image in each sub-bandpass

mp.Nitr = 20; %--Number of wavefront control iterations
% mp.Nitr = 1; %--Number of wavefront control iterations

% mp.Nitr = 8; %--Uncomment for fiber
mp.dm_ind = 1; % Specify which DM to use

% mp.relinItrVec = 1;  %--Which correction iterations at which to re-compute the control Jacobian
% mp.relinItrVec = [];  %--Which correction iterations at which to re-compute the control Jacobian


% mp.Fend.sides = 'left'; %--Which side(s) for correction: 'both', 'left', 'right', 'top', 'bottom'

%% Step 4: Generate the label associated with this trial

% mp.runLabel = ['efc_Series',num2str(mp.SeriesNum,'%04d'),'_Trial',num2str(mp.TrialNum,'%04d_'), '_Itrs',num2str(mp.Nitr,'%04d_'),...
%     mp.coro,'_',mp.whichPupil,'_',num2str(numel(mp.dm_ind)),'DM',num2str(mp.dm1.Nact),'_z',num2str(mp.d_dm1_dm2),...
%     '_IWA',num2str(mp.Fend.corr.Rin),'_OWA',num2str(mp.Fend.corr.Rout),...
%     '_',num2str(mp.Nsbp),'lams',num2str(round(1e9*mp.lambda0)),'nm_BW',num2str(mp.fracBW*100),...
%     '_',mp.controller, 'DM', num2str(mp.dm_ind)];


% mp.runLabel = ['efc_D_shape_smf_wfe_bb_7lambda0D'];

mp.runLabel = ['efc_', mp.dm1.fourier_gridType, '_smf_', num2str(zern_error_rms*1e9), 'nmwfe_', 'BW',num2str(mp.fracBW*100), '_Xpos', num2str(mp.Fend.x_fiber),...
    '_Ypos', num2str(mp.Fend.y_fiber), '_Xoff', num2str(mp.Fend.xiOffset), '_Yoff', num2str(mp.Fend.etaOffset), '_', num2str(mp.Nitr), 'iters'];

%% Step 5: Perform the Wavefront Sensing and Control

[mp, out] = falco_flesh_out_workspace(mp);

mp.tstart = tic;
[mp, out] = falco_wfsc_loop(mp, out);
% mp.tEnd = toc(tstart);


% %% Step 6: Plot result
% itrs = linspace(1, 20, 20);
% inormVals = out.Inormhist;


