package plugin

import (
	"context"
	"net/http"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"

	gw "github.com/r-c-correa/krakend-dapr-grpc-plugin/plugin/gateways/dapr/proto/runtime/v1"
)

func NewGateway(ctx context.Context, endpoint string) (http.Handler, error) {
	gwMux := runtime.NewServeMux(runtime.WithForwardResponseOption(httpResponseModifier))
	opts := []grpc.DialOption{grpc.WithInsecure()}
	if err := gw.RegisterDaprHandlerFromEndpoint(ctx, gwMux, endpoint, opts); err != nil {
		return nil, err
	}

	mux := http.NewServeMux()
	mux.Handle("/", gwMux)
	return mux, nil
}

func httpResponseModifier(ctx context.Context, w http.ResponseWriter, p proto.Message) error {
	w.Header().Del("Grpc-Metadata-Grpc-Trace-Bin")
	w.Header().Del("Trailer")
	w.Header().Del("Trailer")
	w.Header().Del("Grpc-Metadata-Content-Type")
	w.Header().Del("Grpc-Metadata-Traceparent")

	return nil
}
