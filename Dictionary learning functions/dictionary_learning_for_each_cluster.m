function [clusters, rgb_centr, error] = dictionary_learning_for_each_cluster(clusters, atoms, niter, sp_level)

     [clusters ,rgb_centr] = find_Ld_centroids(clusters);
     for c = 1:length(clusters)
         
           train_Hd=clusters{c}.spectra';
           train_Ld=clusters{c}.rgb';

           if size(train_Hd,2)<500
               numofatoms = atoms;  
           else
               numofatoms = atoms;
           end
           [trgb, mrgb] = mapstd(train_Ld);
           [thd, mhd] = mapstd(train_Hd); 

           [DH, DL] = Train_Coupled_Dictionaries_pseudo_inverseSoup(thd, trgb, niter, numofatoms, sp_level);

          % Store the dictionaries
            clusters{c}.DH = DH;
            clusters{c}.DL = DL;
            clusters{c}.mhd = mhd;
            clusters{c}.mrgb = mrgb;
            clusters{c}.GT=DL'*DL;
%             disp(['Communication round:  ', num2str(c), '/', num2str(length(clusters))])
     end
 
     for ll=1:length(clusters)
         
            
            xcentroid = rgb_centr(ll,:)';
            ld = clusters{ll}.rgb';
            [~,pos] = max((normc(xcentroid)'*normc(ld)));
            xcentroid = ld(:,pos);
            
            mrgb=clusters{ll}.mrgb;
            low =(mapstd('apply',xcentroid,mrgb));
            DL = clusters{ll}.DL;
            a = omp(DL'*low, DL'*DL,sp_level);
            xhat = DL*a;
            error(ll) = rmse(xhat,low);

     end
       
     
     
end









%--------- Net ------------------------------------------------------------
%     train_Hd=clusters{c}.spectra';
%     train_Ld=clusters{c}.rgb';     
%     num_of_Layers=19;
%     [net]=neural_network_fitting(train_Ld,train_Hd,num_of_Layers);
%     clusters{c}.net=net;


%     trgb=(mapstd('apply',train_Ld,mrgb));
%     thd=(mapstd('apply',train_Hd,mhd));


%    [trgb]=(train_Ld);
%    [thd]=(train_Hd); 
