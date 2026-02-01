package main

import (
	"fmt"
)

var (
	buildVersion string
	buildCommit string
	buildDate string
)

func main() {
	fmt.Printf("Version: %s\nCommit:  %s\nDate:    %s\n", buildVersion, buildCommit, buildDate)
}
