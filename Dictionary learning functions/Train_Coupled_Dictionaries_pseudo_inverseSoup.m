function [DH,DL] = Train_Coupled_Dictionaries_pseudo_inverseSoup(Hd,Ld,niter,atoms,sp_level)

% In this function we train 2 coupled dictionaries
% between high dimensional spectra data 
% and the corresponding low dimensional  data
%Inputs: 
%      -Hd: high dimensional data
%      -Ld: low dimensional data
%Outputs:
%      -DH: high dimensional dictionary
%      -DL: low dimensional dictionary


  params.Tdata =sp_level;         % Sparsity Target
  params.dictsize =atoms;         % Dictionary size
  params.iternum = niter;         % Number of Iterations
  params.memusage = 'high';
  params.data =Ld;
  
  [DL,~,e] = ksvd(params,'');
  
  
  SC = omp(DL'*Ld, DL'*DL, sp_level);


%   DH= Hd*pinv(full(SC));

  DH=Hd*SC'*(SC*SC'+0.00001*eye(atoms))^-1;

end

