function [clusters,rgb_centr] = find_Ld_centroids(clusters)
 
 % This function calculates the centroids of the data after the
 % dimensionality reduction

   for c=1:length(clusters)
      
      if size(clusters{c}.spectra,1)>1 
         clusters{c}.centroid_rgb=mean(clusters{c}.rgb); 
      else
         clusters{c}.centroid_rgb=mean(clusters{c}.rgb); 
      end
   end
   
    for c=1:length(clusters)
      rgb_centr(c,:)=clusters{c}.centroid_rgb; 
    end
   

end

