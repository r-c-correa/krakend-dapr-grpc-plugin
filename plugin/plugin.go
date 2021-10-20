package plugin

import (
	"context"
	"errors"
	"fmt"
	"net/http"
)

const pluginName = "krakend-dapr-grpc-plugin"

func init() {
	fmt.Println("krakend-dapr-grpc-plugin loading")
}

var ClientRegisterer = registerer(pluginName)

type registerer string

func (r registerer) RegisterClients(f func(
	name string,
	handler func(context.Context, map[string]interface{}) (http.Handler, error),
)) {
	f(string(r), func(ctx context.Context, extra map[string]interface{}) (http.Handler, error) {
		cfg := parse(extra)
		if cfg == nil {
			return nil, errors.New(pluginName + " - clients - wrong config")
		}
		if cfg.name != string(r) {
			return nil, fmt.Errorf(pluginName+" - clients - unknown register %s", cfg.name)
		}
		return NewGateway(ctx, cfg.endpoint)
	})
}

func parse(extra map[string]interface{}) *opts {
	name, ok := extra["name"].(string)
	if !ok {
		return nil
	}

	rawEs, ok := extra["endpoints"]
	if !ok {
		return nil
	}
	es, ok := rawEs.([]interface{})
	if !ok || len(es) < 1 {
		return nil
	}
	endpoints := make([]string, len(es))
	for i, e := range es {
		endpoints[i] = e.(string)
	}

	return &opts{
		name:     name,
		endpoint: endpoints[0],
	}
}

type opts struct {
	name     string
	endpoint string
}

/* Handler Example:
var HandlerRegisterer registrable = registrable(pluginName)

type registrable string

func (r registrable) RegisterHandlers(f func(
	name string,
	handler func(
		context.Context,
		map[string]interface{},
		http.Handler) (http.Handler, error),
)) {
	f(pluginName, r.registerHandlers)
}

func (r registrable) registerHandlers(ctx context.Context, extra map[string]interface{}, handler http.Handler) (http.Handler, error) {
	cfg := parse(extra)
	if cfg == nil {
		return nil, errors.New(pluginName + " - handlers - wrong config")
	}
	if cfg.name != string(r) {
		return nil, fmt.Errorf(pluginName+" - handlers - unknown register %s", cfg.name)
	}
	return nil, errors.New(pluginName + " - handlers - not implemented")
}
*/
