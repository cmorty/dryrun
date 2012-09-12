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
    <radiomedium>se.sics.cooja.radiomediums.DirectedGraphMedium</radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.mspmote.SkyMoteType
      <identifier>sky1</identifier>
      <description>Sky Mote Type #sky1</description>
      <firmware EXPORT="copy">[CONTIKI_DIR]/examples/hello-world/hello-world.sky</firmware>
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
  </simulation>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>290</width>
    <z>5</z>
    <height>192</height>
    <location_x>0</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <viewport>1.0 0.0 0.0 1.0 0.0 0.0</viewport>
    </plugin_config>
    <width>300</width>
    <z>4</z>
    <height>300</height>
    <location_x>390</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.LogListener
    <plugin_config>
      <filter />
    </plugin_config>
    <width>690</width>
    <z>3</z>
    <height>150</height>
    <location_x>0</location_x>
    <location_y>347</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.TimeLine
    <plugin_config>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <split>118</split>
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>690</width>
    <z>2</z>
    <height>150</height>
    <location_x>0</location_x>
    <location_y>497</location_y>
  </plugin>
  <plugin>
    de.fau.cooja.plugins.realsim.RealSimLive
    <width>180</width>
    <z>1</z>
    <height>190</height>
    <location_x>23</location_x>
    <location_y>201</location_y>
  </plugin>
  <plugin>
    de.fau.cooja.plugins.springlayout.SpringLayout
    <width>520</width>
    <z>0</z>
    <height>320</height>
    <location_x>239</location_x>
    <location_y>155</location_y>
  </plugin>
</simconf>

