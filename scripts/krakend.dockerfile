FROM golang:1.16.4-alpine as builder

RUN apk add build-base bash git openssh

RUN mkdir plugin

COPY ./plugin /plugin

WORKDIR /plugin

RUN sed -i 's/package plugin/package main/g' plugin.go

RUN sed -i 's/package plugin/package main/g' gateway.go

RUN go mod init github.com/r-c-correa/krakend-dapr-grpc-plugin/plugin

RUN go mod edit -replace cloud.google.com/go/firestore=cloud.google.com/go/firestore@v1.4.0 ; \
    go mod edit -replace cloud.google.com/go/pubsub=cloud.google.com/go/pubsub@v1.9.0 ; \
    go mod edit -replace cloud.google.com/go/storage=cloud.google.com/go/storage@v1.9.0 ; \
    go mod edit -replace cloud.google.com/go=cloud.google.com/go@v0.72.0 ; \
    go mod edit -replace contrib.go.opencensus.io/exporter/prometheus=contrib.go.opencensus.io/exporter/prometheus@v0.0.0-20190424224027-f02a6e68f94d ; \
    go mod edit -replace contrib.go.opencensus.io/exporter/zipkin=contrib.go.opencensus.io/exporter/zipkin@v0.0.0-20190424224031-c96617f51dc6 ; \
    go mod edit -replace github.com/aliyun/alibaba-cloud-sdk-go=github.com/aliyun/alibaba-cloud-sdk-go@v0.0.0-20190620160927-9418d7b0cd0f ; \
    go mod edit -replace github.com/aliyun/aliyun-oss-go-sdk=github.com/aliyun/aliyun-oss-go-sdk@v0.0.0-20190307165228-86c17b95fcd5 ; \
    go mod edit -replace github.com/antihax/optional=github.com/antihax/optional@v0.0.0-20180407024304-ca021399b1a6 ; \
    go mod edit -replace github.com/apache/thrift=github.com/apache/thrift@v0.13.0 ; \
    go mod edit -replace github.com/armon/go-metrics=github.com/armon/go-metrics@v0.3.4 ; \
    go mod edit -replace github.com/armon/go-radix=github.com/armon/go-radix@v1.0.0 ; \
    go mod edit -replace github.com/asaskevich/govalidator=github.com/asaskevich/govalidator@v0.0.0-20190424111038-f61b66f89f4a ; \
    go mod edit -replace github.com/aws/aws-sdk-go=github.com/aws/aws-sdk-go@v1.36.1 ; \
    go mod edit -replace github.com/Azure/azure-pipeline-go=github.com/Azure/azure-pipeline-go@v0.2.3 ; \
    go mod edit -replace github.com/Azure/azure-sdk-for-go=github.com/Azure/azure-sdk-for-go@v49.0.0+incompatible ; \
    go mod edit -replace github.com/Azure/azure-service-bus-go=github.com/Azure/azure-service-bus-go@v0.9.1 ; \
    go mod edit -replace github.com/Azure/azure-storage-blob-go=github.com/Azure/azure-storage-blob-go@v0.9.0 ; \
    go mod edit -replace github.com/Azure/go-autorest/autorest/adal=github.com/Azure/go-autorest/autorest/adal@v0.9.6 ; \
    go mod edit -replace github.com/Azure/go-autorest/autorest/azure/auth=github.com/Azure/go-autorest/autorest/azure/auth@v0.5.3 ; \
    go mod edit -replace github.com/Azure/go-autorest/autorest/azure/cli=github.com/Azure/go-autorest/autorest/azure/cli@v0.4.2 ; \
    go mod edit -replace github.com/Azure/go-autorest/autorest=github.com/Azure/go-autorest/autorest@v0.9.3 ; \
    go mod edit -replace github.com/bitly/go-hostpool=github.com/bitly/go-hostpool@v0.1.0 ; \
    go mod edit -replace github.com/census-instrumentation/opencensus-proto=github.com/census-instrumentation/opencensus-proto@v0.3.0 ; \
    go mod edit -replace github.com/cncf/udpa/go=github.com/cncf/udpa/go@v0.0.0-20200629203442-efcf912fb354 ; \
    go mod edit -replace github.com/containerd/containerd=github.com/containerd/containerd@v1.3.4 ; \
    go mod edit -replace github.com/containerd/continuity=github.com/containerd/continuity@v0.0.0-20200710164510-efbc4488d8fe ; \
    go mod edit -replace github.com/coreos/go-systemd=github.com/coreos/go-systemd@v0.0.0-20190321100706-95778dfbb74e ; \
    go mod edit -replace github.com/DataDog/datadog-go=github.com/DataDog/datadog-go@v3.4.1+incompatible ; \
    go mod edit -replace github.com/DataDog/zstd=github.com/DataDog/zstd@v1.4.0 ; \
    go mod edit -replace github.com/denisenkom/go-mssqldb=github.com/denisenkom/go-mssqldb@v0.9.0 ; \
    go mod edit -replace github.com/dimchansky/utfbom=github.com/dimchansky/utfbom@v1.1.1 ; \
    go mod edit -replace github.com/dnaeon/go-vcr=github.com/dnaeon/go-vcr@v1.0.1 ; \
    go mod edit -replace github.com/docker/distribution=github.com/docker/distribution@v2.7.1+incompatible ; \
    go mod edit -replace github.com/docker/docker=github.com/docker/docker@v17.12.0-ce-rc1.0.20200309214505-aa6a9891b09c+incompatible ; \
    go mod edit -replace github.com/emicklei/go-restful=github.com/emicklei/go-restful@v0.0.0-20170410110728-ff4f55a20633 ; \
    go mod edit -replace github.com/emirpasic/gods=github.com/emirpasic/gods@v1.9.0 ; \
    go mod edit -replace github.com/envoyproxy/go-control-plane=github.com/envoyproxy/go-control-plane@v0.9.8 ; \
    go mod edit -replace github.com/fatih/color=github.com/fatih/color@v1.9.0 ; \
    go mod edit -replace github.com/getkin/kin-openapi=github.com/getkin/kin-openapi@v0.1.0 ; \
    go mod edit -replace github.com/ghodss/yaml=github.com/ghodss/yaml@v1.0.1-0.20190212211648-25d852aebe32 ; \
    go mod edit -replace github.com/gin-gonic/gin=github.com/gin-gonic/gin@v1.7.2 ; \
    go mod edit -replace github.com/go-chi/chi=github.com/go-chi/chi@v4.0.1+incompatible ; \
    go mod edit -replace github.com/gocql/gocql=github.com/gocql/gocql@v0.0.0-20200624222514-34081eda590e ; \
    go mod edit -replace github.com/go-errors/errors=github.com/go-errors/errors@v1.0.1 ; \
    go mod edit -replace github.com/gogo/protobuf=github.com/gogo/protobuf@v1.3.1 ; \
    go mod edit -replace github.com/golang/glog=github.com/golang/glog@v0.0.0-20160126235308-23def4e6c14b ; \
    go mod edit -replace github.com/golang/mock=github.com/golang/mock@v1.4.4 ; \
    go mod edit -replace github.com/golang/protobuf=github.com/golang/protobuf@v1.4.3 ; \
    go mod edit -replace github.com/golang/snappy=github.com/golang/snappy@v0.0.2 ; \
    go mod edit -replace github.com/go-logr/logr=github.com/go-logr/logr@v0.2.0 ; \
    go mod edit -replace github.com/google/cel-go=github.com/google/cel-go@v0.5.1 ; \
    go mod edit -replace github.com/google/cel-spec=github.com/google/cel-spec@v0.4.0 ; \
    go mod edit -replace github.com/google/go-cmp=github.com/google/go-cmp@v0.5.4 ; \
    go mod edit -replace github.com/google/gofuzz=github.com/google/gofuzz@v1.2.0 ; \
    go mod edit -replace github.com/google/martian=github.com/google/martian@v2.1.1-0.20190517191504-25dcb96d9e51+incompatible ; \
    go mod edit -replace github.com/google/pprof=github.com/google/pprof@v0.0.0-20201023163331-3e6fc7fc9c4c ; \
    go mod edit -replace github.com/googleapis/gnostic=github.com/googleapis/gnostic@v0.4.1 ; \
    go mod edit -replace github.com/go-ole/go-ole=github.com/go-ole/go-ole@v1.2.4 ; \
    go mod edit -replace github.com/go-openapi/jsonpointer=github.com/go-openapi/jsonpointer@v0.19.3 ; \
    go mod edit -replace github.com/go-playground/validator/v10=github.com/go-playground/validator/v10@v10.4.1 ; \
    go mod edit -replace github.com/gorilla/mux=github.com/gorilla/mux@v1.7.4 ; \
    go mod edit -replace github.com/gregjones/httpcache=github.com/gregjones/httpcache@v0.0.0-20190611155906-901d90724c79 ; \
    go mod edit -replace github.com/grpc-ecosystem/go-grpc-middleware=github.com/grpc-ecosystem/go-grpc-middleware@v1.0.1-0.20190118093823-f849b5445de4 ; \
    go mod edit -replace github.com/hashicorp/consul/api=github.com/hashicorp/consul/api@v1.4.0 ; \
    go mod edit -replace github.com/hashicorp/consul/sdk=github.com/hashicorp/consul/sdk@v0.4.0 ; \
    go mod edit -replace github.com/hashicorp/errwrap=github.com/hashicorp/errwrap@v1.1.0 ; \
    go mod edit -replace github.com/hashicorp/go-hclog=github.com/hashicorp/go-hclog@v0.9.2 ; \
    go mod edit -replace github.com/hashicorp/go-immutable-radix=github.com/hashicorp/go-immutable-radix@v1.1.0 ; \
    go mod edit -replace github.com/hashicorp/go-msgpack=github.com/hashicorp/go-msgpack@v0.5.5 ; \
    go mod edit -replace github.com/hashicorp/go-multierror=github.com/hashicorp/go-multierror@v1.1.0 ; \
    go mod edit -replace github.com/hashicorp/go-retryablehttp=github.com/hashicorp/go-retryablehttp@v0.6.8 ; \
    go mod edit -replace github.com/hashicorp/go-rootcerts=github.com/hashicorp/go-rootcerts@v1.0.2 ; \
    go mod edit -replace github.com/hashicorp/go-sockaddr=github.com/hashicorp/go-sockaddr@v1.0.2 ; \
    go mod edit -replace github.com/hashicorp/go-uuid=github.com/hashicorp/go-uuid@v1.0.2-0.20191001231223-f32f5fe8d6a8 ; \
    go mod edit -replace github.com/hashicorp/go-version=github.com/hashicorp/go-version@v1.2.1 ; \
    go mod edit -replace github.com/hashicorp/hcl=github.com/hashicorp/hcl@v1.0.1-vault ; \
    go mod edit -replace github.com/hashicorp/mdns=github.com/hashicorp/mdns@v1.0.1 ; \
    go mod edit -replace github.com/hashicorp/memberlist=github.com/hashicorp/memberlist@v0.1.5 ; \
    go mod edit -replace github.com/hashicorp/raft=github.com/hashicorp/raft@v1.1.3-0.20201002073007-f367681f9c48 ; \
    go mod edit -replace github.com/hashicorp/serf=github.com/hashicorp/serf@v0.8.6 ; \
    go mod edit -replace github.com/ianlancetaylor/demangle=github.com/ianlancetaylor/demangle@v0.0.0-20200824232613-28f6c0f3b639 ; \
    go mod edit -replace github.com/imdario/mergo=github.com/imdario/mergo@v0.3.6 ; \
    go mod edit -replace github.com/influxdata/line-protocol=github.com/influxdata/line-protocol@v0.0.0-20180522152040-32c6aa80de5e ; \
    go mod edit -replace github.com/jackc/pgx=github.com/jackc/pgx@v3.3.0+incompatible ; \
    go mod edit -replace github.com/jonboulle/clockwork=github.com/jonboulle/clockwork@v0.1.0 ; \
    go mod edit -replace github.com/kisielk/errcheck=github.com/kisielk/errcheck@v1.2.0 ; \
    go mod edit -replace github.com/kr/pretty=github.com/kr/pretty@v0.2.1 ; \
    go mod edit -replace github.com/kr/pty=github.com/kr/pty@v1.1.5 ; \
    go mod edit -replace github.com/mailru/easyjson=github.com/mailru/easyjson@v0.0.0-20190626092158-b2ccc519800e ; \
    go mod edit -replace github.com/mattn/go-colorable=github.com/mattn/go-colorable@v0.1.6 ; \
    go mod edit -replace github.com/mattn/go-ieproxy=github.com/mattn/go-ieproxy@v0.0.1 ; \
    go mod edit -replace github.com/mattn/go-runewidth=github.com/mattn/go-runewidth@v0.0.3 ; \
    go mod edit -replace github.com/matttproud/golang_protobuf_extensions=github.com/matttproud/golang_protobuf_extensions@v1.0.1 ; \
    go mod edit -replace github.com/Microsoft/go-winio=github.com/Microsoft/go-winio@v0.4.3 ; \
    go mod edit -replace github.com/Microsoft/hcsshim=github.com/Microsoft/hcsshim@v0.8.9 ; \
    go mod edit -replace github.com/miekg/dns=github.com/miekg/dns@v1.1.26 ; \
    go mod edit -replace github.com/mitchellh/cli=github.com/mitchellh/cli@v1.1.1 ; \
    go mod edit -replace github.com/mitchellh/gox=github.com/mitchellh/gox@v1.0.1 ; \
    go mod edit -replace github.com/mitchellh/mapstructure=github.com/mitchellh/mapstructure@v1.4.0 ; \
    go mod edit -replace github.com/moby/term=github.com/moby/term@v0.0.0-20200915141129-7f0af18e79f2 ; \
    go mod edit -replace github.com/morikuni/aec=github.com/morikuni/aec@v1.0.0 ; \
    go mod edit -replace github.com/munnerz/goautoneg=github.com/munnerz/goautoneg@v0.0.0-20120707110453-a547fc61f48d ; \
    go mod edit -replace github.com/nats-io/nats-server/v2=github.com/nats-io/nats-server/v2@v2.1.9 ; \
    go mod edit -replace github.com/nats-io/nats-streaming-server=github.com/nats-io/nats-streaming-server@v0.11.2 ; \
    go mod edit -replace github.com/nats-io/nkeys=github.com/nats-io/nkeys@v0.2.0 ; \
    go mod edit -replace github.com/NYTimes/gziphandler=github.com/NYTimes/gziphandler@v1.1.1 ; \
    go mod edit -replace github.com/olekukonko/tablewriter=github.com/olekukonko/tablewriter@v0.0.0-20180130162743-b8a9be070da4 ; \
    go mod edit -replace github.com/OneOfOne/xxhash=github.com/OneOfOne/xxhash@v1.2.2 ; \
    go mod edit -replace github.com/onsi/gomega=github.com/onsi/gomega@v1.7.0 ; \
    go mod edit -replace github.com/opencontainers/runc=github.com/opencontainers/runc@v1.0.0-rc9 ; \
    go mod edit -replace github.com/opentracing/opentracing-go=github.com/opentracing/opentracing-go@v1.1.0 ; \
    go mod edit -replace github.com/pierrec/lz4=github.com/pierrec/lz4@v2.6.0+incompatible ; \
    go mod edit -replace github.com/posener/complete=github.com/posener/complete@v1.2.1 ; \
    go mod edit -replace github.com/prometheus/client_golang=github.com/prometheus/client_golang@v1.7.1 ; \
    go mod edit -replace github.com/prometheus/procfs=github.com/prometheus/procfs@v0.1.3 ; \
    go mod edit -replace github.com/rcrowley/go-metrics=github.com/rcrowley/go-metrics@v0.0.0-20200313005456-10cdbea86bc0 ; \
    go mod edit -replace github.com/rs/zerolog=github.com/rs/zerolog@v1.4.0 ; \
    go mod edit -replace github.com/russross/blackfriday=github.com/russross/blackfriday@v1.5.2 ; \
    go mod edit -replace github.com/ryanuber/columnize=github.com/ryanuber/columnize@v2.1.0+incompatible ; \
    go mod edit -replace github.com/sergi/go-diff=github.com/sergi/go-diff@v1.0.0 ; \
    go mod edit -replace github.com/Shopify/sarama=github.com/Shopify/sarama@v1.27.2 ; \
    go mod edit -replace github.com/sirupsen/logrus=github.com/sirupsen/logrus@v1.6.0 ; \
    go mod edit -replace github.com/spaolacci/murmur3=github.com/spaolacci/murmur3@v0.0.0-20180118202830-f09979ecbc72 ; \
    go mod edit -replace github.com/spf13/cast=github.com/spf13/cast@v1.3.0 ; \
    go mod edit -replace github.com/spf13/cobra=github.com/spf13/cobra@v0.0.5 ; \
    go mod edit -replace github.com/spf13/jwalterweatherman=github.com/spf13/jwalterweatherman@v1.1.0 ; \
    go mod edit -replace github.com/spf13/viper=github.com/spf13/viper@v1.7.1 ; \
    go mod edit -replace github.com/StackExchange/wmi=github.com/StackExchange/wmi@v0.0.0-20190523213315-cbe66965904d ; \
    go mod edit -replace github.com/streadway/amqp=github.com/streadway/amqp@v1.0.0 ; \
    go mod edit -replace github.com/tidwall/pretty=github.com/tidwall/pretty@v1.0.1 ; \
    go mod edit -replace github.com/urfave/cli=github.com/urfave/cli@v1.22.3 ; \
    go mod edit -replace github.com/xeipuuv/gojsonschema=github.com/xeipuuv/gojsonschema@v1.2.1-0.20200424115421-065759f9c3d7 ; \
    go mod edit -replace github.com/yuin/goldmark=github.com/yuin/goldmark@v1.2.1 ; \
    go mod edit -replace github.com/yuin/gopher-lua=github.com/yuin/gopher-lua@v0.0.0-20190206043414-8bfc7677f583 ; \
    go mod edit -replace go.etcd.io/etcd=go.etcd.io/etcd@v0.5.0-alpha.5.0.20200425165423-262c93980547 ; \
    go mod edit -replace go.mongodb.org/mongo-driver=go.mongodb.org/mongo-driver@v1.4.2 ; \
    go mod edit -replace go.uber.org/atomic=go.uber.org/atomic@v1.6.0 ; \
    go mod edit -replace go.uber.org/multierr=go.uber.org/multierr@v1.5.0 ; \
    go mod edit -replace golang.org/x/crypto=golang.org/x/crypto@v0.0.0-20210322153248-0c34fe9e7dc2 ; \
    go mod edit -replace golang.org/x/exp=golang.org/x/exp@v0.0.0-20200224162631-6cc2880d07d6 ; \
    go mod edit -replace golang.org/x/lint=golang.org/x/lint@v0.0.0-20200302205851-738671d3881b ; \
    go mod edit -replace golang.org/x/mod=golang.org/x/mod@v0.4.0 ; \
    go mod edit -replace golang.org/x/net=golang.org/x/net@v0.0.0-20210525063256-abc453219eb5 ; \
    go mod edit -replace golang.org/x/oauth2=golang.org/x/oauth2@v0.0.0-20201203001011-0b49973bad19 ; \
    go mod edit -replace golang.org/x/sys=golang.org/x/sys@v0.0.0-20210423082822-04245dca01da ; \
    go mod edit -replace golang.org/x/time=golang.org/x/time@v0.0.0-20200630173020-3af7569d3a1e ; \
    go mod edit -replace golang.org/x/tools=golang.org/x/tools@v0.0.0-20201203202102-a1a1cbeaa516 ; \
    go mod edit -replace google.golang.org/appengine=google.golang.org/appengine@v1.6.7 ; \
    go mod edit -replace google.golang.org/genproto=google.golang.org/genproto@v0.0.0-20201203001206-6486ece9c497 ; \
    go mod edit -replace google.golang.org/grpc=google.golang.org/grpc@v1.34.0 ; \
    go mod edit -replace google.golang.org/protobuf=google.golang.org/protobuf@v1.25.0 ; \
    go mod edit -replace gopkg.in/check.v1=gopkg.in/check.v1@v1.0.0-20201130134442-10cb98267c6c ; \
    go mod edit -replace gopkg.in/jcmturner/gokrb5.v7=gopkg.in/jcmturner/gokrb5.v7@v7.5.0 ; \
    go mod edit -replace gopkg.in/square/go-jose.v2=gopkg.in/square/go-jose.v2@v2.5.1 ; \
    go mod edit -replace gopkg.in/yaml.v2=gopkg.in/yaml.v2@v2.3.0 ; \
    go mod edit -replace gopkg.in/yaml.v3=gopkg.in/yaml.v3@v3.0.0-20200615113413-eeeca48fe776 ; \
    go mod edit -replace k8s.io/api=k8s.io/api@v0.20.2 ; \
    go mod edit -replace k8s.io/apimachinery=k8s.io/apimachinery@v0.20.2 ; \
    go mod edit -replace k8s.io/client-go=k8s.io/client-go@v8.0.0+incompatible ; \
    go mod edit -replace k8s.io/gengo=k8s.io/gengo@v0.0.0-20200413195148-3a45101e95ac ; \
    go mod edit -replace k8s.io/utils=k8s.io/utils@v0.0.0-20200324210504-a9aa75ae1b89

RUN go mod tidy

RUN go build -buildmode=plugin -o ./krakend-dapr-grpc-plugin.so .

# 
# Final Image
FROM devopsfaith/krakend:1.4.1

USER root

RUN apt-get update && apt-get -y install musl musl-dev

RUN ln -s /usr/lib/x86_64-linux-musl/libc.so /lib/libc.musl-x86_64.so.1

COPY ./scripts/krakend.json /etc/krakend

COPY --from=builder /plugin/*.so /etc/krakend/

COPY --from=builder /plugin/go.mod /etc/krakend/
COPY --from=builder /plugin/go.sum /etc/krakend/

CMD ["run", "--config", "/etc/krakend/krakend.json"]