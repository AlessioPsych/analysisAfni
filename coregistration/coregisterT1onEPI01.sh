#!/bin/bash

MPRAGE=$1 
EPI=$2 
COSTFUN=$3

3dcopy $MPRAGE tempFile_MPRAGE+orig
3dcopy $EPI tempFile_EPI+orig

@Align_Centers -base tempFile_EPI+orig -dset tempFile_MPRAGE+orig

cat_matvec -ONELINE tempFile_MPRAGE_shft.1D > center_shift.1D

3dAllineate -base tempFile_EPI+orig -source tempFile_MPRAGE_shft+orig -cost nmi -interp linear -final wsinc5 -twopass -warp sho -nocmass -prefix tempFile_MPRAGE_sho+orig -1Dmatrix_save tempFile_sho.1D -VERB

cat_matvec -ONELINE tempFile_sho.1D > sho.1D


3dAllineate -source tempFile_MASK_shft+orig -1Dmatrix_apply sho.1D -master tempFile_EPI+orig -prefix tempFile_MASK_shft_resample+orig -final NN

3dAllineate -base tempFile_EPI+orig -source tempFile_MPRAGE_sho+orig -cost $COSTFUN -interp linear -final wsinc5 -twopass -warp shr -nocmass -prefix tempFile_MPRAGE_sho_shr+orig -1Dmatrix_save tempFile_sho_shr.1D -VERB

cat_matvec -ONELINE tempFile_sho_shr.1D > sho_shr.1D

3dAllineate -base tempFile_EPI+orig -source tempFile_MPRAGE_sho_shr+orig -cost $COSTFUN -interp linear -final wsinc5 -twopass -warp srs -nocmass -prefix tempFile_MPRAGE_sho_shr_srs+orig -1Dmatrix_save tempFile_sho_shr_srs.1D -VERB

cat_matvec -ONELINE tempFile_sho_shr_srs.1D > sho_shr_srs.1D

3dAllineate -base tempFile_EPI+orig -source tempFile_MPRAGE_sho_shr_srs+orig -cost lpc -interp linear -final wsinc5 -twopass -warp aff -nocmass -prefix tempFile_MPRAGE_sho_shr_srs_aff+orig -1Dmatrix_save tempFile_sho_shr_srs_aff.1D -VERB

cat_matvec -ONELINE tempFile_sho_shr_srs_aff.1D > sho_shr_srs_aff.1D

3dcopy tempFile_MPRAGE_sho_shr_srs_aff+orig anatomy_al.nii.gz

#3dAllineate -base tempFile_EPI+orig -source tempFile_MPRAGE_sho_shr_srs_aff+orig -cost mi -interp linear -final wsinc5 -onepass -warp aff -nocmass -prefix tempFile_MPRAGE_sho_shr_srs_aff01+orig -1Dmatrix_save tempFile_sho_shr_srs_aff01.1D -nmatch 10000 -conv 0.001 -VERB

#cat_matvec -ONELINE tempFile_sho_shr_srs_aff01.1D > sho_shr_srs_aff01.1D




#3dcopy tempFile_MPRAGE_sho_shr_srs_aff+orig anatomy_al.nii.gz

#@Align_Centers -base tempFile_EPI+orig -dset tempFile_MPRAGE+orig

#@Align_Centers -base tempFile_EPI+orig -dset tempFile_MPRAGE+orig -1Dmat_only_nodset

#cat_matvec -4x4 tempFile_MPRAGE_shft.1D > shftMatrix.1D



#align_epi_anat.py -anat tempFile_MPRAGE_shft+orig -epi tempFile_EPI+orig -epi_base 0 -anat_has_skull no -epi_strip None -big_move -cost lpc -save_script script_al

#cat_matvec -4x4 tempFile_MPRAGE_shft.1D > shftMatrix.1D

#cat_matvec -4x4 tempFile_MPRAGE_shft_al_mat.aff12.1D > alMatrix.1D

#3dresample -master tempFile_EPI+orig -inset tempFile_MPRAGE_shft_al+orig -prefix tempFile_MPRAGE_shft_al_resample+orig -rmode Linear

#3dcopy tempFile_MPRAGE_shft_al_resample+orig anatomy_al.nii.gz

#3dcopy tempFile_MPRAGE_shft_al+orig anatomy_al.nii.gz

#rm tempFile_*.BRIK
#rm tempFile_*.HEAD
#rm tempFile_*.1D
