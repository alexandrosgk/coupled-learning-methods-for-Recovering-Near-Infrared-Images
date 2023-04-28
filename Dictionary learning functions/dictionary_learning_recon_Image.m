function [rec_spectra] = dictionary_learning_recon_Image(clusters,test_rgb,rgb_centr,sp_level, imsize,~,~,w, T)


   Inum_of_patch=imsize(1)/w;
   Jnum_of_patch=imsize(2)/w;

   cnt=1;
   for i=1: Inum_of_patch
       for j=1:Jnum_of_patch
           low=test_rgb((i-1)*w+1:i*w,(j-1)*w+1:j*w,:);
           row=low(:);
           rgb_patch(:,cnt)=row(1:w*w*3);
           cnt=cnt+1;
       end
   end
   DH = clusters{1}.DH;
   
   patch_spectra = zeros(size(DH,1),length(rgb_patch));
   pos= knnsearch(rgb_centr, rgb_patch', 'K', 1, 'Distance', 'cosine');

    for c=1:length(clusters) 
       idx=find(pos==c); %for each cluster find all the pixels related to it

%------------ DL----------------------------------------------------------%    
       if ~isempty(idx)
            low = rgb_patch(:,idx);
            
            mhd = clusters{c}.mhd;
            mrgb = clusters{c}.mrgb;
            low =(mapstd('apply',low,mrgb));
            DL = clusters{c}.DL;
            DH = clusters{c}.DH;
            GT = clusters{c}.GT;
            g = omp(DL'*low, DL'*DL,sp_level);
            Eh5 =DH*g;
            Eh5 = (mapstd('reverse',Eh5,mhd));
            patch_spectra(:,idx)= Eh5;

       end
    end
    
cnt=1;
for i=1: Inum_of_patch
   for j=1:Jnum_of_patch
       rec_spectra((i-1)*w+1:i*w,(j-1)*w+1:j*w,:)=reshape(patch_spectra(:,cnt),w,w,1);
       cnt=cnt+1;
   end
end

end


    