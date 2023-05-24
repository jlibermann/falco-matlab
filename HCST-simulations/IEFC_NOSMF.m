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
addpath('/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/')

setPathsJosh;


%%--Output Data Directories (Comment these lines out to use defaults within falco-matlab/data/ directory.)
% mp.path.config = ; %--Location of config files and minimal output files. Default is [mp.path.falco filesep 'data' filesep 'brief' filesep]
mp.path.ws = '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/falco-matlab/data/iefc/no_smf/'; % (Mostly) complete workspace from end of trial. Default is [mp.path.falco filesep 'data' filesep 'ws' filesep];
mp.flagSaveWS = true;  %--Whether to save out entire (large) workspace at the end of trial. Default is false


%% Step 2: Load model parameters

% mp.dm1.Nact = 16;               % # of actuators across DM array


HCST_NO_SMF_model_IEFC;
mp.estimator = 'iefc';
mp.ctrl.flagUseModel = false; 


% % Fiber parameters
mp.flagFiber = false;
mp.flagLenslet = false;

% Josh: Changed fober position to center fiber within DH
% mp.Fend.x_fiber = [5];% [8] [5 5.3405 -2.6702 -2.6702]; %Fiber core center positions in lambda_0/D
% % mp.Fend.x_fiber = [7];% [8] [5 5.3405 -2.6702 -2.6702]; %Fiber core center positions in lambda_0/D
% mp.Fend.y_fiber = [0];%[-3 0 4.625 -4.625];
% mp.Fend.Nfiber = numel(mp.Fend.x_fiber);
% 
% mp.fiber.a = 0.507;%0.875;%0.66; %Radius of the fiber core in lambda_0/D
% mp.fiber.a_phys = 1.75e-6; %Physical radius of the fiber core in meters
% mp.fiber.NA = 0.12; %Numerical aperture of the fiber

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
mp.SeriesNum = 5;
mp.TrialNum = 6;

% mp.lambda0 = 650e-9;    %--Central wavelength of the whole spectral bandpass [meters]

%--Use just 1 wavelength for initial debugging/testing of code
% mp.fracBW = [0.01, 0.01, 0.05, 0.1, 0.15, 0.2];       %--fractional bandwidth of the whole bandpass (Delta lambda / lambda0)
% mp.fracBW = 0.1;

% Start w/ monochromatic and then move to polychromatic (10, 15, 20%)
mp.fracBW = 0.01;
mp.Nsbp = 1;

% mp.fracBW = 0.1;
% mp.Nsbp = 5;

% mp.fracBW = 0.2;
% mp.Nsbp = 9;

% mp.Nsbp = [1, 3, 5, 5, 7, 9];            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control
% mp.Nsbp = ones(1, 6)*5;            %--Number of sub-bandpasses to divide the whole bandpass into for estimation and control

mp.Nwpsbp = 1;          %--Number of wavelengths to used to approximate an image in each sub-bandpass

mp.Nitr = 20; %--Number of wavefront control iterations

% mp.est.probe.radius = 8;    % Max x/y extent of probed region [lambda/D].

% mp.ctrl.log10regVec = -6:1:-1; %--log10 of the regularization exponents (often called Beta values)

mp.jac.fn = 'jac_iefc_SMF.mat'; %'jac_iefc_test.mat'; % Name of the Jacobian file to save or that is already saved. The path to this file is set by mp.path.jac.

mp.relinItrVec = 1; %[];%1; %[];  %--Correction iterations at which to re-compute the Jacobian. Make an empty vector to load mp.jac.fn
% mp.relinItrVec = [];

