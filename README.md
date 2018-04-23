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
- *.py(python script helper)


>Usage: 
>+ ./run-timely.sh -b [binary file name] -n [number of hosts] -w [number of workers per host] -d {if you add it your program will distribute to other workers} {your program arguments}  
>+ ./run.sh -b [binary file name] -n [number of hosts]  -d {if you add it your program will distribute to other workers}
>+ ./kill-timely.sh [binary file name] [number of hosts] // if the program not terminate smoothly, you'd better do this job.

>Pay attention：  
> + If you want to set the number of workers per hosts, you have to keep configure "workers" 
> + Before you do anything, chmod a+x for every shell script
> + If you put all this things on SMB or something, you properly encounter with network problem. So we advice put all directory in 
non shared file system