# kuki-docker
Containarized Kuki.tv app

On Fedora run:
```
mkdir pacat
sudo dnf -y install git docker
git clone https://github.com/ljozsa/kuki-docker.git
cd kuki-docker
sudo docker build -t kuki .
sudo docker run --user=$(id -u):$(id -g) -v /tmp/.X11-unix:/tmp/.X11-unix -v /run/user/$(id -u)/pulse:/run/user/1000/pulse -v ~/pacat:/home/pacat --device /dev/dri --privileged -it kuki kuki
```
