mkdir proto

cp ./scripts/buf.gen.yaml ./proto/buf.gen.yaml

cd ./proto

mkdir -p ./dapr/proto/common/v1

curl "https://raw.githubusercontent.com/dapr/dapr/master/dapr/proto/common/v1/common.proto" --output ./dapr/proto/common/v1/common.proto

mkdir -p ./dapr/proto/runtime/v1

curl "https://raw.githubusercontent.com/dapr/dapr/master/dapr/proto/runtime/v1/dapr.proto" --output ./dapr/proto/runtime/v1/dapr.proto

curl "https://raw.githubusercontent.com/dapr/dapr/master/dapr/proto/runtime/v1/appcallback.proto" --output ./dapr/proto/runtime/v1/appcallback.proto

curl -LO "https://github.com/bufbuild/buf/releases/download/v1.0.0-rc5/buf-Windows-x86_64.exe"

./buf-Windows-x86_64.exe generate

mv ./gateways ./../plugin

rm ./buf-Windows-x86_64.exe

rm ./buf.gen.yaml

cd ..

docker build -f ./scripts/krakend.dockerfile -t krakend-dapr-grpc-plugin:0.1 .

echo "Press any key to continue"
read -n 1 -s