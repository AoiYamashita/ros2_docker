
#------------ base imagefile
#============ nvidia , can use gpu
#FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

#------------ setup enviroment
#ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
#ENV __NV_PRIME_RENDER_OFFLOAD=1
#ENV __GLX_VENDOR_LIBRARY_NAME=nvidia

#============ normal ubuntu
FROM ubuntu:22.04

#------------ set time zone
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

# ----------- set work dir
WORKDIR /root

#------------ set enviroment of Ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip

#------------ ros2 can't use pip over 58.2.0
RUN pip install setuptools==58.2.0

#------------ install x11-apps for Xserver on windows
RUN apt-get install x11-apps -y

#------------ install git
RUN apt-get install git -y

#------------ use fot GUI such as matplotlib
RUN apt-get install python3-tk -y

#------------ install library for PyTorch
#RUN pip3 install torch torchvision

#------------ setup ROS2
COPY ./src/setup.sh /root/
RUN bash ~/setup.sh
