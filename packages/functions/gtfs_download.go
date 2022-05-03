package gtfs_download

import (
	"context"
	"log"
	"os"

	"functions"

	"cloud.google.com/go/firestore"
)

// GOOGLE_CLOUD_PROJECT is automatically set by the Cloud Functions runtime.
var projectID = os.Getenv("GOOGLE_CLOUD_PROJECT")

// Use context.Background() because the app/client should persist across invocations.
var ctx = context.Background()

// client is a Firestore client, reused between function invocations.
var client *firestore.Client

func init() {
	var err error
	client, err = functions.InitFirestore(projectID, &ctx)
	if err != nil {
		log.Fatalf("app.Firestore: %v", err)
	}
}

func GTFSDownload(ctx context.Context, e functions.FirestoreEvent) error {
	// compare firestore event

	return nil
}
