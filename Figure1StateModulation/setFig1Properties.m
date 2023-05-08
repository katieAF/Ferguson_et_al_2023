function cfg = setFig1Properties(cfg, infoSummary) 
% SETFIGPROPFIGURE1 sets properties for figure 1 and stores in variable "cfg"
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

cfg.plt.histrange = -1:0.1:1;
cfg.plt.xlimrange = [-1,1];
cfg.plt.xlabel = 'Modulation Index';
cfg.plt.ylabel = 'Cells';
cfg.plt.subplotIdx = {[1,2,4,5],[7,8,10,11],[6,9]};
cfg.plt.subplotSz = [4,3];
cfg.plt.boxrange = [-1,1]; 
cfg.plt.bxylabel = 'Modulation Index';

% set individual figure properties for each experiment

cfg.plt.expTypeStr = infoSummary.expTypeFig;
cfg.plt.colors = infoSummary.expTypeFigCol;
cfg.plt.fullTitle = infoSummary.fullExpType;
cfg.plt.expType = infoSummary.expType;


end