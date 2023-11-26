
sizesamples={zeros(2),zeros(2)};
load('RandomMatrix17x17.mat');

%%
for creavocb = 1:17
    istest=1;
    [theclass,TrainDataNorm,TrainDataoriginal,DocuTumores111,media_,stda,TrainDataTumor2,TrainDataNoTumor2]=LlamarDatos(creavocb,1,istest);
    %Train SVM 1 --->
    tic;
    SVMModel = fitcsvm(TrainDataNorm,theclass,'Standardize',false,'ClassNames',{'1','-1'});
    TiempoTrain1=toc;
    CompactSVMModel=fitSVMPosterior(SVMModel);
    save('ModelTrain11_Mzo_p1.mat');

    if creavocb==1
        load('ModelTrain11_Mzo_p1.mat');
    else
        tic;
        SVMModel = fitcsvm(TrainDataNorm,theclass,'Standardize',false,'ClassNames',{'1','-1'});
        TiempoTrain1=toc;
        CompactSVMModel=fitSVMPosterior(SVMModel);
    end


    prueba{1}=CompactSVMModel;
    mediayvarNorm{1}=[media_,stda];
    timepostrain(creavocb,1)=TiempoTrain1;
    sizesamples(creavocb,1)={size(theclass,1)};
    MUESTRAS{creavocb,1}=TrainDataoriginal;
    LABELS{creavocb,1}=theclass;

    %% Procedimiento para el test Num=2
    istest=2;
    [theclassTest,TestDataNorm,TrainData2,DocuTumores]=LlamarDatos(creavocb,2,istest,media_,stda);
    [labels,PostProbs]= predict(CompactSVMModel,TestDataNorm);
    for i = 1:length(labels)
        labelsout11(i) = str2num(cell2mat(labels(i)));
    end

    % Label H and L
    [ValidationData,ClassDocSVM,FeatMatxTH,VarTH,DTumor,outppData,NOTumorDataDicc,TumorDataDicc]=SepararInfoFuerteyDebil(theclassTest,PostProbs,labelsout11,TrainData2,DocuTumores);

    % Clusterize to obtain vocabulary
    NumClus=250; % Number K
    [idx,C,sumd,D] = kmeans(TrainData2,NumClus);

    [DiccWeakTumor1,DiccWeakNOTumor1]=AsignarVocabulario(idx,C,NumClus,DocuTumores,VarTH,DTumor,outppData);

    %-------->>>>>>> Previous data <<<<<<<<<<<-----------
    StrongDataTumor = [TumorDataDicc;TrainDataTumor2];
    StrongDataNOTumor= [NOTumorDataDicc;TrainDataNoTumor2];

    %Enriched database
    [CompactSVMModel2,dataTrain2,LabelTrain2,TimporTrainModel2,sizesampleweak,sizesamplestrong,media_1,stda_1]=EntrenarEnriched(DiccWeakTumor1,DiccWeakNOTumor1,StrongDataTumor,StrongDataNOTumor)
    prueba{2}=CompactSVMModel2;
    mediayvarNorm{2}=[media_1,stda_1];
    timepostrain(creavocb,2)=TimporTrainModel2;
    sizesamples(creavocb,2)={[sizesampleweak;sizesamplestrong]};
    MUESTRAS{creavocb,2}=dataTrain2;
    LABELS{creavocb,2}=LabelTrain2;

    %% Procedimiento para el test Num=3
    % valida el clasificador con el tercer paciente muestras seleccionadas
    istest=2;
    [LabelValidation,dataTest2,TrainData3,DocuTumores3]=LlamarDatos(creavocb,3,istest,media_1,stda_1);

    % Selecciona la prediccion para cada clase
    [labels2,PostProbs2] = predict(CompactSVMModel2,dataTest2);
    for i = 1:length(labels2)
        labelsout2(i) = str2num(cell2mat(labels2(i)));
    end

    %% comienza iteraciones
    for k=4:17

        [ValidationData,ClassDocSVM,FeatMatxTH,VarTH,DTumor,outppData,NOTumorDataDicc,TumorDataDicc,salir]=SepararInfoFuerteyDebil(LabelValidation,PostProbs2,labelsout2,TrainData3,DocuTumores3);

        %Exception
        if salir==1
            salir=0;
            clearvars -except MUESTRAS LABELS ModelosStrong creavocb matrizguardaresultadosCOMPLETO_STRONG_13_04_2023 Samplesize ModelosStrong Traintimestrong ValoresNormalizada Samplesize ModelosStrong Traintimestrong ValoresNormalizada StrongDataNOTumor ValoresNormalizada StrongDataTumor mediayvarNorm matrizguardaresultados_STRONG_14_03_2023 matrizguardaresultados_14_03_2023 ModelosStrong ModelosSelftrain ModelosSelftrain ModelosStrong matrizguardaresultados_14_03_2023 matrizguardaresultados_STRONG_14_03_2023 ResultsMethodSelftrain ResultsStrongLabeled CompactSVMModelstrong2 matrizguardaresultados_STRONG13_02_2023 timepostrainstrong matrizguardaresultados_13_02_2023 pruebastrong matrizguardaresultados_PrimerPte theclass TrainDataNorm k sizesamples LabelValidation PostProbs2 labelsout2 TrainData3 DocuTumores3 prueba timepostrain DiccWeakTumor1 DiccWeakNOTumor1 TumorDataDicc sizesamples NOTumorDataDicc idx C creavocb CompactSVMModel NumClus matrizguardaresultados
            continue
        end

        [DiccWeakTumor1,DiccWeakNOTumor1]=AsignarVocabulario(idx,C,NumClus,DocuTumores3,VarTH,DTumor,outppData);

        %-------->>>>>>> Previous data <<<<<<<<<<<-----------
        StrongDataTumor = [StrongDataTumor;TumorDataDicc];
        StrongDataNOTumor= [StrongDataNOTumor;NOTumorDataDicc];


        clearvars -except MUESTRAS LABELS ModelosStrong creavocb matrizguardaresultadosCOMPLETO_STRONG_13_04_2023 Samplesize ModelosStrong Traintimestrong ValoresNormalizada Samplesize ModelosStrong Traintimestrong ValoresNormalizada StrongDataNOTumor ValoresNormalizada StrongDataTumor mediayvarNorm matrizguardaresultados_STRONG_14_03_2023 matrizguardaresultados_14_03_2023 ModelosStrong ModelosSelftrain ModelosSelftrain ModelosStrong matrizguardaresultados_14_03_2023 matrizguardaresultados_STRONG_14_03_2023 ResultsMethodSelftrain ResultsStrongLabeled CompactSVMModelstrong2 matrizguardaresultados_STRONG13_02_2023 matrizguardaresultados_13_02_2023 timepostrainstrong pruebastrong matrizguardaresultados_PrimerPte theclass TrainDataNorm k sizesamples prueba timepostrain DiccWeakTumor1 DiccWeakNOTumor1 TumorDataDicc NOTumorDataDicc idx C creavocb CompactSVMModel NumClus sizesamples matrizguardaresultados

        %Entrena el clasificador enriquecido con las muestras seleccionada
        [CompactSVMModel2,dataTrain2,LabelTrain2,TimporTrainModel2,sizesampleweak,sizesamplestrong,media_1,stda_1]=EntrenarEnriched(DiccWeakTumor1,DiccWeakNOTumor1,StrongDataTumor,StrongDataNOTumor)

        prueba{k-1}=CompactSVMModel2;
        mediayvarNorm{k-1}=[media_1,stda_1];
        timepostrain(creavocb,k-1)=TimporTrainModel2;
        sizesamples(creavocb,k-1)={[sizesampleweak;sizesamplestrong]};
        MUESTRAS{creavocb,k-1}=dataTrain2;
        LABELS{creavocb,k-1}=LabelTrain2;
        % Test SVM
        istest=2;
        [LabelValidation,dataTest2,TrainData3,DocuTumores3]=LlamarDatos(creavocb,3,istest,media_1,stda_1);

        % Predicted data
        [labels2,PostProbs2] = predict(CompactSVMModel2,dataTest2);
        for i = 1:length(labels2)
            labelsout2(i) = str2num(cell2mat(labels2(i)));
        end
    end
    %%
    MatrixDataset{creavocb}=ResultsMethodSelftrain;
    Samplesize{creavocb}=sizesamples;
    Traintimes{creavocb}= timepostrain;

    save('Results_Selftrain-13APR-COMPLETO_del1al17.mat','MatrixDataset','Samplesize','Modelos','Traintimes','ValoresNormalizada');
    clearvars -except Modelos creavocb matrizguardaresultadosCOMPLETO_SELFTRAIN_13_04_2023 Samplesize Modelos Traintimes ValoresNormalizada
end

