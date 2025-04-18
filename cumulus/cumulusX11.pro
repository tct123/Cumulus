################################################################################
# Cumulus Qt5/X11 project file for qmake
#
# Compatibility for Qt5 by Eggert Ehmke
#
# Copyright (c): 2008-2025 Axel Pauli
#
# This file is distributed under the terms of the General Public
# License. See the file COPYING for more information.
#
################################################################################

TEMPLATE = app

# Put all generated objects into an extra directory
OBJECTS_DIR = .obj
MOC_DIR     = .obj
RCC_DIR     = .obj

QT += core gui xml

# Qt5 needs the QtWidgets library
greaterThan(QT_MAJOR_VERSION, 4) {
QT += widgets multimedia
DEFINES += QT_5
}

GLIBC_VERSION = $$system( "ldd --version | grep GLIBC | awk '{print $NF}'" )
message( GLIBC_VERSION is set to ($$GLIBC_VERSION) )

lessThan(GLIBC_VERSION, 2.33) {
DEFINES += OLD_MALLOC
message( Setting OLD_MALLOC define because GLIB < 2.33 )
}

# Set DESKTOP as common define, if Cumulus is build for the LINUX desktop
DEFINES += CUM4DESKTOP

TARGET = cumulus

# CONFIG = qt warn_on release

CONFIG += qt \
          debug \
          warn_on

# The next lines shall force a compilation of the date stamp, the qrc and qm files.
rm_build_date.commands = rm -f $(OBJECTS_DIR)/BuildDate.o \
                         $(OBJECTS_DIR)/qrc_cumulus.* \
                         locale/de/cumulus_de.qm \
                         locale/de/qt_de.qm

# Note! translations must be built first because the are linked
# into the cumulus binary
# qmake hints to build the extra targets are to find here:
# http://stackoverflow.com/questions/35847243/adding-custom-target-in-qmake

translate_cumulus.target   = locale/de/cumulus_de.qm
translate_cumulus.depends  = locale/de/cumulus_de.ts
translate_cumulus.commands = lrelease -removeidentical -nounfinished locale/de/cumulus_de.ts

QT_DE = locale/de/qtbase_de.ts \
        locale/de/qtscript_de.ts \
        locale/de/qtmultimedia_de.ts \
        locale/de/qtxmlpatterns_de.ts

# VAR = foobar => Assign value to variable when qmake is run.
# $$VAR => QMake variable's value at the time qmake is run.
# $${VAR} => QMake variable's value at the time qmake is run (identical but
#            enclosed to separate from surrounding text)

translate_qt.target  = locale/de/qt_de.qm
translate_qt.depends = $$QT_DE
translate_qt.commands = lrelease -removeidentical -nounfinished $$QT_DE -qm locale/de/qt_de.qm

QMAKE_CLEAN += $$translate_cumulus.target $$translate_qt.target

QMAKE_EXTRA_TARGETS += rm_build_date translate_cumulus translate_qt

PRE_TARGETDEPS += rm_build_date locale/de/cumulus_de.qm locale/de/qt_de.qm

# Enable Flarm feature, if not wanted comment out the next line with a hash
CONFIG += flarm

# Enable Internet features, if not wanted comment out the next line with a hash
CONFIG += internet

# Enable bluetooth feature, if not wanted comment out the next line with a hash
CONFIG += Bluetooth

# Must be always enabled now otherwise you will get compile errors.
CONFIG += numberpad

#version check for Qt 5.x
! contains(QT_VERSION, ^5\\..*) {
  message("Cannot build Cumulus with Qt version $${QT_VERSION}.")
  error("Use at least Qt 5 only!")
}

RESOURCES = cumulus.qrc

CONFIG += resources

