name := "testgen"

version := "0.1"

scalaVersion := "2.9.2"


// set the main Scala source directory to be <base>/src
scalaSource in Compile <<= baseDirectory(_ / "src")

// set the main class for packaging the main jar
// 'run' will still auto-detect and prompt
// change Compile to Test to set it for the test jar
mainClass in (Compile, packageBin) := Some("de.fau.dryrun.testgen.Client")



// set the main class for the main 'run' task
// change Compile to Test to set it for 'test:run'
mainClass in (Compile, run) := Some("de.fau.dryrun.testgen.Client")



exportJars := true


packageOptions in (Compile, packageBin) += Package.ManifestAttributes( java.util.jar.Attributes.Name.CLASS_PATH -> ". lib/scala-library.jar lib/scala-compiler.jar lib/jgit.jar" ) 

