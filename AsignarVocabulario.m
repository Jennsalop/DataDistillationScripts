function [DiccWeakTumor1,DiccWeakNOTumor1]=AsignarVocabulario(idx,C,NumClus,DocuTumores,VarTH,DTumor,outppData)

mtpr=zeros(1,98);
mtpr(:)= 0.000001;
for mm=1:length(C)
Vectororden(mm,:)=[pdist2(mtpr,C(mm,:),'cosine'),mm,C(mm,:)];
end
test1=sortrows(Vectororden);
test1=test1(:,3:end);
%%%%--->>> Obtiene vocabulario
MatrixOcurr=zeros(length(DocuTumores),NumClus);%% este es el vocabulario, en este caso
errImgs=[];
tic
for countDocunt=1:length(DocuTumores)
    matr=eval(strcat('VarTH.v',num2str(countDocunt)));
    try
        for cont=1:length(matr(:,1))
              dist(cont,1)=pdist2(matr(cont,:),test1(50,:),'cosine');
              dist(cont,2)=pdist2(matr(cont,:),test1(100,:),'cosine');
              dist(cont,3)=pdist2(matr(cont,:),test1(150,:),'cosine');
              dist(cont,4)=pdist2(matr(cont,:),test1(200,:),'cosine');
              dist(cont,5)=pdist2(matr(cont,:),test1(250,:),'cosine');
