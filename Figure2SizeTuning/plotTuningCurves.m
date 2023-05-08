function cfg = plotTuningCurves(vis, cfg, f)
% PLOTTUNINGCURVES - Function to create tuning curves with fits
%
% Inputs:
%    vis   - Structure containing tuning curve data (mean +/- SEM in vis.meanZca and vis.semZca),
%            as well as experiment type and state categories
%    cfg   - Configuration structure containing plot settings and options
%    f     - Figure handle for the plot
%
% Outputs:
%    cfg   - Updated configuration structure
%
% This function generates tuning curves with fits for the given data. It
% iterates through unique experiment types and states, and creates tuning
% curves for each combination. The plot is created in the given figure
% handle (f). Colors and other plot properties are defined in the input
% configuration structure (cfg).
%

set(0,'CurrentFigure',f);

% max/min for y axis limits
mx = max(vis.meanZca + vis.semZca);
mn = min(vis.meanZca - vis.semZca);

unExpType = unique(vis.expType);
unState = unique(vis.state);

% iterate through control vs caspase
for iExp = 1:length(unExpType)

    nexttile(cfg.plt.tilePlc(cfg.plt.cnt), cfg.plt.tileIdx(cfg.plt.cnt, :))

    % iterate through locomotion and quiescence states
    for iState = 1:length(unState)

        idx = vis.expType == unExpType(iExp) & vis.state == unState(iState);

        % set color
        col = cfg.plt.colors{iExp}(iState,:);

        % plot errorbar
        errorbar(vis.size(idx), vis.meanZca(idx), vis.semZca(idx), ...
            's','Color', col, 'CapSize', 0, 'MarkerSize', 10, 'MarkerEdgeColor', col,'MarkerFaceColor', col);
        hold on;

        % fit curves
        [xCurve, fitCurve] = fitTuningCurve(vis.size(idx), vis.meanZca(idx), cfg);

        hold on;
        plot(xCurve, fitCurve,'linewidth',1.5,'Color', col);

    end

    xlabel(cfg.plt.tune.xlabel, 'FontSize', 12);
    ylabel(cfg.plt.tune.ylabel, 'FontSize', 12)
    ylim([mn, mx]);

    cfg.plt.cnt = cfg.plt.cnt + 1;  % add to counter

end

end



function [xCurve, fitCurve] = fitTuningCurve(xVal, yVal, cfg)
% FITTUNINGCURVE - Function to fit tuning curve data using a custom error function
%
% Inputs:
%    xVal - X values of the tuning data points
%    yVal - Y values of the tuning data points
%    cfg  - Configuration structure containing initial values for curve fitting
%
% Outputs:
%    xCurve   - X values of the fitted tuning curve
%    fitCurve - Y values of the fitted tuning curve
%
% This function fits tuning curve data using a custom error function (erf).
% The function takes the X and Y values of the tuning curve data points, and
% a configuration structure (cfg) containing the initial values for curve fitting.
% It returns the X and Y values of the fitted tuning curve, which can be used
% for plotting.

erf_fitT = @(x,xdata) x(1)*(erf(xdata/x(2))- x(3)*erf(xdata/x(4)))+x(5);
erf_fit = 'a*(erf(x/b) - c*erf(x/d)) + e';
x0 = cfg.plt.tune.x0;

fmn = fit(xVal, yVal, erf_fit, 'Start', x0);
xmn = coeffvalues(fmn);

xCurve = linspace(0,max(xVal),2000);
fitCurve = erf_fitT(xmn,xCurve);

end