HEADERS = \
    aboutwidget.h \
    airfield.h \
    AirfieldListWidget.h \
    AirfieldSelectionList.h \
    airregion.h \
    airspace.h \
    AirspaceFilters.h \
    AirspaceHelper.h \
    AirspaceInfo.h \
    airspacewarningdistance.h \
    altimeterdialog.h \
    altitude.h \
    Atmosphere.h \
    authdialog.h \
    basemapelement.h \
    calculator.h \
    colordialog.h \
    CuLabel.h \
    datatypes.h \
    distance.h \
    elevationcolorimage.h \
    Frequency.h \
    filetools.h \
    flighttask.h \
    fontdialog.h \
    generalconfig.h \
    gliderflightdialog.h \
    glider.h \
    gliderlistwidget.h \
    GliderSelectionList.h \
    gpscon.h \
    gpsnmea.h \
    gpsstatusdialog.h \
    HelpBrowser.h \
    hwinfo.h \
    IgcLogger.h \
    interfaceelements.h \
    ipc.h \
    isohypse.h \
    isolist.h \
    KRT2.h \
    KRT2Constants.h \
    KRT2Widget.h \
    layout.h \
    limitedlist.h \
    lineelement.h \
    listviewfilter.h \
    ListViewTabs.h \
    listwidgetparent.h \
    logbook.h \
    MainWindow.h \
    mapcalc.h \
    mapconfig.h \
    mapcontents.h \
    mapdefaults.h \
    map.h \
    mapinfobox.h \
    mapmatrix.h \
    mapview.h \
    messagehandler.h \
    messagewidget.h \
    multilayout.h \
    OpenAip.h \
    OpenAipPoiLoader.h \
    OpenAipLoaderThread.h \
    openairparser.h \
    PointListView.h \
    polardialog.h \
    polar.h \
    preflightchecklistpage.h \
    preflightgliderpage.h \
    preflightlogbookspage.h \
    preflightmiscpage.h \
    preflightwaypointpage.h \
    preflightwidget.h \
    preflightwindpage.h \
    projectionbase.h \
    projectioncylindric.h \
    projectionlambert.h \
    protocol.h \
    radiopoint.h \
    RadioPointListWidget.h \
    reachablelist.h \
    reachablepoint.h \
    reachpointlistview.h \
    resource.h \
    rowdelegate.h \
    runway.h \
    SinglePointListWidget.h \
    SettingsPageAirspace.h \
    settingspageairspaceloading.h \
    settingspageglider.h \
    SettingsPageGPS.h \
    SettingsPageInformation.h \
    settingspagelines.h \
    settingspagelooknfeel.h \
    settingspagemapobjects.h \
    settingspagemapsettings.h \
    settingspagepersonal.h \
    SettingsPagePointData.h \
    SettingsPagePointDataLoading.h \
    settingspagetask.h \
    settingspageterraincolors.h \
    settingspageunits.h \
    SettingsPageWind.h \
    SettingsWidget.h \
    signalhandler.h \
    singlepoint.h \
    sonne.h \
    speed.h \
    splash.h \
    target.h \
    taskeditor.h \
    TaskFileManager.h \
    taskline.h \
    TaskListStatusView.h \
    TaskListView.h \
    taskpoint.h \
    taskpointeditor.h \
    TaskPointSelectionList.h \
    taskpointtypes.h \
    time_cu.h \
    ThermalPoint.h \
    tpinfowidget.h \
    Udp.h \
    vario.h \
    VarioModeDialog.h \
    varspinbox.h \
    vector.h \
    waitscreen.h \
    waypointcatalog.h \
    waypoint.h \
    waypointlistview.h \
    waypointlistwidget.h \
    wgspoint.h \
    whatsthat.h \
    WindAnalyser.h \
    WindCalcInStraightFlight.h \
    WindMeasurement.h \
    WindStore.h \
    wpeditdialog.h \
    wpeditdialogpageaero.h \
    wpeditdialogpagegeneral.h \
    wpinfowidget.h \
    XCSoar.h

SOURCES = \
    aboutwidget.cpp \
    airfield.cpp \
    AirfieldListWidget.cpp \
    AirfieldSelectionList.cpp \
    airregion.cpp \
    airspace.cpp \
    AirspaceFilters.cpp \
    AirspaceHelper.cpp \
    AirspaceInfo.cpp \
    altimeterdialog.cpp \
    altitude.cpp \
    authdialog.cpp \
    basemapelement.cpp \
    BuildDate.cpp \
    calculator.cpp \
    colordialog.cpp \
    CuLabel.cpp \
    distance.cpp \
    elevationcolorimage.cpp \
    filetools.cpp \
    flighttask.cpp \
    fontdialog.cpp \
    Frequency.cpp \
    generalconfig.cpp \
    glider.cpp \
    gliderflightdialog.cpp \
    gliderlistwidget.cpp \
    GliderSelectionList.cpp \
    gpscon.cpp \
    gpsnmea.cpp \
    gpsstatusdialog.cpp \
    HelpBrowser.cpp \
    hwinfo.cpp \
    IgcLogger.cpp \
    ipc.cpp \
    isohypse.cpp \
    isolist.cpp \
    KRT2.cpp \
    KRT2Widget.cpp \
    layout.cpp \
    lineelement.cpp \
    listviewfilter.cpp \
    ListViewTabs.cpp \
    listwidgetparent.cpp \
    logbook.cpp \
    main.cpp \
    MainWindow.cpp \
    mapcalc.cpp \
    mapconfig.cpp \
    mapcontents.cpp \
    map.cpp \
    mapinfobox.cpp \
    mapmatrix.cpp \
    mapview.cpp \
    messagehandler.cpp \
    messagewidget.cpp \
    OpenAip.cpp \
    OpenAipPoiLoader.cpp \
    OpenAipLoaderThread.cpp \
    openairparser.cpp \
    PointListView.cpp \
    polar.cpp \
    polardialog.cpp \
    preflightchecklistpage.cpp \
    preflightgliderpage.cpp \
    preflightlogbookspage.cpp \
    preflightmiscpage.cpp \
    preflightwaypointpage.cpp \
    preflightwidget.cpp \
    preflightwindpage.cpp \
    projectionbase.cpp \
    projectioncylindric.cpp \
    projectionlambert.cpp \
    radiopoint.cpp \
    RadioPointListWidget.cpp \
    reachablelist.cpp \
    reachablepoint.cpp \
    reachpointlistview.cpp \
    rowdelegate.cpp \
    runway.cpp \
    SinglePointListWidget.cpp \
    SettingsPageAirspace.cpp \
    settingspageairspaceloading.cpp \
    settingspageglider.cpp \
    SettingsPageGPS.cpp \
    SettingsPageInformation.cpp \
    settingspagelines.cpp \
    settingspagelooknfeel.cpp \
    settingspagemapobjects.cpp \
    settingspagemapsettings.cpp \
    settingspagepersonal.cpp \
    SettingsPagePointData.cpp \
    SettingsPagePointDataLoading.cpp \
    settingspagetask.cpp \
    settingspageterraincolors.cpp \
    settingspageunits.cpp \
    SettingsPageWind.cpp \
    SettingsWidget.cpp \
    signalhandler.cpp \
    singlepoint.cpp \
    sonne.cpp \
    speed.cpp \
    splash.cpp \
    taskeditor.cpp \
    TaskFileManager.cpp \
    taskline.cpp \
    TaskListStatusView.cpp \
    TaskListView.cpp \
    taskpoint.cpp \
    taskpointeditor.cpp \
    TaskPointSelectionList.cpp \
    time_cu.cpp \
    ThermalPoint.cpp \
    tpinfowidget.cpp \
    Udp.cpp \
    vario.cpp \
    VarioModeDialog.cpp \
    varspinbox.cpp \
    vector.cpp \
    waitscreen.cpp \
    waypointcatalog.cpp \
    waypoint.cpp \
    waypointlistview.cpp \
    waypointlistwidget.cpp \
    wgspoint.cpp \
    whatsthat.cpp \
    WindAnalyser.cpp \
    WindCalcInStraightFlight.cpp \
    WindStore.cpp \
    wpeditdialog.cpp \
    wpeditdialogpageaero.cpp \
    wpeditdialogpagegeneral.cpp \
    wpinfowidget.cpp \
    XCSoar.cpp
    
