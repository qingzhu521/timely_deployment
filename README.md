# timely_deployment

help deploy your timely binary file  
- conf  
  -- hosts  (your hosts file)
  -- setting.json  (your parament)
- binary file
- run-timely.sh
- run.sh


usage:

./run-timely.sh -b [binary file name] -n [number of works] {your program arguments}
./run.sh -b [binary file name] -n [number of workers] {your program arguments will be read from conf/setting.json}
