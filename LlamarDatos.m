function [theclass,TrainDataNorm,TrainData2,DocuTumores,media_,stda,TrainDataTumor2,TrainDataNoTumor2]=LlamarDatos(creavocb,num,istest,media,stda)
    %Llamar carpetas
    
    FeatureFolderTumor='/Users/jenn/Documents/JournalRedPat/Backup_Doctorado/imgfinal/TestImages/ExperimentoSelfTrain/FeatureCancerTrain_p1/';
    FeatureFolderNoTumor='/Users/jenn/Documents/JournalRedPat/Backup_Doctorado/imgfinal/TestImages/ExperimentoSelfTrain/FeatureNoCancerTrain_p1/';
    folderT='/Users/jenn/Documents/JournalRedPat/Backup_Doctorado/imgfinal/TestImages/ExperimentoSelfTrain/FeatureCancerTrain_p1/';
    folderNoT='/Users/jenn/Documents/JournalRedPat/Backup_Doctorado/imgfinal/TestImages/ExperimentoSelfTrain/FeatureNoCancerTrain_p1/';
    ext='mat';
    imgListTumor=dir([FeatureFolderTumor '*.' ext ]);
    imgListNoTumor=dir([FeatureFolderNoTumor '*.' ext]);
    
   
    %listar pacientes
    Patients=["1022";"1023";"1027";"1114";"1026";"1028";"1032";"1109";"1113";"1116";"1107";"2078";"2081";"2084";"2643";"A9WA";"23-1030"];
    matrSamples=load('MatrizAleatoria17x17.mat');    
    VectorTumor=contains({imgListTumor.name},Patients(matrSamples.ExperimentsOrder(creavocb,num)));
    VectorNoTumor=contains({imgListNoTumor.name},Patients(matrSamples.ExperimentsOrder(creavocb,num)));

    
%%% "1022=3c";"1023=3c";"1027=3c";'1114=3c';"1026=3c";"1028=3c";"1032=4";"1109=3c";"1113=4";"1116=3c";"1107=4";"2078=3c";"2081=4";"2084=4";"2643=3c";"A9WA=2B";"23-1030=3c"

    [row,colT] = find(VectorTumor==1);
    [row,colNT] = find(VectorNoTumor==1);
    TrainDataNoTumor=[];
    TrainDataTumor=[];
    SizeT=[];
    SizeNT=[];

    for i=1:13%por clase 
    imgFileTumor=[folderT imgListTumor(colT(i)).name];   
    imgFileNoTumor=[folderNoT imgListNoTumor(colNT(i)).name];

    Tumor=load(imgFileTumor);
    TrainDataTumor=[TrainDataTumor;Tumor.features];
    SizeT=[SizeT;size(Tumor.features,1)];

    NoTumor=load(imgFileNoTumor);
    TrainDataNoTumor=[TrainDataNoTumor;NoTumor.features];
    SizeNT=[SizeNT;size(NoTumor.features,1)];
    end
    DocuTumores=[SizeT;SizeNT];
    TrainData=[TrainDataTumor;TrainDataNoTumor];
    TrainData2=[TrainData(:,1:31),TrainData(:,33:39),TrainData(:,41:55),TrainData(:,57:79),TrainData(:,81:102)]; %%se extraen columnas no necesarias  
    
    TrainDataTumor2=[TrainDataTumor(:,1:31),TrainDataTumor(:,33:39),TrainDataTumor(:,41:55),TrainDataTumor(:,57:79),TrainDataTumor(:,81:102)];
    TrainDataNoTumor2=[TrainDataNoTumor(:,1:31),TrainDataNoTumor(:,33:39),TrainDataNoTumor(:,41:55),TrainDataNoTumor(:,57:79),TrainDataNoTumor(:,81:102)];

    
    
    if istest==1
        [N,media_,stda] = normalize(TrainData2);
    elseif istest==2
        N = normalize(TrainData2,'center',media,'scale',stda);
    end
    
    %TrainDataNorm = normalize(TrainData2); %%normalizacion Z-SCORE
    TrainDataNorm = N;
    theclass = ones(length(TrainDataTumor(:,1)),1);
    theclass(length(TrainDataTumor(:,1))+1:length(TrainDataTumor(:,1))+length(TrainDataNoTumor(:,1))) = -1;

% %     %identificar el mínimo y remuestrear:
% %     vctr=[length(TrainDataTumor),length(TrainDataNoTumor)];
% %     [mnvctr,Nvcr]=min(vctr);
% %     TrainDataNoTumor = datasample(TrainDataNoTumor,mnvctr);
% %     TrainDataTumor = datasample(TrainDataTumor,mnvctr);
% %     TrainDataDicc2=[TrainDataTumor2;TrainDataNoTumor2];
% %     TrainDataDiccNorm2 = normalize(TrainDataDicc2);
% %     %%%----->>>>>>><<<<<<<---------%%%%%

    featureMatrix=TrainDataNorm;
    output=theclass;
end