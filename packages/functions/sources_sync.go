package sources_sync

import (
	"context"
	"encoding/csv"
	"io"
	"log"
	"net/http"
	"os"

	"functions"

	"cloud.google.com/go/firestore"
	firebase "firebase.google.com/go/v4"
	"github.com/jszwec/csvutil"
)

func init() {
	// Use the application default credentials.
	conf := &firebase.Config{ProjectID: projectID}

	app, err := firebase.NewApp(ctx, conf)
	if err != nil {
		log.Fatalf("firebase.NewApp: %v", err)
	}

	client, err = app.Firestore(ctx)
	if err != nil {
		log.Fatalf("app.Firestore: %v", err)
	}
}

func readCSVFromUrl(url string) ([]functions.GTFSSource, error) {
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}

	defer resp.Body.Close()
	reader := csv.NewReader(resp.Body)
	var sources []functions.GTFSSource

	dec, err := csvutil.NewDecoder(reader)
	if err != nil {
		return nil, err
	}

	for {
		var s functions.GTFSSource
		if err = dec.Decode(&s); err == io.EOF {
			break
		} else if err != nil {
			return nil, err
		}
		sources = append(sources, s)
	}

	return sources, nil
}

func gtfsDownload(ctx context.Context) error {
	url := "https://storage.googleapis.com/storage/v1/b/mdb-csv/o/sources.csv?alt=media"
	sources, err := readCSVFromUrl(url)
	if err != nil {
		return err
	}

	for _, source := range sources {
		if _, err = client.Collection("transit").Doc(source.MdbSourceId).Set(ctx, source); err != nil {
			return err
		}

		log.Println(source)
	}

	return nil
}

func SourcesSync(ctx context.Context, _ interface{}) error {
	log.Println("Starting...")
	err := gtfsDownload(ctx)
	return err
}
