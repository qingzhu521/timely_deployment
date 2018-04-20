# timely_deployment

Help your timely binary file  deployment

Menu
- conf  
  -- hosts  (your hosts file)  
  -- setting.json  (your program's parameters)
- binary file
- run-timely.sh
- run.sh 
- deployrust.sh
- distr_bin.sh (help distribute your binary file though it will process automaticly in run)
- *.py(python helper)


>Usage: 
>+ ./run-timely.sh -b [binary file name] -n [number of hosts] -w [number of workers per host] {your program arguments}  
>+ ./run.sh -b [binary file name] -n [number of hosts] 


>Pay attention：  
> + if you want to set the number of workers per hosts, you have to keep configure "workers" 
> + before you do anything, chmod a+x for every shell script