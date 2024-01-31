
FROM ubuntu:22.04

#------------ set time zone
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

# ----------- set work dir
WORKDIR /root

#------------ set enviroment of Ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip

#------------ install x11-apps for Xserver on windows
RUN apt-get install x11-apps -y

#------------ install git
RUN apt-get install git -y

#------------ use fot GUI such as matplotlib
RUN apt-get install python3-tk -y

#------------ install library for PyTorch
#RUN pip3 install torch torchvision

#------------ setup ROS2
COPY src/setup.sh /root/
RUN bash ~/setup.sh