# kuki-docker
Containarized Kuki.tv app

On Fedora run:
```
sudo dnf -y install git docker
sudo sed -i '!load-module module-native-protocol-unix$!load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket!' /etc/pulse.default.pa
pulseaudio -k
git clone https://github.com/ljozsa/kuki-docker.git
mkdir /tmp/pacat
cd kuki-docker
sudo docker build -t kuki .
sudo docker run --user=$(id -u):$(id -g) -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/dri --privileged -v /tmp/pacat:/home/pacat -it kuki bash
```
