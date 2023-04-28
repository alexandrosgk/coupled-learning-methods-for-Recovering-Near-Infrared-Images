


function [spectra,rgb] = read_overlapped_patches_csvlist(number_of_patches, w, lista, root_dir)

 % In this function we randolmy sample patches from the hyperspectral and
 % rgb images

    cnt=1;
    for ii=1:size(lista,1)
%        if lista(ii,12)=='g'
           % Read the spectraCube form this path
           path_of_images=lista(ii,1);
           [rgb,rad,~] = read_data_from_csvlist(root_dir,path_of_images);
           rgb=uint8(rgb);
           rad=uint8(rad);
           
%            lab= rgb2lab(rgb);
           rad=rad(:,:,4);
           imsizergb=size(rgb);
           
           % Extract non_overlapping patches 
            rI=randperm(imsizergb(1)-w+1,number_of_patches);
            rJ=randperm(imsizergb(2)-w+1,number_of_patches);

           cc=1;
          for l=1:number_of_patches

                   low=rgb(rI(l)+(0:w-1),rJ(l)+(0:w-1),:); 
                   nir=rad(rI(l)+(0:w-1),rJ(l)+(0:w-1),:);
%                    low_lab=lab(rI(l)+(0:w-1),rJ(l)+(0:w-1),:); 
                   
                   mfrad(:,cc)=nir(:);
                   mfrgb(:,cc)=low(:);
%                    mflab(:,cc)=low_lab(:);
                   
                   cc=cc+1;
           end

           spectra{cnt}=mfrad;
           rgb1{cnt}=mfrgb;
%            lab1{cnt}=mflab;
           cnt=cnt+1;
    end
        spectra=double(cell2mat(spectra));
        rgb=double(cell2mat(rgb1));
%         lab=double(cell2mat(lab1));
        
        
        
        
end


















