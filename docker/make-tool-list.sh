for folder in ../*
do
  for wf in $folder/*.ga
  do
     echo $wf $folder
     workflow-to-tools --workflow $wf --output-file tools.yaml --panel_label $folder
  done
done
