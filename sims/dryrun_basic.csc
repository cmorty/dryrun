<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/realsim</project>
  <simulation>
    <title>Hello World (RealSim)</title>
    <delaytime>0</delaytime>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>se.sics.cooja.radiomediums.DirectedGraphMedium</radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.mspmote.SkyMoteType
      <identifier>sky1</identifier>
      <description>Sky Mote Type #1</description>
      <source EXPORT="discard">[CONTIKI_DIR]/examples/hello-world/hello-world.c</source>
      <commands EXPORT="discard">make hello-world.sky TARGET=sky</commands>
      <firmware EXPORT="copy">[CONTIKI_DIR]/examples/hello-world/hello-world.sky</firmware>
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
  </simulation>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>248</width>
    <z>0</z>
    <height>200</height>
    <location_x>0</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.ScriptRunner
    <plugin_config>
      <script>TIMEOUT(70000, log.log("last message: " + msg + "\n"));

var motes = new Array(12306, 34640, 26005, 34851, 13075, 63270);

var failed = false;
	
	
while(motes.length){
	YIELD();
	if(msg.equals("Hello, world")){
		for(i = 0; i&lt; motes.length; i++){
			if(motes[i] == id){
				motes.splice(i,1);
				log.log("Found Mote " + id + "\n");
				break;
			} else if(i == motes.length -1){ 				
				log.log("Found unexpected Mote " + id + "\n");
				break;
			}
		}
		
	}
}

