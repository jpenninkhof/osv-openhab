VERSION:=1.7.1
NAME:=openhab
TARBALL:=$(DIR).tgz
TARBALL_RUNTIME:=distribution-$(VERSION)-runtime.zip
TARBALL_ADDONS:=distribution-$(VERSION)-addons.zip
TARBALL_GREENT:=distribution-$(VERSION)-greent.zip
URL_RUNTIME:=http://bintray.com/artifact/download/openhab/bin/$(TARBALL_RUNTIME)
URL_ADDONS:=http://bintray.com/artifact/download/openhab/bin/$(TARBALL_ADDONS)
URL_GREENT:=http://bintray.com/artifact/download/openhab/bin/$(TARBALL_GREENT)

module: ROOTFS usr.manifest

$(TARBALL_RUNTIME):
	wget $(URL_RUNTIME)

$(TARBALL_ADDONS):
	wget $(URL_ADDONS)

$(TARBALL_GREENT):
	wget $(URL_GREENT)

ROOTFS/$(NAME): $(TARBALL_RUNTIME) $(TARBALL_ADDONS) $(TARBALL_GREENT)
	unzip -od ROOTFS $(TARBALL_RUNTIME) && rm $(TARBALL_RUNTIME)
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.action.xmpp-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.asterisk-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.http-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.persistence.rrd4j-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.exec-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.networkhealth-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.mqtt-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.persistence.mqtt-*
	unzip -od ROOTFS/addons $(TARBALL_ADDONS) org.openhab.binding.mqttitude-*
	rm $(TARBALL_ADDONS)
	unzip -od ROOTFS/webapps $(TARBALL_GREENT) greent/* && rm $(TARBALL_GREENT)

usr.manifest:
	echo "/**: \$${MODULE_DIR}/ROOTFS/**" > usr.manifest

clean:
	rm -rf ROOTFS
	rm -f usr.manifest $(TARBALL_RUNTIME) $(TARBALL_ADDONS) $(TARBALL_GREENT)

ROOTFS: ROOTFS/$(NAME)
