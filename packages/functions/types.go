package functions

import "time"

// FirestoreEvent is the payload of a Firestore event.
type FirestoreEvent struct {
	OldValue   FirestoreValue `json:"oldValue"`
	Value      FirestoreValue `json:"value"`
	UpdateMask struct {
		FieldPaths []string `json:"fieldPaths"`
	} `json:"updateMask"`
}

// FirestoreValue holds Firestore fields.
type FirestoreValue struct {
	CreateTime time.Time `json:"createTime"`
	// Fields is the data for this value. The type depends on the format of your
	// database. Log the interface{} value and inspect the result to see a JSON
	// representation of your database fields.
	Fields     interface{} `json:"fields"`
	Name       string      `json:"name"`
	UpdateTime time.Time   `json:"updateTime"`
}

type GTFSSource struct {
	MdbSourceId string            `firestore:"mdb_source_id" csv:"mdb_source_id"`
	DataType    string            `firestore:"data_type" csv:"data_type"`
	Provider    string            `firestore:"provider" csv:"provider"`
	Name        string            `firestore:"name" csv:"name"`
	Location    GTFSLocation      `firestore:"location" csv:"location.,inline"`
	Urls        GTFSUrls          `firestore:"urls" csv:"urls.,inline"`
	OtherData   map[string]string `csv:"-"`
}

type GTFSLocation struct {
	CountryCode     string          `firestore:"country_code" csv:"country_code"`
	SubdivisionName string          `firestore:"subdivision_name" csv:"subdivision_name"`
	Municipality    string          `firestore:"municipality" csv:"municipality"`
	BoundingBox     GTFSBoundingBox `firestore:"bounding_box" csv:"bounding_box,inline"`
}

type GTFSBoundingBox struct {
	MinimumLatitude  float64    `firestore:"minimum_latitude" csv:"minimum_latitude"`
	MaximumLatitude  float64    `firestore:"maximum_latitude" csv:"maximum_latitude"`
	MinimumLongitude float64    `firestore:"minimum_longitude" csv:"minimum_longitude"`
	MaximumLongitude float64    `firestore:"maximum_longitude" csv:"maximum_longitude"`
	ExtractedOn      *time.Time `firestore:"extracted_on" csv:"extracted_on"`
}
type GTFSUrls struct {
	DirectDownload string `firestore:"direct_download" csv:"direct_download,omitempty"`
	Latest         string `firestore:"latest" csv:"latest,omitempty"`
	License        string `firestore:"license" csv:"license,omitempty"`
}
