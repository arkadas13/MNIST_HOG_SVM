clear all
clc
imagestrain = loadMNISTImages('train-images.idx3-ubyte');
imagestest = loadMNISTImages('t10k-images.idx3-ubyte');
trainlabels = loadMNISTLabels('train-labels.idx1-ubyte');
testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
threshold=0.75;
for j=1:60000 
    for i=1:28
        for k=1:28
            if(imagestrain((i-1)*28+k,j)>threshold)
                trainimages(k,i,j)=1;
            else
                trainimages(k,i,j)=0;
            end
        end
    end
end
for j=1:10000
    for i=1:28
        for k=1:28
            if(imagestest((i-1)*28+k,j)>threshold)
                testimages(k,i,j)=1;
            else
                testimages(k,i,j)=0;
            end
        end
    end
end
for j=1:60000
    [trainfeatures(j,:)] = extractHOGFeatures(trainimages(:,:,j),'CellSize',[3 3]);
end
for j=1:10000
    [testfeatures(j,:)] = extractHOGFeatures(testimages(:,:,j),'CellSize',[3 3]);
end
% a=trainimages(:,:,100);
% [features,visualization] = extractHOGFeatures(a,'CellSize',[3 3]);
% figure
% subplot(2,1,1);
% plot(visualization)
% subplot(2,1,2);
% imshow(a)