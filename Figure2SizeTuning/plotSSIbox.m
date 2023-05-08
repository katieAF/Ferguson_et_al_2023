function cfg = plotSSIbox(SI, cfg, f)
% PLOTSSIBOX - Function to create box and whisker plots for surround
% suppression indices (SI)
%
% Inputs:
%    SI    - Structure containing surround suppression indices, along with experiment
%           type and state categories
%    cfg   - Configuration structure containing plot settings and options
%    f     - Figure handle for the plot
%
% Outputs:
%    cfg   - Updated configuration structure
%
% This function generates box and whisker plots for the surround suppression indices. 
% The colors for different states are defined in the input
% configuration structure (cfg). The function iterates over unique states
% and creates box plots for each state. The plot is created in the given
% figure handle (f).
%
% Katie Ferguson, Yale University, 2023


unState = unique(SI.state);

set(0,'CurrentFigure',f);
warning('off')

bxColorFull = [cfg.plt.colors{:}];

for iState = 1:length(unState)

nexttile(cfg.plt.tilePlc(cfg.plt.cnt), cfg.plt.tileIdx(cfg.plt.cnt, :));
hold on;

% set colors
bxColor = reshape(bxColorFull(iState,:), [], 2)';   % reshape so [ctrl;casp] for specific state 

idx = SI.state == unState(iState); 

% box plot 
plbx = makeBoxPlot(SI.SI(idx), SI.expType(idx), {'',''}, bxColor);

ylabel(cfg.plt.box.ylabel, 'FontSize', 12);
ylim(cfg.plt.box.ylim); 

cfg.plt.cnt = cfg.plt.cnt + 1;  % add to counter

end

end

