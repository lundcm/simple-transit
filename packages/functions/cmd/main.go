package main

import (
	"context"
	"log"
	"os"

	// Blank-import the function package so the init() runs
	"functions/sources_sync"

	"github.com/GoogleCloudPlatform/functions-framework-go/funcframework"
)

func init() {
	os.Setenv("GOOGLE_CLOUD_PROJECT", "simple-transit")
	os.Setenv("FUNCTION_TARGET", "SourcesSync")
}

func main() {
	// Use PORT environment variable, or default to 8080.
	port := "8080"
	if envPort := os.Getenv("PORT"); envPort != "" {
		port = envPort
	}

	funcframework.RegisterEventFunctionContext(context.Background(), "SourcesSync", sources_sync.SourcesSync)
	// funcframework.RegisterEventFunctionContext(context.Background(), "SourcesSync", sources_sync.SourcesSync)

	// sources_sync.SourcesSync(context.Background(), nil)
	if err := funcframework.Start(port); err != nil {
		log.Fatalf("funcframework.Start: %v\n", err)
	}
}
