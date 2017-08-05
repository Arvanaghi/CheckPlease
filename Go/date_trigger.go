/*
    Waits until a user-defined date to execute, Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
   "fmt"
   "time"
   "os"
)

func main() {

	if (len(os.Args) == 1) {
		fmt.Println("You must provide a date in format mm/dd/yyyy.")
		os.Exit(1)
	}

	triggerDateRaw, _ := time.Parse("01/02/2006", os.Args[1])
	trigYear, trigMonth, trigDay := triggerDateRaw.Date()
	triggerDate := time.Date(trigYear, trigMonth, trigDay, 0, 0, 0, 0, time.Now().Location())

	year, month, day := time.Now().Date()
	today := time.Date(year, month, day, 0, 0, 0, 0, time.Now().Location())

	for (today.Before(triggerDate)) {
		time.Sleep(time.Duration(86340 * time.Second))
		year, month, day := time.Now().Date()
		today = time.Date(year, month, day, 0, 0, 0, 0, time.Now().Location())
	}

	fmt.Printf("Now that today is %+v, we may proceed with malware execution!\n", today.Format("01/02/2006"))

}