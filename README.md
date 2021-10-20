# KrakenD - Dapr gRPC Plugin
Plugin for communication between KrakenD and Dapr using gRPC.

#### Release Docker Image:
```
. .\scripts\release.sh
```

#### Docker Image:
```
docker build -f ./scripts/krakend.dockerfile -t krakend-dapr-grpc-plugin:0.1 .
```

#### Run Docker Image:
```
docker network create krakend
docker run -d --name krakend --network krakend -p 8001:8001 krakend-dapr-grpc-plugin:0.1
```

#### Clean Up Environment:
```
docker rm -f krakend
docker rmi -f krakend-dapr-grpc-plugin:0.1
docker network rm krakend
```

#### Go Modules for Dockerfile:
You can get KrakenD dependencies to make the plugin work correctly by clicking [here](https://plugin-tools.krakend.io/validate).

With the list in hands, use file ./scripts/go-modules-for-dockerfile.xlsx to generate the content that you can put in dockerfile ./scripts/krakend.dockerfile, and then it will compile the plugin correctly.