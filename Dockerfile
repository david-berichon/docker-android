FROM dbndev/openjdk-base

ADD https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz /opt/android-sdk.tgz

RUN cd /opt \
 && tar -xzf android-sdk.tgz \
 && ( while [ 1 ]; do sleep 5; echo y; done ) | /opt/android-sdk-linux/tools/android update sdk --no-ui \ 
 && rm android-sdk.tgz

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

ADD https://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip /opt/android-ndk-r12b.zip

RUN apt-get update && apt-get install -y unzip \
 && cd /opt \
 && unzip android-ndk-r12b.zip && rm /opt/android-ndk-r12b.zip \
 && apt-get remove --purge -y unzip \
 && apt-get autoremove -y \
 && apt-get clean

ENV PATH $PATH:/opt/android-ndk-r12b
