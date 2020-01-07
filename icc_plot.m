function icc_plot(X,icc_coeff)
%% This function would plot the scatter plot for the ICC analysis (as the ones on wikipaedia page)
% X is a n-by-w matrix with colums corresponding to persons and rows corresponding to measues, respectively.

hold on;
title(sprintf('%f',icc_coeff));

numGroups = size(X,1); % Groups
numSamples = size(X,2); % Number of samples or measurements in any given group

%% Set the figure parameters
xlim([0.5 numGroups+0.5]);
ylim([min(min(X))-0.02 max(max(X))+0.02]);

xticks(1:numGroups);

%% Plot the vertical lines and the dots
for g = 1:numGroups
    %xline(g,'--');
    scatter(g*ones(numSamples,1),X(g,:),[],'b');
end