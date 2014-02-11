package de.fau.wisebed.experimentClient.commands

import de.fau.wisebed.experimentClient.Command
import de.fau.wisebed.experimentClient.Config
import de.fau.wisebed.experimentClient.ExpClientPredef._

class Flash(conf: Config) extends Command(conf) {
	init(conf.confFile)
	startExp(3)
	flash(conf.file.toString)
	cleanup(true)
}