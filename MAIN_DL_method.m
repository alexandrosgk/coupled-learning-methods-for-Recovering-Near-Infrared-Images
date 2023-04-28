

root_dir='E:\Data_Soup'; %Set the directory of the dataset
load('NEA_LISTA.mat')


%%Read the training data
number_of_patches = 650;
w = 6;
[spectra, rgb] = read_overlapped_patches_csvlist(number_of_patches, w, lista(1:62,:), root_dir);
spectra = spectra';
rgb = rgb';

%% -------------- Cluster selected Hyperpixels to n clusters --------------%
num_of_clusters = 40;
[idx,C1,~] = kmeans...
                 (rgb,num_of_clusters,'Distance','cosine','MaxIter', 15000);  
[clusters] = data_to_its_cluster_Soup(idx, spectra,num_of_clusters, rgb);
[clusters] = concatenate_hyper_clusters_Soup(num_of_clusters, clusters, 150);


%% ------------ Train the Coupled Dictionaries for each cluster ----------%
niter = 9;
atoms = 64;
sp_level = 9;

[clusters, rgb_centr, error] = dictionary_learning_for_each_cluster...
                                         (clusters,atoms,niter,sp_level);

%%
T = 1;
m_psnr850=[];
m_ssim850=[];  
m_rmse850=[];
cnt = 1;
var_gaussian = 3.6;
for ii = 65:103
   ii;
   path_of_images=lista(ii,1);

   [rec_spectra,test_hd] = dictionary_learning_testing(root_dir, ...
         path_of_images, var_gaussian, clusters, rgb_centr, sp_level, w, T);

   m_psnr850(cnt)= psnr(test_hd,rec_spectra);
   m_ssim850(cnt)= ssim(rec_spectra,test_hd);
   m_rmse850(cnt)=(rmse(double(test_hd),double(rec_spectra)))./255;

   cnt=cnt+1;
end

mean( m_psnr850)
mean(m_ssim850)
mean(m_rmse850)

        
       
 
 
 
 