if(!failed){
	log.testOK();
} else {
	log.testFailed();
}</script>
      <active>true</active>
    </plugin_config>
    <width>757</width>
    <z>2</z>
    <height>861</height>
    <location_x>248</location_x>
    <location_y>-1</location_y>
  </plugin>
  <plugin>
    de.fau.cooja.plugins.realsim.RealSimFile
    <plugin_config>
      <SimEvent time="6000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>34640</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="6000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>12306</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="26000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>26005</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="31000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>34851</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="56000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>63270</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="56000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventAddNode
        <ID>13075</ID>
        <MoteType>sky1</MoteType>
      </SimEvent>
      <SimEvent time="56000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>12306</dst>
          <ratio>0.0</ratio>
          <rssi>71.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="61000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>70.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="68000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>12306</dst>
          <ratio>0.5</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="72000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>73.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="75000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>12306</dst>
          <ratio>0.9</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="76000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.9</ratio>
          <rssi>45.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="76000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="76000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.8</ratio>
          <rssi>52.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="76000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>81.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="78000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34851</dst>
          <ratio>0.0</ratio>
          <rssi>76.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="81000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>26005</dst>
          <ratio>0.0</ratio>
          <rssi>62.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="81000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>79.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="83000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>34851</dst>
          <ratio>1.0</ratio>
          <rssi>42.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="87000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>13075</dst>
          <ratio>0.9</ratio>
          <rssi>40.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="88000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>26005</dst>
          <ratio>0.9</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="90000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34851</dst>
          <ratio>0.9</ratio>
          <rssi>70.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="93000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>26005</dst>
          <ratio>1.1</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="94000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>13075</dst>
          <ratio>1.1</ratio>
          <rssi>82.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="96000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>39.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="99000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>26005</dst>
          <ratio>1.0</ratio>
          <rssi>78.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="100000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>13075</dst>
          <ratio>1.0</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="106000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>13075</dst>
          <ratio>0.8</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="106000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>26005</dst>
          <ratio>0.7</ratio>
          <rssi>54.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="150000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="150000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>50.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="150000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.5</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="150000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>44.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="150000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34640</dst>
          <ratio>0.2</ratio>
          <rssi>58.0</rssi>
          <delay>0</delay>
          <lqi>103</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="151000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>73.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="157000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>12306</dst>
          <ratio>0.7</ratio>
          <rssi>49.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="164000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>12306</dst>
          <ratio>1.2</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="169000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34851</dst>
          <ratio>0.4</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="169000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>78.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="176000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>12306</dst>
          <ratio>0.4</ratio>
          <rssi>76.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="176000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>34851</dst>
          <ratio>1.2</ratio>
          <rssi>43.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="182000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>26005</dst>
          <ratio>0.9</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="182000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>13075</dst>
          <ratio>1.2</ratio>
          <rssi>81.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="183000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34851</dst>
          <ratio>0.6</ratio>
          <rssi>72.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="187000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>26005</dst>
          <ratio>1.3</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="187000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>35.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="189000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>13075</dst>
          <ratio>0.5</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="193000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>26005</dst>
          <ratio>0.6</ratio>
          <rssi>78.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="193000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34851</dst>
          <ratio>0.9</ratio>
          <rssi>73.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="194000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>13075</dst>
          <ratio>0.9</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="200000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>26005</dst>
          <ratio>0.7</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="200000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>13075</dst>
          <ratio>0.9</ratio>
          <rssi>33.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="205000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>26005</dst>
          <ratio>0.9</ratio>
          <rssi>61.0</rssi>
          <delay>0</delay>
          <lqi>102</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="206000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>13075</dst>
          <ratio>0.9</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="211000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>63270</dst>
          <ratio>1.1</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="212000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.3</ratio>
          <rssi>52.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="212000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.3</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="212000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.4</ratio>
          <rssi>45.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="212000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>49.0</rssi>
          <delay>0</delay>
          <lqi>103</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="212000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.4</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="218000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>63270</dst>
          <ratio>0.6</ratio>
          <rssi>44.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="224000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>63270</dst>
          <ratio>0.8</ratio>
          <rssi>57.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="230000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>63270</dst>
          <ratio>0.9</ratio>
          <rssi>77.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="236000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>63270</dst>
          <ratio>0.8</ratio>
          <rssi>72.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="258000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="264000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>12306</dst>
          <ratio>1.2</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="267000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>34851</dst>
          <ratio>1.1</ratio>
          <rssi>44.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="268000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="268000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>45.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="268000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34640</dst>
          <ratio>0.4</ratio>
          <rssi>50.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="268000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.5</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="268000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="271000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>79.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="274000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34851</dst>
          <ratio>0.9</ratio>
          <rssi>72.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="278000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>12306</dst>
          <ratio>1.0</ratio>
          <rssi>75.0</rssi>
          <delay>0</delay>
          <lqi>103</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="279000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34851</dst>
          <ratio>0.8</ratio>
          <rssi>34.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="281000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>13075</dst>
          <ratio>0.8</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="281000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>26005</dst>
          <ratio>1.1</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="284000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="286000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>73.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="286000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>13075</dst>
          <ratio>0.7</ratio>
          <rssi>51.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="287000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>26005</dst>
          <ratio>0.7</ratio>
          <rssi>79.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="291000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>13075</dst>
          <ratio>0.7</ratio>
          <rssi>31.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="292000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34851</dst>
          <ratio>0.9</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="293000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>26005</dst>
          <ratio>0.8</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="297000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>13075</dst>
          <ratio>0.8</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="300000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>26005</dst>
          <ratio>0.8</ratio>
          <rssi>61.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="303000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>13075</dst>
          <ratio>1.2</ratio>
          <rssi>82.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="306000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>26005</dst>
          <ratio>0.8</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="311000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>63270</dst>
          <ratio>0.8</ratio>
          <rssi>43.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="317000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>63270</dst>
          <ratio>0.7</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="323000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>63270</dst>
          <ratio>0.7</ratio>
          <rssi>78.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="330000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>63270</dst>
          <ratio>0.6</ratio>
          <rssi>72.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="335000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>63270</dst>
          <ratio>1.3</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="336000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.5</ratio>
          <rssi>43.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="336000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34640</dst>
          <ratio>0.5</ratio>
          <rssi>50.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="336000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>51.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="336000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.3</ratio>
          <rssi>51.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="336000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>81.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="359000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>12306</dst>
          <ratio>1.1</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="365000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>12306</dst>
          <ratio>0.7</ratio>
          <rssi>79.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="367000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>72.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="372000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>75.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="373000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34851</dst>
          <ratio>0.9</ratio>
          <rssi>34.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="376000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>13075</dst>
          <ratio>0.8</ratio>
          <rssi>52.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="378000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>12306</dst>
          <ratio>0.8</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="379000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34851</dst>
          <ratio>0.8</ratio>
          <rssi>73.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="383000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>13075</dst>
          <ratio>0.8</ratio>
          <rssi>31.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="384000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>12306</dst>
          <ratio>0.9</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="385000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34851</dst>
          <ratio>0.7</ratio>
          <rssi>80.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="386000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>26005</dst>
          <ratio>0.7</ratio>
          <rssi>79.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="389000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>13075</dst>
          <ratio>0.6</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="390000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>34851</dst>
          <ratio>1.1</ratio>
          <rssi>44.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="393000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>26005</dst>
          <ratio>0.9</ratio>
          <rssi>53.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="394000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>13075</dst>
          <ratio>1.0</ratio>
          <rssi>81.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="399000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>13075</dst>
          <ratio>0.6</ratio>
          <rssi>47.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="400000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>26005</dst>
          <ratio>0.8</ratio>
          <rssi>61.0</rssi>
          <delay>0</delay>
          <lqi>104</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>63270</src>
          <dst>34640</dst>
          <ratio>0.7</ratio>
          <rssi>49.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>12306</src>
          <dst>34640</dst>
          <ratio>0.2</ratio>
          <rssi>52.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>34640</dst>
          <ratio>0.6</ratio>
          <rssi>52.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>13075</src>
          <dst>34640</dst>
          <ratio>0.5</ratio>
          <rssi>81.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>34640</dst>
          <ratio>0.4</ratio>
          <rssi>48.0</rssi>
          <delay>0</delay>
          <lqi>103</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="406000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34851</src>
          <dst>26005</dst>
          <ratio>0.8</ratio>
          <rssi>74.0</rssi>
          <delay>0</delay>
          <lqi>107</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="412000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>34640</src>
          <dst>26005</dst>
          <ratio>1.3</ratio>
          <rssi>55.0</rssi>
          <delay>0</delay>
          <lqi>106</lqi>
        </RSE>
      </SimEvent>
      <SimEvent time="414000">
        de.fau.cooja.plugins.realsim.RealSimFile$SimEventSetEdge
        <RSE>
          <src>26005</src>
          <dst>63270</dst>
          <ratio>0.8</ratio>
          <rssi>54.0</rssi>
          <delay>0</delay>
          <lqi>105</lqi>
        </RSE>
      </SimEvent>
    </plugin_config>
    <width>180</width>
    <z>3</z>
    <height>190</height>
    <location_x>30</location_x>
    <location_y>239</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <viewport>20.870893685447378 0.0 0.0 20.870893685447378 43.2412394262631 -76.54672971103739</viewport>
    </plugin_config>
    <width>300</width>
    <z>1</z>
    <height>300</height>
    <location_x>958</location_x>
    <location_y>49</location_y>
  </plugin>
</simconf>

