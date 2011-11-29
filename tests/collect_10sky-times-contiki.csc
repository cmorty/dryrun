<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/realsim</project>
  <project EXPORT="discard">[APPS_DIR]/trace</project>
  <project EXPORT="discard">[APPS_DIR]/trace/sqlite</project>
  <simulation>
    <title>My simulation</title>
    <delaytime>0</delaytime>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>
      se.sics.cooja.radiomediums.UDGM
      <transmitting_range>50.0</transmitting_range>
      <interference_range>100.0</interference_range>
      <success_ratio_tx>1.0</success_ratio_tx>
      <success_ratio_rx>1.0</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.mspmote.SkyMoteType
      <identifier>sky1</identifier>
      <description>Sky Mote Type #sky1</description>
      <source EXPORT="discard">[CONTIKI_DIR]/examples/rime/example-collect.c</source>
      <commands EXPORT="discard">make example-collect.sky TARGET=sky</commands>
      <firmware EXPORT="copy">[CONTIKI_DIR]/examples/rime/example-collect.sky</firmware>
      <moteinterface>se.sics.cooja.interfaces.Position</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.RimeAddress</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.IPAddress</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.Mote2MoteRelations</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.MoteAttributes</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspClock</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspMoteID</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyButton</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyFlash</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyCoffeeFilesystem</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyByteRadio</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspSerial</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyLED</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspDebugOutput</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyTemperature</moteinterface>
    </motetype>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>94.22648172913235</x>
        <y>98.03851431941663</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>1</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>26.11595724931124</x>
        <y>69.92666281860596</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>2</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>44.77856307896509</x>
        <y>25.436159064383002</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>3</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>68.0413466276236</x>
        <y>66.2586663520208</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>4</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>67.35985028576555</x>
        <y>55.46299548550158</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>5</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>12.959935724075766</x>
        <y>30.953208189882673</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>6</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>48.56464790165771</x>
        <y>41.873297462938474</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>7</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>63.77336149561575</x>
        <y>76.30904992683195</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>8</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>80.59997423627628</x>
        <y>86.93421959311249</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>9</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>40.123653340961475</x>
        <y>68.4578450318814</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>10</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>318</width>
    <z>4</z>
    <height>192</height>
    <location_x>0</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <skin>se.sics.cooja.plugins.skins.IDVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.TrafficVisualizerSkin</skin>
      <viewport>3.042726232958881 0.0 0.0 3.042726232958881 -18.069462100878987 -66.84981390545845</viewport>
    </plugin_config>
    <width>300</width>
    <z>5</z>
    <height>300</height>
    <location_x>968</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.LogListener
    <plugin_config>
      <filter />
    </plugin_config>
    <width>1268</width>
    <z>7</z>
    <height>150</height>
    <location_x>0</location_x>
    <location_y>498</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.TimeLine
    <plugin_config>
      <mote>0</mote>
      <mote>1</mote>
      <mote>2</mote>
      <mote>3</mote>
      <mote>4</mote>
      <mote>5</mote>
      <mote>6</mote>
      <mote>7</mote>
      <mote>8</mote>
      <mote>9</mote>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <split>125</split>
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>1268</width>
    <z>6</z>
    <height>150</height>
    <location_x>0</location_x>
    <location_y>648</location_y>
  </plugin>
  <plugin>
    de.fau.cooja.plugins.coojatrace.CoojaTracePlugin
    <plugin_config>
      <script>//val dest = LogFile("energy.trace", List("ontime", "mote", "type"))
val dest_stats = LogWindow("collect_stats", List("value", "mote", "var"))

val stats = List("foundroute", "newparent", "routelost", "acksent", 
  "datasent", "datarecv", "ackrecv", "badack", "duprecv", "qdrop", 
  "rtdrop", "ttldrop", "ackdrop", "timedout")
val statsAddr = 0x29ec // statt 0x2ba0
var size = 4 // bytes

def array2Int(arr: Array[Byte]):Int = arr.foldRight(0) { (byte, sum) =&gt; (sum &lt;&lt; 8) + byte }

for(mote &lt;- sim.allMotes) {
  for(s &lt;- stats) {
    var addr = statsAddr + stats.indexOf(s) * size
    log(dest_stats, mote.memory.variable(addr, CArray(size)).map(array2Int), mote, s)
  }
}

val dest_energy = LogWindow("collect-energy.log", List("energy", "mote"))

// constants for sky motes
val voltage = 3 // V
val receiveConsumption = 20.0 * voltage // mW
val transmitConsumption = 17.7 * voltage // mW
val activeConsumption = 1.800 * voltage // mW
val idleConsumption = 0.0545 * voltage // mW

for(mote &lt;- sim.allMotes) {
  val receiveTime = timeSum(mote.radio.receiverOn)
  val transmitTime = timeSum(mote.radio.transmitting)
  val activeTime = timeSum(mote.cpuMode === "active")
  val idleTime = timeSum(mote.cpuMode =!= "active")

  val energy: Signal[Double] = receiveTime / 1E6 * receiveConsumption + 
    transmitTime / 1E6 * transmitConsumption +
    activeTime / 1E6 * activeConsumption +
    idleTime / 1E6 * idleConsumption 

  log(dest_energy, energy, mote)
}</script>
      <active>true</active>
    </plugin_config>
    <width>809</width>
    <z>2</z>
    <height>824</height>
    <location_x>392</location_x>
    <location_y>63</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.ScriptRunner
    <plugin_config>
      <script>/*&#xD;
 * Example Contiki test script (JavaScript).&#xD;
 * A Contiki test script acts on mote output, such as via printf()'s.&#xD;
 * The script may operate on the following variables:&#xD;
 *  Mote mote, int id, String msg&#xD;
 */&#xD;
&#xD;
/* Make test automatically fail (timeout) after 100 simulated seconds */&#xD;
TIMEOUT(100000); /* milliseconds. no action at timeout */</script>
      <active>true</active>
    </plugin_config>
    <width>600</width>
    <z>3</z>
    <height>700</height>
    <location_x>1219</location_x>
    <location_y>131</location_y>
  </plugin>
</simconf>

