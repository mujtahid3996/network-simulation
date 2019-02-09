#!/usr/bin/perl
$src = "out.tr";
#initialization
$fid_ =0
$total_sent=0;
$total_recv=0;
$total_failed=0;
$T_delay=0;
$num_pkt=0;
$max_node = 8;
for ($i = 0; $i < $max_node; $i++) {
           $sent[$i] = 0;
           $recv[$i] = 0;
}
#collecting trace content into a variable
open(IN,$src);
@line=<IN>;
#print @line;
#handaling each event seperately
foreach $i (@line){
     #print $i;
     @input=split(' ',$i);
     #print $input[0]."\n";
      #calculating sending event
        if($input[0] eq '-') {
                $fid_ =$input[7]
		@temp_src = split('\.',$input[8]);
	#if($input[2] eq tempsrc )
		$sent[$fid_ ]++;

        }
	     #calculating receiving event
        if($input[0] eq 'r')
	{
	$fid_ =$input[7];
	@temp_dst =split('\.',$input[9])

	#if($input[3] eq $temp_dst)
	$recv[$fid_ ]++;
        }
}
#performance summary
$max = 0;
$min = 1000;
print "\n\nPer Source Survay:\n\n";
for ($i = 0; $i <=$max_node; $i++) {
           if ($sent[$i] > 0 ) {
               print " Source Node:",$i," ->
Throughput(recved/sent): ",$recv[$i],"/", $sent[$i], "=",
$recv[$i]/$sent[$i],"\n";
           }
}
print "\n\nAt a glance :\n";
print "Total_sent: ",$total_sent, "\nTotal_recv:", $total_recv,
"\nTotal_recv/Total_sent:", $total_recv/$total_sent,"\n";
close(IN);