% % Specify clocking of dark hole
% mp.Fend.clockAngDeg = 0; % Clocking angle of the dark hole region
% % 
% % % mp.Fend.corr.ang  = 120;  % angular opening of dark hole correction region [degrees]
% % % mp.Fend.score.ang = 120;  % angular opening of dark hole scoring region [degrees]
% % 
% % %--Correction and scoring region definition
% % mp.Fend.corr.Rin = 2;   % inner radius of dark hole correction region [lambda0/D]
% % mp.Fend.corr.Rout  = 10;  % outer radius of dark hole correction region [lambda0/D]
% mp.Fend.corr.ang  = 360;  % angular opening of dark hole correction region [degrees]
% % 
% % mp.Fend.score.Rin = 2;  % inner radius of dark hole scoring region [lambda0/D]
% % mp.Fend.score.Rout = 10;  % outer radius of dark hole scoring region [lambda0/D]
% mp.Fend.score.ang = 360;  % angular opening of dark hole scoring region [degrees]
% 
% mp.dm_ind = 1; % Specify which DM to use
% mp.Fend.sides = 'left'; %--Which side(s) for correction: 'both', 'left', 'right', 'top', 'bottom'
% % mp.Fend.shape = 'D';
% % 
% 
% % Overwrite DM params
% mp.dm_ind = 1; % Specify which DM to use
% mp.Fend.sides = 'left'; %--Which side(s) for correction: 'both', 'left', 'right', 'top', 'bottom'

% Update probe commands in main script after calling falco_flesh_out_workspace(mp).
% mp.iefc.probeCube = zeros(mp.dm1.Nact, mp.dm1.Nact, 2);

% mp.dm1.fourier_spacing = 1; % Center-to-center spacing between Fourier modes in the focal plane. [lambda/D]
% mp.dm1.fourier_gridType = 'hex';  % Options: 'hex' or 'square'. 'hex' has a denser packing
% 
% xiMin = mp.Fend.corr.Rin-1;
% clocking = mp.Fend.clockAngDeg -180; % for 'left' dark hole.
% % clocking = mp.Fend.clockAngDeg -90; % for 'bottom' dark hole.
% 
% [mp.dm1.fourier_basis_xis , mp.dm1.fourier_basis_etas] = falco_choose_fourier_locations_polar(...
%     mp.dm1.Nact/2, mp.dm1.fourier_spacing, mp.dm1.fourier_gridType, xiMin, mp.Fend.corr.Rout+1, mp.Fend.corr.ang, clocking, xiMin);
% mp.Fend.corr.Rout  = 6.5;  % outer radius of dark hole correction region [lambda0/D]
% mp.Fend.score.Rout  = 6.5;  % outer radius of dark hole correction region [lambda0/D]


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
mp.iefc.probeDM = 1; %--Which DM to use when probing for IEFC.


%% Verify visually that the Fourier modes fully cover the dark hole

freqMax = max([max(mp.dm1.fourier_basis_xis), max(mp.dm1.fourier_basis_etas)]);

figure(111);
imagesc(mp.Fend.xisDL, mp.Fend.etasDL, mp.Fend.corr.maskBool); colormap gray;
set(gca, 'Fontsize', 20);
set(gcf, 'Color', 'w');
hold on;
h111 = plot(mp.dm1.fourier_basis_xis , mp.dm1.fourier_basis_etas, 'or');
set(h111, 'MarkerFaceColor', 'r', 'MarkerSize', 5);
title('Overlay of Fourier Modes on the Dark Hole')
axis xy equal tight;
hold off;
drawnow;
% saveas(h111, '/media/Data_Drive/KPIC/dev/jliberman/FALCO_Repo/HCST-simulations/fourier_dh.png')
%% Step 4: Generate the label associated with this trial

mp.runLabel = ['Series',num2str(mp.SeriesNum,'%04d'),'_Trial',num2str(mp.TrialNum,'%04d_'), '_Itrs',num2str(mp.Nitr,'%04d_'),...
    mp.coro,'_',mp.whichPupil,'_',num2str(numel(mp.dm_ind)),'DM',num2str(mp.dm1.Nact),'_z',num2str(mp.d_dm1_dm2),...
    '_IWA',num2str(mp.Fend.corr.Rin),'_OWA',num2str(mp.Fend.corr.Rout),...
    '_',num2str(mp.Nsbp),'lams',num2str(round(1e9*mp.lambda0)),'nm_BW',num2str(mp.fracBW*100),...
    '_SubBP', num2str(mp.Nsbp), '_', mp.controller, '_DM', num2str(mp.dm_ind)];


%% Step 5: Perform the Wavefront Sensing and Control


[mp, out] = falco_wfsc_loop(mp, out);


% %% Step 6: Plot result
% itrs = linspace(1, 20, 20);
% inormVals = out.Inormhist;


