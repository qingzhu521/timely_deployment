# timely_deployment

help deploy your timely binary file  
- conf  
  -- hosts  (your hosts file)  
  -- setting.json  (your program's parameters)
- binary file
- run-timely.sh
- run.sh


usage:

./run-timely.sh -b [binary file name] -n [number of works] -w[workers per host] {your program arguments}  
./run.sh -b [binary file name] -n [number of workers] {your program arguments will be read from conf/setting.json}  


>Pay attention：  
> + if you want to set the number of workers per hosts, you have to keep configure "workers" 