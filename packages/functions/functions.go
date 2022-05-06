package functions

import (
	"log"
	"os"
)

var (
	logger *log.Logger
)

func init() {
	// err is pre-declared to avoid shadowing client.
	var err error

	logger = log.New(os.Stdout, "[Timefox::Function::"+funcName+"]", log.LstdFlags)

	if err != nil {
		logger.Fatalf("something: %v", err)
	}
}
