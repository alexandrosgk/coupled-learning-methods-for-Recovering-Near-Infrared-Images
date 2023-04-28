function [test_rgb,test_hd,imsize,myFolder] = read_data_from_csvlist(root_dir,path_of_images)

       myFolder=fullfile(root_dir,path_of_images); 
       filePatternroot = fullfile(myFolder);
       filePatternroot = replace(filePatternroot, '\', '/');
       pngFiles = dir(filePatternroot);
       for j=1:size(pngFiles,1)
          baseFileName = pngFiles(j).name;
          fullFileName = fullfile(filePatternroot, baseFileName);

          if strcmp(baseFileName,'COLOR_Image.png')
              test_rgb=imread(fullFileName);
%               [test_rgb] = white_balance_strech_contrast(test_rgb); %White Balance
%               [test_rgb] = White_Balancing_Gray(test_rgb);
%                 test_rgb = PerformAWB(test_rgb, 97);
              imsize=size(test_rgb);
              [N,M,~]=size(test_rgb);

          elseif strcmp(baseFileName,'Image_460.png')
              test_hd(:,:,1)=imread(fullFileName);
          elseif strcmp(baseFileName,'Image_540.png')
              test_hd(:,:,2)=imread(fullFileName);
          elseif strcmp(baseFileName,'Image_630.png')
              test_hd(:,:,3)=imread(fullFileName); 
          elseif strcmp(baseFileName,'Image_850.png')
              pngData = imread(fullFileName);
              pngData=imresize(pngData(:,:,1),[N,M]);
              
              i860(:,:,1)=pngData;
              i860(:,:,2)=pngData;
              i860(:,:,3)=pngData;
%               [test] = White_Balancing_Gray(i860);
%               test_hd(:,:,4)=test(:,:,1); 
%               pngData = PerformAWB(i860, 91);
              test_hd(:,:,4)=pngData(:,:,1); 
          elseif strcmp(baseFileName,'Image_980.png')
              pngData = imread(fullFileName);
              pngData=imresize(pngData(:,:,1),[N,M]);
              test_hd(:,:,5)=pngData; 
          end
         
       end 

end
