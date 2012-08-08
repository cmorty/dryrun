<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/realsim</project>
  <project EXPORT="discard">[APPS_DIR]/trace</project>
  <project EXPORT="discard">[APPS_DIR]/trace-sqlite</project>
  <project EXPORT="discard">[APPS_DIR]/trace-plot</project>
  <simulation>
    <title>My simulation</title>
    <delaytime>0</delaytime>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>
      se.sics.cooja.radiomediums.UDGM
      <transmitting_range>25.0</transmitting_range>
      <interference_range>30.0</interference_range>
      <success_ratio_tx>0.95</success_ratio_tx>
      <success_ratio_rx>0.7</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.mspmote.SkyMoteType
      <identifier>sky1</identifier>
      <description>Sky Mote Type #sky1</description>
      <source EXPORT="discard">[CONTIKI_DIR]/scan-neighbors.c</source>
      <commands EXPORT="discard">make scan-neighbors.sky TARGET=sky</commands>
      <firmware EXPORT="copy">[CONTIKI_DIR]/scan-neighbors.sky</firmware>
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
        <x>72.8218530025879</x>
        <y>44.47135447453199</y>
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
        <x>41.916207115541084</x>
        <y>57.52314118380276</y>
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
        <x>58.061409419728236</x>
        <y>24.472064642309512</y>
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
        <x>67.15787009101757</x>
        <y>59.12383200663785</y>
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
        <x>42.89289774094441</x>
        <y>19.45082845045818</y>
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
        <x>20.044213071810802</x>
        <y>45.427771302531916</y>
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
        <x>48.4174503349425</x>
        <y>24.536697893666968</y>
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
        <x>78.29417948367531</x>
        <y>6.864940050020907</y>
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
        <x>38.96108559646091</x>
        <y>71.06744814625354</y>
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
        <x>41.669946988951075</x>
        <y>38.684241499666655</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>10</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>76.94386302729318</x>
        <y>1.8459652902240498</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>11</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>66.58964900475041</x>
        <y>20.548551611928</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>12</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>290</width>
    <z>3</z>
    <height>192</height>
    <location_x>0</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <skin>se.sics.cooja.plugins.skins.UDGMVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.IDVisualizerSkin</skin>
      <viewport>9.915471441014514 0.0 0.0 9.915471441014514 -136.65897056795075 15.514565701861276</viewport>
    </plugin_config>
    <width>805</width>
    <z>1</z>
    <height>812</height>
    <location_x>815</location_x>
    <location_y>104</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.LogListener
    <plugin_config>
      <filter />
    </plugin_config>
    <width>690</width>
    <z>5</z>
    <height>150</height>
    <location_x>0</location_x>
    <location_y>347</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.MoteInterfaceViewer
    <mote_arg>0</mote_arg>
    <plugin_config>
      <interface>Serial port</interface>
      <scrollpos>0,0</scrollpos>
    </plugin_config>
    <width>350</width>
    <z>4</z>
    <height>300</height>
    <location_x>311</location_x>
    <location_y>14</location_y>
  </plugin>
  <plugin>
    de.fau.cooja.plugins.coojatrace.CoojaTracePlugin
    <plugin_config>
      <script>//val dest = LogFile("energy.trace", List("ontime", "mote", "type"))
//val dest_stats = LogWindow("collect_stats", List("value", "mote", "var"))


val db = sqlitelog.SQLiteDB("collect.db")
val db2 = sqlitelog.SQLiteDB("energy.db")

val dest_stats = sqlitelog.LogTable(db, "variables"  , List( "DUMP", "Mote", "Var", "Data"), timeColumn = "Time")
val dest_stats2 = sqlitelog.LogTable(db2, "variables"  , List( "DUMP", "Mote", "Var", "Data"), timeColumn = "Time")
val Freq = 1000


val members = List("resend","loss")
var size = 4 // bytes

def array2Int(arr: Array[Byte]):Int = arr.foldRight(0) { (byte, sum) =&gt; (sum &lt;&lt; 8) + (byte &amp; 0xFF) }

for(mote &lt;- sim.allMotes) {
  val scan_stats = mote.memory.variable("scan_stats", CArray(size))
  for(s &lt;- members) {
    var index = members.indexOf(s)
    log(dest_stats, 0, mote, s, *(&amp;(scan_stats) + index).map(array2Int))
  }
}

//val dest_energy = LogWindow("collect-energy.log", List("energy", "mote"))



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


  log(dest_stats2, sim.milliSeconds.change.filter(_ % Freq == 0) ,  mote, "energy", energy)
}</script>
      <active>false</active>
    </plugin_config>
    <width>837</width>
    <z>2</z>
    <height>933</height>
    <location_x>930</location_x>
    <location_y>56</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.ScriptRunner
    <plugin_config>
      <script>TIMEOUT(810000000, log.testOK()); /* Don't use Timeout! */

WAIT_UNTIL(sim.getSimulationTimeMillis() &gt;= 1200000);/* Simulate 20 min */
log.testOK()</script>
      <active>false</active>
    </plugin_config>
    <width>600</width>
    <z>0</z>
    <height>700</height>
    <location_x>381</location_x>
    <location_y>174</location_y>
  </plugin>
</simconf>

