#Create a simulator object
set ns [new Simulator]
#Open the All trace file
set f [open out.tr w]
$ns trace-all $f
set namFile [open out.nam w]
$ns namtrace-all $namFile

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n3 1Mb 200ms DropTail
$ns duplex-link $n1 $n3 1Mb 200ms DropTail
$ns duplex-link $n2 $n4 1Mb 200ms DropTail
$ns duplex-link $n4 $n5 1Mb 200ms DropTail
$ns duplex-link $n5 $n6 2Mb 200ms DropTail
$ns duplex-link $n6 $n7 1Mb 200ms DropTail
$ns duplex-link $n7 $n8 1Mb 200ms DropTail
$ns duplex-link $n7 $n9 1Mb 200ms DropTail
$ns duplex-link $n7 $n10 1Mb 200ms DropTail

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n10 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 0
#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n10 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 1
#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n10 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n1 $sink3
$ns connect $tcp3 $sink3
$tcp3 set fid_ 2
#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n10 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n2 $sink4
$ns connect $tcp4 $sink4
$tcp4 set fid_ 3
#Setup a UDP connection
set udp1 [new Agent/UDP]
$ns attach-agent $n2 $udp1
set null1 [new Agent/Null]
$ns attach-agent $n8 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 4
#Setup a UDP connection
set udp2 [new Agent/UDP]
$ns attach-agent $n0 $udp2
set null2 [new Agent/Null]
$ns attach-agent $n8 $null1
$ns connect $udp2 $null1
$udp2 set fid_ 5
#Setup a UDP connection
set udp3 [new Agent/UDP]
$ns attach-agent $n8 $udp3
set null3 [new Agent/Null]
$ns attach-agent $n9 $null3
$ns connect $udp3 $null3
$udp3 set fid_ 6
#Setup a UDP connection
set udp4 [new Agent/UDP]
$ns attach-agent $n9 $udp4
set null4 [new Agent/Null]
$ns attach-agent $n8 $null1
$ns connect $udp4 $null1
$udp4 set fid_ 7
#Setup a FTP over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set packet_size_ 512
#Setup a FTP over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set packet_size_ 512
#Setup a FTP over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set packet_size_ 512
#Setup a FTP over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set packet_size_ 512
#Setup a CBR over UDP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packet_size_ 1000
$cbr1 set rate_ 1mb
#Setup a CBR over UDP connection
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set packet_size_ 1000
$cbr2 set rate_ 1mb
#Setup a CBR over UDP connection
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set packet_size_ 1000
$cbr3 set rate_ 1mb
#Setup a CBR over UDP connection
set cbr4 [new Application/Traffic/CBR]
$cbr4 attach-agent $udp4
$cbr4 set packet_size_ 1000
$cbr4 set rate_ 1mb

#Schedule events for the CBR and FTP agents
$ns at 2.0 "$ftp1 start"
$ns at 4.0 "$ftp2 start"
$ns at 6.0 "$ftp3 start"
$ns at 8.0 "$ftp4 start"
$ns at 10.0 "$udp1 start"
$ns at 12.0 "$udp2 start"
$ns at 14.0 "$udp3 start"
$ns at 16.0 "$udp4 start"
$ns at 20.0 "$ftp1 stop"
$ns at 25.0 "$ftp2 stop"
$ns at 30.0 "$ftp3 stop"
$ns at 35.0 "$ftp4 stop"
$ns at 40.0 "$udp1 stop"
$ns at 45.0 "$udp2 stop"
$ns at 50.0 "$udp3 stop"
$ns at 55.0 "$udp4 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 60.0 "finish"
#Print CBR packet size and interval
puts "CBR1 packet size = [$cbr1 set packet_size_]"
puts "CBR1 interval = [$cbr1 set interval_]"

#Define a 'finish' procedure
proc finish {} {
      global ns f
      $ns flush-trace
      #Close the trace file
      close $f
                  exit 0
}

#Run the simulation
$ns run


























