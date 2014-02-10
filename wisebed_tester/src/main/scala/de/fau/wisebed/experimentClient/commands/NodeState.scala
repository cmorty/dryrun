package de.fau.wisebed.experimentClient.commands

import de.fau.wisebed.experimentClient.Command
import de.fau.wisebed.experimentClient.Config
import de.fau.wisebed.experimentClient.ExpClientPredef._


class NodeState(conf:Config) extends Command(conf) {
		init(conf.confFile)
		startExp(1)
		println(getActiveNodes.sorted.mkString("Active:\n","\n", "\n"))
		val incative = allnodes.diff(getActiveNodes)
		
		println(incative.sorted.mkString("Inactive:\n","\n", ""))
		cleanup(true)
}