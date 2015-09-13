# CDH 5 pseudo-distributed cluster Docker image

Do you develop Hadoop mapreduce applications on top of Cloudera distribution? This docker image can help you. It contains basic CDH 5 setup with YARN. You can use it for developmeent and verification of your code in local environment without messing up your system with Hadoop instalation.

Docker image was prepared according to [Installing CDH 5 with YARN on a Single Linux Node in Pseudo-distributed mode](http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/latest/CDH5-Quick-Start/cdh5qs_yarn_pseudo.html) with a few adjustments for Docker environment.

##### Installed services
* HDFS
* YARN
* JobHistoryServer
* Oozie
* Hue
* Spark (installation for execution on top of YARN)

### Execution

#### Build the docker with hadoop cluster in the pseudo distributed mode.
```
docker build -t hadoop-cdh-pseudo-docker .
```

#### Run the docker image built
```
docker run --name cdh -v /home/dummy:/dummy -d -p 8020:8020 -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 -p 10020:10020 -p 19888:19888 -p 11000:11000 -p 8888:8888 -p 18080:18080 -p 9999:9999 hadoop-cdh-pseudo-docker
```

`/home/dummy:/dummy` should be replaced with your home directory: `/home/paul:/dummy`. You could also change `dummy` inside the docker image and replace it with your usename if you prefer. In that case you will have to adapt this documentation to the fact that dummy is now a place holder.

#### Find out the docker container that has just been created and is running using the command
```
docker ps -a
```

#### Enter into the docker cluster that has been just built
```
docker exec -i -t b5cc1b8601ff bash -l
```

#### to run as user `dummmy` run the following script

   It is assumed that you have cloned this repo into `/dummy/dev/hadoop-cdh-pseudo-docker`
```
/dummy/dev/hadoop-cdh-pseudo-docker/conf/entry.sh
```


#### Run the command below in a bash terminal to find out the IP address of the docker image
```
head -1 /etc/hosts | awk '{print $1}'
```

The below URLs can be used to access different services following the format: <IP_ADDRESS>:<PORT_NUMBER>

### UI entry points
Those urls consider port forwarding from localhost.
* name node - http://<IP_ADDRESS>:50070
* resource manager - http://<IP_ADDRESS>:8088
* job history server - http://<IP_ADDRESS>:19888
* oozie console - http://<IP_ADDRESS>:11000
* hue - http://<IP_ADDRESS>:8888
* spark history server - http://<IP_ADDRESS>:18080

#### Hue login
You will be asked to create account during the first login. You can pick your prefered username and password. It will create home folder on HDFS and it can be used as hadoop user.

#### Custom port for your usecases
This image has exposed one port (9999). It is not used by any currently running service. It can be used by you for example when you need to attach debugger to running mapreduce job. So your mapreduce job can start debugging server on this port.

### Additional Docker tips

#### How to stop the contain and re-run it

```
sudo docker stop b5cc1b8601ff
sudo docker rm b5cc1b8601ff
```

Find out which image with `docker ps -a`. Onced removed your can re-run the docker image (see above `Run the docker image built`)

#### How to remove the Docker image so it can be re-built

```
sudo docker rmi hadoop-cdh-pseudo-docker
```
