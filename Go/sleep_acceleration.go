/*
    Go sleep acceleration checker via NTP cluster queries
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
*/

package main

import (
	"fmt"	
	"os"
	"net"
	"time"
	"encoding/binary"
	"strconv"
)

func getNTPTime() time.Time {

	type ntp_struct struct {FirstByte,A,B,C uint8;D,E,F uint32;G,H uint64;ReceiveTime uint64;J uint64}

	sock,_ := net.Dial("udp", "us.pool.ntp.org:123");
	sock.SetDeadline(time.Now().Add((2*time.Second)))
	defer sock.Close()

	ntp_transmit := new(ntp_struct)
	ntp_transmit.FirstByte=0x1b

	binary.Write(sock, binary.BigEndian, ntp_transmit)
	binary.Read(sock, binary.BigEndian, ntp_transmit)
	return time.Date(1900, 1, 1, 0, 0, 0, 0, time.UTC).Add(time.Duration(((ntp_transmit.ReceiveTime >> 32)*1000000000)))

}

func main() {
	
	firstTime := getNTPTime()
	fmt.Printf("NTP time (UTC) before sleeping: %+v\n", firstTime)

	sleepSeconds, _ := strconv.Atoi(os.Args[1])
	fmt.Printf("Attempting to sleep for %+v seconds...\n", sleepSeconds)
	time.Sleep(time.Duration(sleepSeconds * 1000)  * time.Millisecond)

	secondTime := getNTPTime()
	fmt.Printf("NTP time (UTC) after sleeping: %+v\n", secondTime)

	difference := secondTime.Sub(firstTime).Seconds()

	fmt.Printf("Difference in NTP times (should be at least %+v seconds): %+v\n", sleepSeconds, difference)

	if (difference >= float64(sleepSeconds)) {
		fmt.Println("Proceed!")
	}

}