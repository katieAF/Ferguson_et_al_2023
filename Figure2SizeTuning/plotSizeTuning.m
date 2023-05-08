function plotSizeTuning(varargin)

% PLOTSIZETUNING Plots size tuning curves, surround suppression histograms, and box plots for data 
% in Figure 2 of Ferguson et al. 2023.
%
%  For each population, it loads the data, sets experiment-specific figure properties, 
%  creates size tuning plots, surround suppression index (SSI) histograms, and 
%  box/whisker plots for the visual stimulation data.
%
% Usage:
%   plotSizeTuning(cfg) or plotSizeTuning()
%
% Input:
%   - cfg (optional): a struct that contains a path to the parent Ferguson_et_al_2023
%   directory in cfg.dir.baseDir.  If not given, will set cfg.dir.baseDir to current
%   directory, which assumes you're in the main Ferguson_et_al_2023 folder.
%
% Outputs:
%   - Generates figures with size tuning plots, SSI histograms, and box/whisker plots for 
%   each cell population's visual stimulation data.
%
% Dependencies:
%   - Requires data files 'VIP-SST_size.mat' and 'VIP-PN_size.mat', located in the Figure2SizeTuning folder.
%
% Data structure:
%   - The loaded data files contain a struct "vis" with fields:
%       - vis.size: vector of unique sizes of visual stimuli
%       - vis.meanZca: vector of mean z-scored Ca2+ responses to each
%       visual stimulus size
%       - vis.semZca: vector of S.E.M. z-scored Ca2+ responses to each
%       visual stimulus size
%       - vis.expType: vector indicating experiment type: control (1) or caspase (2)
%       - vis.state: vector indicating behavioral state: locomotion (1) or quiescence (2)
%   - A struct "SI" with fields:
%       - SI.SI: vector of surround suppression indices for each cell
%       - SI.expType: vector indicating experiment type: control (1) or caspase (2)
%       - SI.state: vector indicating behavioral state: locomotion (1) or quiescence (2)
%   and a struct "infoSummary" containing additional figure configuration details

% written by Katie A. Ferguson, Yale University, 2023

% define directory paths
if nargin ~= 0
    cfg = varargin{1};
else
    cfg.dir.baseDir = pwd;
end
cfg.dir.folder = fullfile(cfg.dir.baseDir, 'Figure2SizeTuning');

% run for SST and PN cell types
popTypes =  {'SST', 'PN'};
nExps = length(popTypes);

% iterate through cell types and plot
for iPop = 1:nExps

    % load size tuning data
    cfg.dir.MIFileName{iPop} = sprintf('VIP-%s_size.mat', popTypes{iPop});
    load(fullfile(cfg.dir.folder, cfg.dir.MIFileName{iPop}));

    % set figure properties
    cfg = setFig2Properties(cfg, infoSummary);

    % create figure
    f(iPop) = figure;
    t = tiledlayout(cfg.plt.subplotSz(1), cfg.plt.subplotSz(2), "TileSpacing","compact");
    set(f(iPop), 'Position', cfg.plt.position)
    title(t, cfg.plt.fullTitle)

    % plot tuning curves with fits
    cfg = plotTuningCurves(vis, cfg, f(iPop));

    % plot SSI histograms
    cfg = plotSSI(SI, cfg, f(iPop));

    % plot box/whisker plots for SSI
    cfg = plotSSIbox(SI, cfg, f(iPop));

end

end

