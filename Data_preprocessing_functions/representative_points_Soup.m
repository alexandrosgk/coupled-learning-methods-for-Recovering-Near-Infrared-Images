function [hd,ld_rgb]=representative_points_Soup(cluster_neigh,random_points,num_of_clusters,clusters)
% Find the n-most representative points  from each cluster

 position=zeros(1,num_of_clusters);
if random_points==1 % choose random points from each cluster    
    for i=1:num_of_clusters
        s=size(clusters{1,i}.spectra,1);
        if s>=cluster_neigh  
           
           
%             spectra=[clusters{1,i}.spectra]; 
            
%             centr=clusters{i}.centroid;
%             id=knnsearch(spectra,centr,'K',10,'Distance','seuclidean');
%            indx=randi([1,s]);
%             p=knnsearch(spectra,spectra(1,:),'K',cluster_neigh,'Distance','seuclidean');
             p=randperm(size(clusters{i}.spectra,1),cluster_neigh);
%              p=randi([1 size(clusters{i}.spectra,1)],1,cluster_neigh);

%            start=5;
%            start=1;
%           [p]=short_path(spectra,clster_neigh,start);
           spectra_c{1,i}.knn=clusters{1,i}.spectra(p,:);
           rgb_c{1,i}.knn1=clusters{1,i}.rgb(p,:);
        end  
        position(i)=i;       
    end
    
    hd=spectra_c{1}.knn;
    ld_rgb=rgb_c{1}.knn1;
    
    for i=2:length(position)
        
        hd=[hd;spectra_c{i}.knn];
        ld_rgb=[ld_rgb;rgb_c{i}.knn1];
       
    end
    
end
    
end

function [knn_idx]=short_path(spectra,cluster_neigh,start)
    knn_idx=zeros(1,cluster_neigh);
    knn_idx(1)=start;
    for i=2:cluster_neigh
      pp=knnsearch(spectra,spectra(knn_idx(i-1),:),'K',2,'Distance','seuclidean');
      if isempty(intersect(knn_idx,pp(2)))

         knn_idx(i)=pp(2);  

      else
          cnt=2;
          while ~isempty(intersect(knn_idx,pp(cnt)))

              cnt=cnt+1;
              pp=knnsearch(spectra,spectra(knn_idx(i-1),:),'K',cnt,'Distance','seuclidean');
          end
          knn_idx(i)=pp(cnt);



      end

 
     end

end




