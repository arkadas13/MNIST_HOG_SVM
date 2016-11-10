clc
clear all 
load('trainfeatures_thresholded.mat');
load('trainlabels.mat');
load('testfeatures_thresholded.mat');
load('testlabels.mat');
load('variance.mat')
threshold=0.0015;nosft=1000;
% for i=1:size(trainfeatures,2)
%     sum1=0;
%     for j=1:size(trainfeatures,1)
%         sum1=sum1+trainfeatures(j,i);
%     end
%     mean(i)=sum1/size(trainfeatures,1);
% end
count=0;
for i=1:size(trainfeatures,2)
%     sum1=0;
%     for j=1:size(trainfeatures,1)
%         sum1=sum1+(trainfeatures(j,i)-mean(i))^2;
%     end
%     var(i)=sum1/size(trainfeatures,1);
    if(var(i)>threshold)
        count=count+1;
        drtrainfeatures(:,count)=trainfeatures(:,i);
        drtestfeatures(:,count)=testfeatures(:,i);
    end
end
% %  load('matlab.mat')
% % load crab_dataset;
% % invector = Probs';
% % A = zeros(1 ,4558);
% % for i = 1:4558
% %      for j = 1:10
% %          if (target2file(j,i) == 1)
% %              A(i) = j;
% %              break;
% %          end
% %      end
% % end
% %  lambda = 0.0100;
% %  for j = 1:4558;
% %  k=0; 
% %  for i = 1:8
% %      if (Probabilities(j,i) <lambda)
% %         Probabilities(j,i) = lambda;
% %         k = k+1;
% %      else
% %          mat = i;
% %      end
% %  end
% %  Probabilities(j,mat) = (Probabilities(j,mat) - k*lambda);
% %  end
% % invector = invector';
% % A = A';
TrainingSet = drtrainfeatures(1:nosft,:);
GroupTrain = trainlabels(1:nosft,:); 
TestSet = drtestfeatures;
results = multisvm(TrainingSet, GroupTrain, TestSet); 
% % disp('multi class problem'); 
% % disp(results);
% % kk = 0;
% % aa  = results - A(1:4558);
% % for ll = 1:size(aa,1)
% % if (aa(ll) == 0)
% % kk = kk+1;
% % end
% % end
% % kk/size(aa,1);
Vector = zeros(size(testlabels,1),10);sum=0;Vector2 = zeros(size(testlabels,1),10);
for i = 1:size(testlabels,1)
     for j = 1:10
         if (j == results(i,1))
             Vector(i,j) = 1;
             break;
         end
     end
     Vector2(i,testlabels(i)+1)=1;
     if(results(i)-1==testlabels(i))
         sum=sum+1;
     end
end
prob=sum/size(testlabels,1)
%plotconfusion(Vector2,Vector)