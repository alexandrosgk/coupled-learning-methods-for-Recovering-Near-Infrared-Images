%% Set the data path
root_dir='E:\Data_Soup';

%% Read the Data
load('NEA_LISTA.mat')
number_of_patches = 205;
w = 10;
[spectra, rgb] = read_overlapped_patches_csvlist(number_of_patches,w, lista(1:64,:), root_dir);

rgb_dim = floor(size(rgb,1)*0.1)+2;
nir_dim = floor(size(spectra,1)*0.1)+2;

spectra=spectra';
rgb=rgb';


%% -------------- Cluster selected Hyperpixels to n clusters -------------%
num_of_clusters = 25;
[idx,~,~] = kmeans...
               (rgb, num_of_clusters, 'Distance','cosine','MaxIter',15000);  
[clusters] = data_to_its_cluster_Soup(idx, spectra, num_of_clusters, rgb);
[clusters, rgb_centr] = train_coupled_autoencoders_for_each_cluster(clusters, rgb_dim, nir_dim);

%% --------------  Testing ------------------------------------------------%
cnt = 1;
var_gaussian = 3.6;
for ii = 65:103
   path_of_images = lista(ii,1);
   [rec_spectra, test_hd, test_rgb] = coupled_autoencoders_testing(root_dir, path_of_images,var_gaussian,clusters,rgb_centr,w);
   m_psnr850(cnt)= myPSNR(test_hd, rec_spectra, 0);
   m_ssim850(cnt)= ssim(rec_spectra, test_hd);
   m_rmse850(cnt)=(rmse(double(test_hd),double(rec_spectra)))./255;
   cnt=cnt+1;
end
mean(m_psnr850)
mean(m_ssim850)
mean(m_rmse850)