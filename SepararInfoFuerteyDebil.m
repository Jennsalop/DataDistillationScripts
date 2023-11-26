function [ValidationData,ClassDocSVM,FeatMatxTH,VarTH,DTumor,outppData,NOTumorDataDicc,TumorDataDicc,salir]=SepararInfoFuerteyDebil(theclassTest,PostProbs,labelsout11,TrainData2Test,DocuTumores)
%Separa parches por cada documento dependiendo de los escogidos para el test
contador=DocuTumores(1);
cuenta=1;
cont=1;
suma=0;
salir=0;
for cc=1:length(DocuTumores)
    for cx=cuenta:contador
        TestData_1(cont,:) = TrainData2Test(cx,:);%Datos NO normalizados
        cont=cont+1;
    end
    suma=suma+(cont-1);
    DocuTest(cc)=cont-1;
    cont=1;
    ValidData{cc} = TestData_1;
    clearvars  TestData_1 

    if cc~=length(DocuTumores)%%NUMERO DE DOCUMENTOS
    cuenta=cuenta+DocuTumores(cc);
    contador=cuenta+DocuTumores(cc+1)-1;  
    end
end

% Separa las probabilidades 
conteo=1;
for cc=1:length(DocuTumores)
    PostProb_Data{cc} = PostProbs(conteo:conteo+(DocuTest(cc)-1));
    conteo=conteo+DocuTest(cc);
end

ValidationData=[];
for k=1:length(ValidData)
    my_field = strcat('v',num2str(k));
    VarTH.(my_field) = ValidData{k};
    ValidationData=[ValidationData;eval(strcat('VarTH.v',num2str(k)))];
end

%% SEPARAR INFORMACION FUERTE Y DEBILMENTE ETIQUETADA
cuenta=1;
cont=1;
contador=DocuTest(1);
for cc=1:length(DocuTest)
    for cx=cuenta:contador
        if PostProbs(cx,1)>=0.05 && PostProbs(cx,1)<=0.95
        THMidDataTumor(cont,:)= TrainData2Test(cx,:); %% guardo informacion de caracteristicas sin normalizar
        THMProbability(cont,:)= PostProbs(cx,1); %% probabilidad de pertenencia a una clase
        OutData_1(cont) = labelsout11(cx); %% label de cada muestra según la clasificacion
        cont=cont+1;
        end
    end
    if cc~=length(DocuTumores)
        cuenta=cuenta+DocuTest(cc);
        contador=cuenta+DocuTest(cc+1)-1;
    end   
    try
        DTumor{cc}=THMidDataTumor;
        TumorProb{cc}=THMProbability;
        outppData{cc} = OutData_1;
        clearvars  THMidDataTumor THMProbability OutData_1
        THMidDataTumor=[];
        THMProbability=[];
        OutData_1=[];

    catch err
        fprintf('Clasificación perfecta ',err.message);
        %errImgs=[errImgs;countDocunt];
        ClassDocSVM=0;        
        DTumor=0;
        outppData=0;     
        FeatMatxTH=[]
        salir=1;
        break
    end
    cont=1;
end

%%% Crea diccionarios fuertemente etiquetados
cont2=1;
cont3=1;
for con=1:length(TrainData2Test(:,2))
    if PostProbs(con,1)>0.95
        TumorDataDicc(cont2,:)= TrainData2Test(con,:);
        OutDatatumordicc(cont2) = labelsout11(con);
        cont2=cont2+1;
    end
    if PostProbs(con,1)<0.05
        NOTumorDataDicc(cont3,:)= TrainData2Test(con,:);
        OutDataNotumordicc(cont3) = labelsout11(con);
        cont3=cont3+1;
    end
end

if salir==1
return
end

%%%pasa a matriz la celda de datos debilmente etiquetados
FeatMatxTH=[];
trgetData=[];
for k=1:length(DTumor)
    my_field = strcat('v',num2str(k));
    VarTH.(my_field) = DTumor{k};
    FeatMatxTH=[FeatMatxTH;eval(strcat('VarTH.v',num2str(k)))];
    
    my_field1 = strcat('v1',num2str(k));
    VarTH1.(my_field1) = outppData{k};
    trgetData=[trgetData,eval(strcat('VarTH1.v1',num2str(k)))];

    % calcular clase del documento segun clasificacion
    vectorclass = eval(strcat('VarTH1.v1',num2str(k)));
    cc1=sum(vectorclass == -1);
    cc2=sum(vectorclass == 1);
    [vc,it] = max([cc1,cc2]);
    if it==1
        ClassDocSVM(k)=-1;
    else if it==2
            ClassDocSVM(k)=1;
        end
    end    
end
salir=0;

end