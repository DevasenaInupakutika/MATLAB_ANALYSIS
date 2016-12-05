%Assuming linear model initially
%Compute the regression coefficients for a linear model with an interaction term.
X = [ones(size(X1)) X1 X2 X1.*X2];
b = regress(Y1,X);    % Removes NaN data

%Plot the data and the model
scatter3(X1,X2,Y1,'filled')
hold on
x1fit = min(X1):100:max(X1);
x2fit = min(X2):10:max(X2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('X1')
ylabel('X2')
zlabel('Y1')
view(50,10)
