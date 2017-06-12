/*
    Checks if time zone is Coordinated Universal Time (UTC), Go
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"
	"time"
)

func main() {

    zoneAbbrv, offsetFromUTC := time.Now().Zone()
    if offsetFromUTC == 0 {
    	fmt.Println("The time zone is Coordinated Universal Time (UTC), do not proceed.")
    } else {
    	fmt.Println("The time zone is " + zoneAbbrv + ". Proceed!")
    }

}