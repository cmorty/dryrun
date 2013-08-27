

init("/proj/i4labs/morty/experiments/rssi/config.xml")
startExp(1)
log.info("Res: " + resToString.mkString("\n"))
println("Press Return to Reboot")
while(true){
	readLine
	resetNodes(4, 6)
}