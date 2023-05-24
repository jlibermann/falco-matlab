%% Set Paths

clear;
close all;

addpath('/home/vfndev/Documents/MATLAB/VFN-Simulations/ScalarOnPrimary_Simulations/')
addpath('/home/vfndev/Documents/MATLAB/VFN-Simulations/VFNlib/')

setPaths;

%% Setup Struct
%-- Provide regular parameters
% Define sampling info
N = 2^7; % Size of computational grid (NxN samples) 
apRad = N/2-4; % Aperture radius in samples 

% Define wavelength info
lambda0 = 635; %central wavelength
fracBW = 0.1; %\Delta\lambda/\lambda
% numWavelengths = 1;% number of discrete wavelengths 
% lambdas = getWavelengthVec(lambda0,fracBW,numWavelengths);% array of wavelengths (meters)


%-- Parameters for SMF (Thorlabs SM600 in this case)
%     % link: https://www.thorlabs.com/NewGroupPage9_PF.cfm?ObjectGroup_ID=949
fiber_props.core_rad = 11e-6/2;% Core radius [um]
fiber_props.n_core = 1.4436;% core index (interp @650nm)
fiber_props.n_clad = 1.4381;% cladding index (interp @650nm)
fiber_props.type = 'bessel';

%-- Define parameters for falco MFT propagator
    % these don't matter in themselves as long as they are consistent w/ each 
    % other and with lambda
% OPTION 1: define focal length and pup diameter manually
%foc = 11e-3;      %[m] final focal length
DPup = 2.45e-3;    %[m] pupil size 
% OPTION 2: solve for focal length based on ideal Fnum and pup diameter
Fnum = getMFD(fiber_props,lambda0)/(lambda0*1.45); % focal ratio of the beam at the fiber
foc = Fnum*DPup;
fprintf('Focus in use: %f [mm]\n',foc*1e3)

% Since using falco MFT propogator, can choose our final image sampling
lambda0Fnum_samp = 50; %[samples/ (lam0 F#)] in units of samples in the image plane
im_size = 10;    %[lam0/D] field of view in final image plane

%-- Coordinates in the focal plane
coordsPP = generateCoordinates(N);% Creates NxN arrays with coordinates 
% Helpful for plotting: get axes coords in pupil radii
xvalsPP = coordsPP.xvals/apRad;
yvalsPP = coordsPP.yvals/apRad;

%-- Coordinates in the pupil plane
Nxi = im_size*lambda0Fnum_samp;
coordsFP = generateCoordinates( Nxi );
% Helpful for plotting: get axes coords in lam/D 
xvalsFP = coordsFP.xvals/lambda0Fnum_samp;
yvalsFP = coordsFP.yvals/lambda0Fnum_samp;

%-- Key values for getting scaling right using falco MFT propagator
% Lambda over D of central wavelength in meters at final focal plane 
lambda0Fnum_meters = lambda0*foc/DPup;     
% "pixel" size in pupil and image planes
coordsPP.dx  = DPup/(2*apRad);   % meters/sample
coordsFP.dx = lambda0Fnum_meters/lambda0Fnum_samp;     % meters/sample

% Generate pupil 
PUPIL = makeCircularPupil( apRad, N );
% Get norm for coupling fractions (simple sum since using MFT propagator)
totalPower0 = sum(abs(PUPIL(:)));