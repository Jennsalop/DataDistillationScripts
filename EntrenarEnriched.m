function [CompactSVMModel2,TrainDataDicc2,LabelTrain2,TimporTrainModel2,sizesampleweak,sizesamplestrong,media_1,stda_1]=EntrenarEnriched(DiccWeakTumor1,DiccWeakNOTumor1,TumorDataDicc,NOTumorDataDicc)
% entrenando svm
%%%%--------<>>>>>>>>>>>>>>entrenamiento salida PLSA y datatrain inicial ---> MODELO 2
DiccWeakTumor=DiccWeakTumor1(3:end,:);
DiccWeakNoTumor=DiccWeakNOTumor1(3:end,:);

TrainDataTumor2=DiccWeakTumor;
%%TrainDataNoTumor2=datasample(DiccWeakNoTumor,);
TrainDataNoTumor2 = DiccWeakNoTumor;%%%remuestreo para balancear clases

%identificar el mínimo y remuestrear los debilmente etiquetados:
vctr=[length(TrainDataNoTumor2),length(TrainDataTumor2)];
[mnvctr,Nvcr]=min(vctr);
TrainDataNoTumor2= datasample(TrainDataNoTumor2,mnvctr);
TrainDataTumor2 = datasample(TrainDataTumor2,mnvctr);
%%%----->>>>>>><<<<<<<---------%%%%%
sizesampleweak=[size(TrainDataNoTumor2,1)];


%identificar el mínimo y remuestrear los fuertemente etiquetados:
vctr=[length(TumorDataDicc),length(NOTumorDataDicc)];
[mnvctr,Nvcr]=min(vctr);
TumorDataDicc = datasample(TumorDataDicc,mnvctr);
NOTumorDataDicc = datasample(NOTumorDataDicc,mnvctr);
%%%----->>>>>>><<<<<<<---------%%%%%
sizesamplestrong=[size(TumorDataDicc,1)];

TrainDataTumor2 = [TrainDataTumor2;TumorDataDicc];
TrainDataNoTumor2 = [TrainDataNoTumor2;NOTumorDataDicc];

TrainDataDicc2=[TrainDataTumor2;TrainDataNoTumor2];


[N,media_1,stda_1] = normalize(TrainDataDicc2); %%normalizacion Z-SCORE los datos

%TrainDataDiccNorm2 = normalize(TrainDataDicc2,'center',media_,'scale',stda); 

TrainDataDiccNorm2 = N;

theclassDicc2 = ones(length(TrainDataTumor2(:,1)),1);
theclassDicc2 (length(TrainDataTumor2(:,1))+1:length(TrainDataTumor2(:,1))+length(TrainDataNoTumor2(:,1))) = -1;

featureMatrixDicc2 =TrainDataDiccNorm2;
outputDicc2 =theclassDicc2 ;

dataTrain2 = [featureMatrixDicc2];
LabelTrain2 = [outputDicc2];

tic;
SVMModel2 = fitcsvm(dataTrain2,LabelTrain2,'Standardize',false,'ClassNames',{'1','-1'});
CompactSVMModel2 = fitSVMPosterior(SVMModel2);
TimporTrainModel2=toc;
finalizotrain2=1