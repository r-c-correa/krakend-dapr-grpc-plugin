package main

import (
	"context"
	"log"
	"net/http"

	"github.com/r-c-correa/krakend-dapr-grpc-plugin/plugin"
)

func run() error {
	mux, err := plugin.NewGateway(context.Background(), "localhost:7004")
	if err != nil {
		return err
	}

	log.Println("Listening on 8081...")
	return http.ListenAndServe(":8081", mux)
}

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}
