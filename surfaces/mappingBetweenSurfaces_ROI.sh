#!/bin/bash

if [ -z "$1" ]
 then
  echo 'start from an ROI (.1D.roi file) and an initialized set of surfaces (boundaries files,'
  echo 'check the file defineBoundaries.sh and generateSurfaces.sh for that), grows a normal'
  echo 'from the selected surface to the CSF boundary and to the GM/WM boundary, for each node in the ROI, and'
  echo 'stores the mapping in a separate folder: Inputs:'
  echo 'ROI=$1'
  echo 'STARTINGSURFACE=$2' 
  exit 1
fi

ROI=$1
STARTINGSURFACE=$2

Rscript $AFNI_TOOLBOXDIRSURFACES/mappingBetweenSurfaces_ROI.R $ROI $STARTINGSURFACE
