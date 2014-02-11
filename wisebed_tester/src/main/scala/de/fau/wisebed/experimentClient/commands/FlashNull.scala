package de.fau.wisebed.experimentClient.commands

import de.fau.wisebed.experimentClient.Command
import de.fau.wisebed.experimentClient.Config
import de.fau.wisebed.experimentClient.ExpClientPredef._

class FlashNull(conf: Config) extends Command(conf) {
	init(conf.confFile)
	startExp(3)
	flashNull()
	cleanup(true)
}