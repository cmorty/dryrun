The RealSim Test Client
=======================

Compilation
-----------
You need to install the Wisebed Scala API first: https://github.com/cmorty/scala-client -> `mvn install`  
run 'mvn package'

Running
-------
    java -jar target/wisebed_testinterface-0.0.1-SNAPSHOT.jar <testscript>


Documentation
-------------

You first need to save the wisebed settings in an config.xml -> `see config.example.xml`

The documentation can be built using `maven scala:doc`. The interesting part is `ExpClientPredef`

An example scipt may look like

```scala
init() //Initialize project
startExp(20) //Start an 20 minute experiment
flash("myprog.hex") //Flash myprog on all nodes
addLogLine("wisebed.log") // Log everything into wisebed.log
resetNodes(4, 18, "Rime started") //Reset Nodes randomly within 4 seconds; Seed randomness with 18; Wait for "Rime Started"
resetTime() //Reset the Time of the expriment - 20 min start now
waitEnd(false, 10) // Wait until 10s before the end - do not terminate
collectData("stats\n", "===\n") //Send ""stats" to the node and wait until all of them answered with ===
cleanup(true) // cleanup(force)
```





