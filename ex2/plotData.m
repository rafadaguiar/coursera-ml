function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

%Admitted
x1 = X(y==1,1);
y1 = X(y==1,2);

%Non Admitted
x2 = X(y==0,1);
y2 = X(y==0,2);

plot(x1,y1,"k+",'LineWidth',2,'Markersize',7);
plot(x2,y2,"ko",'MarkerFaceColor','y','Markersize',7);





% =========================================================================



hold off;

end
