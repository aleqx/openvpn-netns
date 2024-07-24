install:
	cp systemd/openvpn-netns-client@.service /etc/systemd/system/openvpn-netns-client@.service
	cp openvpn-netns /usr/local/bin/openvpn-netns
	cp openvpn-netns-shell /usr/local/bin/openvpn-netns-shell
	cp openvpn-netns-service /usr/local/bin/openvpn-netns-service
	cp -r openvpn-scripts /usr/local/bin/

uninstall:
	rm /etc/systemd/system/openvpn-netns-client@.service
	rm /usr/local/bin/openvpn-netns
	rm /usr/local/bin/openvpn-netns-shell
	rm /usr/local/bin/openvpn-netns-service
	rm -r /usr/local/bin/openvpn-scripts
