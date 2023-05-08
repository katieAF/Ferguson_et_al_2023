function cfg = setFig2Properties(cfg, infoSummary) 
% SETFIGPROPFIGURE2 sets properties for figure 2 and stores in the
% configuration structure (cfg)
% 
% Inputs:
%   - cfg: struct that stores plot properties in cfg.plt    
%   - infoSummary: struct that contains figure plot properties for each
%   experiment
% 
% Output: 
%   - cfg: struct with updated cfg.plt properties
% 

% set basic fig properties

cfg.plt.subplotSz = [4,6];
cfg.plt.tileIdx = [repmat([2,3], 2, 1); repmat([1,2], 6, 1)];
cfg.plt.tilePlc = [1; 4; 19; 13; 21; 15; 23; 17]; 
cfg.plt.position = [500 116 725 825]; 
cfg.plt.cnt = 1; % counter for the tile in tiledlayout

cfg.plt.tune.xlabel = 'Stimulus Diameter';
cfg.plt.tune.ylabel = 'z-scored F';
cfg.plt.tune.ylim = [-0.5, 6; -0.25, 2];
cfg.plt.tune.x0 = infoSummary.sizeTune.x0; 

cfg.plt.hist.binWidth = 0.075; 
cfg.plt.hist.xlabel = 'SSI'; 
cfg.plt.hist.xlim = [0, 0.2]; 
cfg.plt.hist.ylabel = infoSummary.stateType; 


cfg.plt.box.ylabel = 'SSI'; 
cfg.plt.box.ylim = [-0.05 1.05]; 

% set individual figure properties for each experiment

cfg.plt.expTypeStr = infoSummary.expTypeFig;
cfg.plt.colors = infoSummary.expTypeFigCol;
cfg.plt.fullTitle = strrep(infoSummary.fullExpType{1}, '_', ' ');
cfg.plt.expType = infoSummary.expType;


end