flarm {
    DEFINES += FLARM

		HEADERS += flarm.h \
		           flarmaliaslist.h \
		           flarmbase.h \
		           FlarmNet.h \
		           flarmdisplay.h \
		           flarmlistview.h \
		           flarmlogbook.h \
		           flarmradarview.h \
		           flarmwidget.h \
               preflightflarmpage.h \
               PreflightFlarmUsbPage.h \
               SettingsPageFlarm.h \
               SettingsPageFlarmNet.h

		SOURCES += flarm.cpp \
		           flarmaliaslist.cpp \
		           flarmbase.cpp \
		           FlarmNet.cpp \
		           flarmdisplay.cpp \
		           flarmlistview.cpp \
               flarmlogbook.cpp \
		           flarmradarview.cpp \
		           flarmwidget.cpp \
               preflightflarmpage.cpp \
               PreflightFlarmUsbPage.cpp \
               SettingsPageFlarm.cpp \
               SettingsPageFlarmNet.cpp
}

internet {
    QT += network

    DEFINES += INTERNET

    HEADERS += airspacedownloaddialog.h \
               DownloadManager.h \
               httpclient.h \
               LiveTrack24.h \
               LiveTrack24Logger.h \
               LiveTrackBase.h \
               preflightlivetrack24page.h \
               preflightweatherpage.h \
               proxydialog.h \
               skylines/byteOrder.h \
               skylines/compiler.h \
               skylines/crc.h \
               skylines/skyLinesTrackingProtocol.h \
               skylines/SkyLinesTracker.h
                              
		SOURCES += airspacedownloaddialog.cpp \
		           DownloadManager.cpp \
		           httpclient.cpp \
		           LiveTrack24.cpp \
		           LiveTrack24Logger.cpp \
		           preflightlivetrack24page.cpp \
               preflightweatherpage.cpp \
		           proxydialog.cpp \
		           skylines/crc.cpp \
		           skylines/SkyLinesTracker.cpp
}

Bluetooth {
    QT += bluetooth
    
    DEFINES += BLUEZ

    HEADERS += BluetoothServiceDiscovery.h \
               BluetoothDeviceDiscovery.h

    SOURCES += BluetoothServiceDiscovery.cpp \
               BluetoothDeviceDiscovery.cpp
}

numberpad {
    HEADERS += coordeditnumpad.h \
          		 doubleNumberEditor.h \
          		 glidereditornumpad.h \
               numberEditor.h \
               numberInputPad.h \
               PreflightTaskPage.h \
               settingspageairspacefillingnumpad.h \
               settingspageairspacewarningsnumpad.h

    SOURCES += coordeditnumpad.cpp \
    		       doubleNumberEditor.cpp \
    		       glidereditornumpad.cpp \
               numberEditor.cpp \
               numberInputPad.cpp \
               PreflightTaskPage.cpp \
               settingspageairspacefillingnumpad.cpp \
               settingspageairspacewarningsnumpad.cpp
}

DESTDIR = .

INCLUDEPATH += ../

QMAKE_CXXFLAGS += -fno-default-inline \
                  -fno-inline -Wextra \
                  -std=gnu++17

LIBS += -lstdc++

TRANSLATIONS = locale/de/cumulus_de.ts

CODECFORSRC = UTF-8
