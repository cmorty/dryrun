package de.fau.wisebed.experimentClient.commands

import de.fau.wisebed.experimentClient.Command
import de.fau.wisebed.experimentClient.Config
import de.fau.wisebed.experimentClient.ExpClientPredef._

class List(conf:Config) extends Command(conf) {
	init(conf.confFile)
	println(allnodes.sorted.mkString("Nodes:\n", "\n", ""))
	cleanup(true)
}