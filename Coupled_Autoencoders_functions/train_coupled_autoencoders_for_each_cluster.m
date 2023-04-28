function [clusters,rgb_centr] = train_coupled_autoencoders_for_each_cluster(clusters, rgb_dim, nir_dim)

     [clusters,rgb_centr] = find_Ld_centroids(clusters);
     for c=1:length(clusters)

        
           nir = clusters{c}.spectra';
           rgb = clusters{c}.rgb';
          
           autoenc_spectra = trainAutoencoder(nir, nir_dim, 'MaxEpochs',600);
           autoenc_rgb = trainAutoencoder(rgb, rgb_dim,'MaxEpochs', 600);
           %,'ScaleData' ,false
           
           % Find the latent representations 
           latent_rgb = encode(autoenc_rgb, rgb);
           latent_spectra = encode(autoenc_spectra, nir);

           %Train the mapping neural net between the 2 latent signals
           num_of_Layers = rgb_dim;
           [net] = neural_network_fitting(latent_rgb, latent_spectra, num_of_Layers);
           stackednet = stack(autoenc_rgb, net);
           stackednet.trainFcn = 'trainscg';        
           stackednet = train(stackednet, rgb, latent_spectra);

          % Store the dictionaries
            clusters{c}.autoenc_spectra = autoenc_spectra;
            clusters{c}.stackednet = stackednet ;
            %clusters{c}.init = net_init ;
            disp(['Communication round:  ', num2str(c), '/', num2str(length(clusters))])

     end
     

       
     
     
end

