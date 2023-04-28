function [clusters] = data_to_its_cluster_Soup(idx, spectra, num_of_clusters,rgb)
% This function concatenates each signal to its corresponding cluster


    spectra_c=cell(1,num_of_clusters);
    clusters=cell(1,num_of_clusters);
  
    for c=1:num_of_clusters 
        corresponding_idx=find(idx==c);
        spectra_c{c}.points=spectra(corresponding_idx,:);
        spectra_c{c}.cor_indices=corresponding_idx; 
                
        clusters{c}.spectra=spectra(corresponding_idx,:);
        clusters{c}.rgb=rgb(corresponding_idx,:);

    end
end
