Data_sunday
%X1;
%X2;
X=[X1 X2];
Y1;
xdata=[X1 X2];
ydata=Y1;

[X1m,X2m] = meshgrid(X1, X2);
x = [tdm(:)  Trm(:)];                                               % Independent Variable Matrix
b0 = rand(4,1);                                                     % Initial Parameter Estimates
SSECF = @(b) sum((i(:) - i_fcn(b,x)).^2);                           % Sum-Squared-Error Cost Function
[b_estd, SSE] = fminsearch(SSECF, b0);                              % Estimate Parameters
i_fit = i_fcn(b_estd,x);                                            % Generate Fit Line
[beta,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(x, i(:), i_fcn, b_estd);
i_fit2 = i_fcn(beta,x);                                             % Generate Fit Line
i_mtx = reshape(i, 7, 7)';
i_fit2_mtx = reshape(i_fit2, 7, 7)';
figure(1)
surf(Trm, tdm, i_mtx)
hold on
stem3(Trm, tdm, i_fit2_mtx)
hold off
grid on
xlabel('T_r')
ylabel('t_m')
zlabel('\iti\rm (\itT_r,t_d\rm)')

modelfun=@(b,x)b(1).*tanh((b(2).*x(:,1))./360)+b(3) +b(4).*(x(:,2)); %with [1 500 1 500] gave better and lesser RMS Error

modelfun=@(b,x)b(1) + b(2) .* exp(-b(3) .* x(:,1)) %61.3 with [1 1 1] and [1 500 1]

modelfun=@(b,x)b(1) .* x(:,1) ./ (x(:,2) + b(2)) %64.3 with [500 500]

modelfun=@(b,x)(b(1) * b(2) + b(3) .* x(:,1).^ b(4)) ./ (b(2) + x(:,2).^b(4)) %with beta0 = [0 0.05 0 0.05] 32.4 RMSE

modelfun=@(b,x)b(1) ./ ((1 + b(3) .* exp(-b(2) .* x(:,1))).^ (1 / b(4))) %with beta0 = [0 0.5 0 0.5] 30.2 RMSE
%with beta0 = [0 0.1 0 0.1] gives 26.2 RMSE

%Useful resource on models -->
%http://www.ibm.com/support/knowledgecenter/SSLVMB_20.0.0/com.ibm.spss.statistics.help/cmd_nlr_models.htm 