%             for cont2=1:NumClus%depende del Ncluster
%             dist(cont2)=pdist2(matr(cont,:),C(cont2,:),'cosine');
%             end
            [M,I]=min(dist(cont,:));
            if I==1
                dist1(cont,1)=pdist2(matr(cont,:),test1(15,:),'cosine');
                dist1(cont,2)=pdist2(matr(cont,:),test1(30,:),'cosine');
                dist1(cont,3)=pdist2(matr(cont,:),test1(45,:),'cosine'); 
                
                [M2,I2]=min(dist1(cont,:));
                if I2==1
                    r = randi([1 15],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==2
                    r = randi([16 30],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine');
                   [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==3
                    r = randi([31 45],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine');
                    [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                
            end
            if I==2
                dist1(cont,1)=pdist2(matr(cont,:),test1(60,:),'cosine');
                dist1(cont,2)=pdist2(matr(cont,:),test1(75,:),'cosine');
                dist1(cont,3)=pdist2(matr(cont,:),test1(90,:),'cosine');
                [M2,I2]=min(dist1(cont,:));
                if I2==1
                    r = randi([46 60],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==2
                    r = randi([61 75],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I3==3
                    r = randi([76 90],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
            end
            if I==3
                dist1(cont,1)=pdist2(matr(cont,:),test1(115,:),'cosine');
                dist1(cont,2)=pdist2(matr(cont,:),test1(130,:),'cosine');
                dist1(cont,3)=pdist2(matr(cont,:),test1(145,:),'cosine');
                [M2,I2]=min(dist1(cont,:));
                if I2==1
                    r = randi([91 115],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==2
                    r = randi([116 130],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I3==3
                    r = randi([131 145],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
            end
            if I==4
                dist1(cont,1)=pdist2(matr(cont,:),test1(160,:),'cosine');
                dist1(cont,2)=pdist2(matr(cont,:),test1(175,:),'cosine');
                dist1(cont,3)=pdist2(matr(cont,:),test1(190,:),'cosine');
                [M2,I2]=min(dist1(cont,:));
                if I2==1
                    r = randi([146 160],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==2
                    r = randi([161 175],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I3==3
                    r = randi([176 190],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
            end
            if I==5
                dist1(cont,1)=pdist2(matr(cont,:),test1(215,:),'cosine');
                dist1(cont,2)=pdist2(matr(cont,:),test1(230,:),'cosine');
                dist1(cont,3)=pdist2(matr(cont,:),test1(245,:),'cosine'); 
                [M2,I2]=min(dist1(cont,:));
                if I2==1
                    r = randi([191 215],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I2==2
                    r = randi([216 230],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end
                if I3==3
                    r = randi([231 245],1,3);
                    dist2(cont,1)=pdist2(matr(cont,:),test1(r(1),:),'cosine');
                    dist2(cont,2)=pdist2(matr(cont,:),test1(r(2),:),'cosine');
                    dist2(cont,3)=pdist2(matr(cont,:),test1(r(3),:),'cosine'); 
                     [M3,I3]=min(dist2(cont,:));
                    if I3==1
                        In=r(1);
                    end
                    if I3==2
                        In=r(2);
                    end
                    if I3==3
                        In=r(3);
                    end
                end 
            end
            
         %%-------------------------->>>
            MatrixOcurr(countDocunt,In)=MatrixOcurr(countDocunt,In)+1;
        end
    catch err
        fprintf('Documento vacío',matr,err.message);
        errImgs=[errImgs;countDocunt];
        continue;
    end
end
toc

%% Non-Negative Matrix Factorization 
%%------>>>NORMALIZAR LA MATRIZ
%MatrixOcurrNorm=normalize(MatrixOcurr','range');
MatrixOcurrNorm2=normc(MatrixOcurr');
%se escogen 20 tópicos en total
TotalTopics=25;
[W,H,Dp] = nnmf(MatrixOcurrNorm2,TotalTopics);
W0=W;
H0=H;
opt = statset('Maxiter',50,'Display','final');
[W,H,Dp] = nnmf(MatrixOcurrNorm2,TotalTopics,'W0',W0,'H0',H0,'Replicates',50,'Options',opt,'Algorithm','als');
for i=1:TotalTopics %%total GRUPOS O TOPICOS
    [MaxxTopicY(i),DocMaxProbY(i)]=max(H(i,:));
end

%% ---------------->>> PRUEBAS DE TOPICO POR TOPICO Y ENTRENAR <<<<<<<<<<<<<------------------
% %%% Acá escojo los documentos por cada tópico, se escogen los que mayor
% %%% aporten varianza
% tic
for ii=1:length(H(:,1)) 
    Higpr=sum(H(ii,:))*.95;
    [Bit,Intt] = sort(H(ii,:),'descend');
    sumatory=0;
    cuenta=1;
    while (sumatory <= Higpr)
        try
        sumatory=sumatory+Bit(cuenta);
        cuenta=cuenta+1;
        catch
            continue
        end
        if sumatory == Higpr
            break
        end
    end
    DocuSelection{ii}=Intt(1,1:(cuenta-1));   
end
length(DocuSelection)
% calculo SVD
for contafinal=1:length(DocuSelection) %cantidad de grupos o topicos
    matrixgroup=[];
    FeatMatrix1=cell2mat(DocuSelection(contafinal));
    for iii=1:length(FeatMatrix1)
        N = FeatMatrix1(iii);
        my_field = strcat('v2',num2str(N));
        VarTH2.(my_field) = DTumor{N};        
        MatGroup1=eval(strcat('VarTH2.v2',num2str(N)));
        MatGroup= normalize(MatGroup1,'range');
        
        %%%%-------------->>>extrae matriz completa de parches por grupo
        matrixgroup=[matrixgroup;MatGroup];
        %%%%-------------->>>
    end
    if isempty(matrixgroup)
        continue
    end

    s = svd(matrixgroup);
%     medias(contafinal,:) = mean(s);
%     desviaci(contafinal,:) = std(s);
%     varianza(contafinal,:) = var(s);
%     frobenius(contafinal,:) = norm(s,'fro');
    covarianza(contafinal,:) =cov(s);
    
    
%     Higpr=sum(s)*.90;
%     %[Bit,Intt] = sort(H(ii,:),'descend');
%     sumatory=0;
%     cuenta=1;
%     while (sumatory <= Higpr)        
%         sumatory=sumatory+s(cuenta);
%         cuenta=cuenta+1;        
%     end
%     conteo(contafinal)=cuenta;
%     
%     TotalSVD(contafinal)=mean(s);
%     %TotalEntpy{contafinal}=entropies;
%     %TotalEntpy=1
    
end
final=1;
[ji,jo]=sort(covarianza);
GroupSelection=[jo(1),jo(2),jo(3),jo(4)];



%%%%%%------------------->>>>>>>>>>>>>>>>><
    DiccWeakTumor1=zeros(1,98);
    DiccWeakNOTumor1=zeros(1,98);
    trgetGrp=[];
    
for hit=1:length(GroupSelection)
    FeatMatrix1=cell2mat(DocuSelection(GroupSelection(hit)));
    for iii=1:length(FeatMatrix1)
        N = FeatMatrix1(iii);
        my_field = strcat('v2',num2str(N));
        VarTH2.(my_field) = DTumor{N};
        MatGroup=eval(strcat('VarTH2.v2',num2str(N)));
                              
        my_field1 = strcat('v1',num2str(N));
        VarTH1.(my_field1) = outppData{N};
        trgetGrp=eval(strcat('VarTH1.v1',num2str(N)));
        
        for x=1:length(trgetGrp)
            if trgetGrp(x)==-1
                DiccWeakNOTumor1=[DiccWeakNOTumor1;MatGroup(x,:)];
            else if trgetGrp(x)==1
                    DiccWeakTumor1=[DiccWeakTumor1;MatGroup(x,:)];
                end
            end
        end
    end
end

    DiccWeakTumor1 = unique(DiccWeakTumor1,'rows');
    DiccWeakNOTumor1 = unique(DiccWeakNOTumor1,'rows');

