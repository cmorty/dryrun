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
  <simulation>
    <title>My simulation</title>
    <delaytime>0</delaytime>
    <randomseed>123</randomseed>
    <motedelay_us>10000000</motedelay_us>
    <radiomedium>
      se.sics.cooja.radiomediums.UDGM
      <transmitting_range>30.0</transmitting_range>
      <interference_range>40.0</interference_range>
      <success_ratio_tx>0.9</success_ratio_tx>
      <success_ratio_rx>0.9</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.mspmote.SkyMoteType
      <identifier>sky1</identifier>
      <description>Sky Mote Type #1</description>
      <source EXPORT="discard">[CONTIKI_DIR]/examples/rime/example-collect.c</source>
      <commands EXPORT="discard">make example-collect.sky TARGET=sky</commands>
      <firmware EXPORT="copy">[CONTIKI_DIR]/examples/rime/example-collect.sky</firmware>
      <moteinterface>se.sics.cooja.interfaces.Position</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.IPAddress</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.Mote2MoteRelations</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspClock</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspMoteID</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyButton</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyFlash</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyByteRadio</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.MspSerial</moteinterface>
      <moteinterface>se.sics.cooja.mspmote.interfaces.SkyLED</moteinterface>
    </motetype>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>87.29845932913939</x>
        <y>60.286214311723164</y>
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
        <x>94.30809966340686</x>
        <y>22.50388779326399</y>
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
        <x>82.40423567500785</x>
        <y>39.56979106929553</y>
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
        <x>26.185019854469438</x>
        <y>4.800834369523899</y>
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
        <x>1.9530156130507015</x>
        <y>78.3175061800706</y>
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
        <x>48.35216700543414</x>
        <y>80.36988713780997</y>
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
        <x>24.825985087266833</x>
        <y>74.27809432062487</y>
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
        <x>8.356165164293616</x>
        <y>94.33967355724187</y>
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
        <x>45.11740613004886</x>
        <y>31.7059041432301</y>
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
        <x>61.07384434103698</x>
        <y>54.19958159095452</y>
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
        <x>13.181122543889046</x>
        <y>55.9636533130127</y>
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
        <x>2.1749985906538427</x>
        <y>78.39666095789707</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>12</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>37.79795217518357</x>
        <y>7.164284163506062</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>13</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>64.4595177394984</x>
        <y>72.115414337433</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>14</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>81.85663737096085</x>
        <y>89.31412706434035</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>15</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>44.74952276297882</x>
        <y>18.78566116347574</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>16</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>96.11333426285873</x>
        <y>90.64560410751824</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>17</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>21.651464136783527</x>
        <y>7.1381043251259495</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>18</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>83.6006916200628</x>
        <y>26.97170140682981</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>19</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>1.3446070721664705</x>
        <y>7.340373220385176</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.mspmote.interfaces.MspMoteID
        <id>20</id>
      </interface_config>
      <motetype_identifier>sky1</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>265</width>
    <z>3</z>
    <height>200</height>
    <location_x>60</location_x>
    <location_y>60</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <skin>se.sics.cooja.plugins.skins.IDVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.UDGMVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.TrafficVisualizerSkin</skin>
      <viewport>5.832380460434832 0.0 0.0 5.832380460434832 19.79410362169742 4.887419365173396</viewport>
    </plugin_config>
    <width>946</width>
    <z>2</z>
    <height>890</height>
    <location_x>0</location_x>
    <location_y>200</location_y>
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


val members = List("foundroute", "newparent", "routelost", "acksent", 
 "datasent", "datarecv", "ackrecv", "badack", "duprecv", "qdrop", 
 "rtdrop", "ttldrop", "ackdrop", "timedout")
var size = 4 // bytes

def array2Int(arr: Array[Byte]):Int = arr.foldRight(0) { (byte, sum) =&gt; (sum &lt;&lt; 8) + (byte &amp; 0xFF) }

for(mote &lt;- sim.allMotes) {
  val stats = mote.memory.variable("stats", CArray(size))
  for(s &lt;- members) {
    var index = members.indexOf(s)
    log(dest_stats, 0, mote, s, *(&amp;(stats) + index).map(array2Int))
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
    <width>809</width>
    <z>1</z>
    <height>824</height>
    <location_x>790</location_x>
    <location_y>13</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.ScriptRunner
    <plugin_config>
      <script>TIMEOUT(6000000);

num_nodes = mote.getSimulation().getMotesCount();

function print_stats() {
  log.log("Received:\n");
  for(i = 1; i &lt;= num_nodes; i++) {

      log.log("Node " + i + " ");
      if(i == sink) {
          log.log("sink\n");
      } else {
          log.log("received: " + received[i] + " hops: " + hops[i] + "\n");
      }
  }
}

/* Init */
sink = 0;
hops = new Array();
dups = new Array();
received = new Array();

doubleFormat = new java.text.DecimalFormat("0.00");
integerFormat = new java.text.DecimalFormat("00");
for(i = 1; i &lt;= num_nodes; i++) {
    received[i] = "";
    hops[i] = received[i];
}

log.log("Simulation has " + num_nodes + " nodes\n");

while(true) {
    YIELD();
    log.log(time + " " + id + " "+ msg + "\n");
    /* Count sensor data packets */
    if(msg.startsWith("Sink got message")) {
        node_text = msg.split(" ")[4];
        seqno_text = msg.split(" ")[6];
        hops_text = msg.split(" ")[8];
        if(node_text) {
            source = parseInt(node_text);
            seqno = parseInt(seqno_text);
            hop = parseInt(hops_text);
            dups = received[source].substr(seqno, 1);
            if(dups == "_") {
                dups = 1;
            } else if(dups &lt; 9) {
                dups++;
            }
			while(received[source].length &lt;= seqno){
				received[source] += "_";
			}
            received[source] = received[source].substr(0, seqno) + dups +
                received[source].substr(seqno + 1);

            if(hop &gt; 9) {
                hop = "+";
            }
			while(hops[source].length &lt;= seqno){
				hops[source] += "_";
			}

            hops[source] = hops[source].substr(0, seqno) + hop +
                hops[source].substr(seqno + 1);
            print_stats();
        }
    }
    /* Signal OK if all nodes have reported 10 messages. */
    num_reported = 0;
    for(i = 1; i &lt;= num_nodes; i++) {
		tmp=received[i].replace(/_/g, "");
        if(tmp.length &gt;= 100) { //Received 10
            num_reported++;
		}
    }


    if(num_reported == num_nodes){
        print_stats();
		for(i = 1; i &lt;= num_nodes; i++) {
		    if(!isNaN(received[i])) {
				log.log("Lost packets");
				log.testFailed();
		    }
		}
        log.testOK();
    }
}</script>
      <active>false</active>
    </plugin_config>
    <width>1132</width>
    <z>0</z>
    <height>782</height>
    <location_x>266</location_x>
    <location_y>0</location_y>
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
      <showRadioRXTX />
      <split>109</split>
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>1082</width>
    <z>5</z>
    <height>579</height>
    <location_x>33</location_x>
    <location_y>462</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.LogListener
    <plugin_config>
      <filter />
    </plugin_config>
    <width>1920</width>
    <z>4</z>
    <height>821</height>
    <location_x>60</location_x>
    <location_y>152</location_y>
  </plugin>
</simconf>

