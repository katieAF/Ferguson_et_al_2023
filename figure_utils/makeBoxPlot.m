function plbx = makeBoxPlot(x, y, bxLabel, bxColor)

% MAKEBOXPLOT creates a customized box plot with specified labels and colors.
% 
% Inputs:
% - x: a numeric vector containing the data to be plotted.
% - y: a numeric vector specifying the grouping variable.
% - bxLabel: a cell array of strings specifying the labels for each box.
% - bxColor: a cell array of strings specifying the colors for each box.
%
% Outputs: 
% - plbx: a handle to the box plot object.
%
% Usage:
% plbx = makeBoxPlot(x, y, bxLabel, bxColor)
%
% written by Katie Ferguson, Yale University, 2023


plbx = boxplot(x, y, ...
    'symbol','','Labels', bxLabel, 'Color', bxColor);

hold on;


% adjust colors, highlight median
h=findobj('LineStyle','--'); set(h, 'LineStyle','-');
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'), h(j).Color,'FaceAlpha',.9);
end
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k','linewidth',2);
