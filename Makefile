SOURCE="https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb"
DESTINATION="build.deb"
OUTPUT="Slack.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)

	dpkg -x $(DESTINATION) build
	rm -rf AppDir/opt

	mkdir --parents AppDir/opt/application
	cp -r build/usr/lib/slack/* AppDir/opt/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/opt
	rm -rf build