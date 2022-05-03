package functions

import (
	"context"

	"cloud.google.com/go/firestore"
	firebase "firebase.google.com/go/v4"
)

func InitFirestore(projectID string, ctx *context.Context) (*firestore.Client, error) {
	// Use the application default credentials.
	conf := &firebase.Config{ProjectID: projectID}

	app, err := firebase.NewApp(*ctx, conf)
	if err != nil {
		return nil, err
	}

	return app.Firestore(*ctx)
}
