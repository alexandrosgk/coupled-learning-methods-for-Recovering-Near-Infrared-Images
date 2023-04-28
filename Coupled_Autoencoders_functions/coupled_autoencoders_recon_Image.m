function [rec_spectra] = coupled_autoencoders_recon_Image(clusters,test_rgb,rgb_centr, imsize,w)


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


patch_spectra=zeros(w*w,length(rgb_patch));
pos= knnsearch(rgb_centr,rgb_patch','K',1,'Distance','cosine');

for c=1:length(clusters) 
   idx=find(pos==c); %for each cluster find all the pixels related to i


%%---------------Net-------------------------------------------------------%              
   if ~isempty(idx)
        low=rgb_patch(:,idx);
        %low=clusters{c}.init(low);
        
        
        stackednet = clusters{c}.stackednet;
        autoenc_spectra = clusters{c}.autoenc_spectra;
        r_latent_spectra = stackednet(low);
        Eh5 = decode(autoenc_spectra, r_latent_spectra);
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


    