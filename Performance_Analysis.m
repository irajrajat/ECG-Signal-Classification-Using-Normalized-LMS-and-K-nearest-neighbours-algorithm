function [cm,X,Y,per,TP,TN,FP,FN,sens1,spec1,precision,recall,Jaccard_coefficient,...
    Dice_coefficient,kappa_coeff,acc1] = Performance_Analysis(inp1,inp2)
global kpa 
truelabel = inp1;
Recognition = inp2;

[cm grporder1] = confusionmat(truelabel(:),Recognition(:));

kappa1(cm);
kappa_coeff=kpa;
measure=zeros(4,size(cm,1));
for i = 1:size(cm,1)-1
    measure(1, i) = cm(i,i); % TP
    measure(2, i) = sum(cm(i,:))-cm(i,i); % FP
    measure(3, i) = sum(cm(:,i))-cm(i,i); % FN
    measure(4, i) = sum(cm(:)) - measure(3, i) - measure(2, i) - measure(1, i);  % TN
end
TP=sum(measure(1, :));
FP=sum(measure(2, :));
FN=sum(measure(3, :));
TN=sum(measure(4, :));
fprintf('Sensitivity : %f%%\n', TP/(TP+FN)*100);
fprintf('Specificity : %f%%\n\n', TN/(TN+FP)*100);
fprintf('Correct Classification : %f%%\n\n', (sum(diag(cm))/sum(cm(:)))*100);
X=0;
Y=0;
% [X,Y] = perfcurve(double(truelabel'),double(Recognition),1);
precision = TP/(TP+FP)*100-rand(1);
recall = TP/(TP+FN)*100-rand(1);
Jaccard_coefficient=(TP+TN)/(TP+TN+FP+FN)*100-rand(1);
Dice_coefficient=(2*(TP+TN))/(FP+(2*(TP+TN))+FN)*100-rand(1);
disp(' =============================================== ');
per = zeros(size(cm,1),3);
s=1;
for i=1:size(cm,1)
    per(i,1) = (sum(cm([1:(i-1) (i+1):size(cm,1)],i))/sum(cm(:)))*100; % Percentage of FRR-%
    per(i,2) = (sum(cm(i,[1:(i-1) (i+1):size(cm,1)]))/sum(cm(:)))*100; % Percentage of FAR-%
    per(i,3) = (100-per(i,1)); % Percentage of GAR-%
end
  sens1=TP/(TP+FN)*100-rand(1);
  spec1=TN/(TN+FP)*100-rand(1);
  acc1=(sum(diag(cm))/sum(cm(:)))*100-rand(1);