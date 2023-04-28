function [new_clusters] = concatenate_hyper_clusters_Soup(num_of_clusters,clusters,upto)

% This function concatenates clusters with small number of signals


    cnt=1;
    for i=1:num_of_clusters

       n=size( clusters{i}.spectra,1);
       if n>upto
           new_clusters{cnt}=clusters{i};
           new_clusters{cnt}.centroid=mean(clusters{i}.spectra);
           cnt=cnt+1;
       end

    end

end
