FROM kraiz/icecold

RUN apt-get update && apt-get install -y --no-install-recommends \
    uhub \ 
    python-pip \
    python-twisted

RUN pip install https://github.com/kraiz/nusbot/archive/master.zip

RUN echo '\n\
hub: /usr/bin/uhub -v\n\
bot: /usr/bin/twistd -n --pidfile= nusbot'\
>> /Procfile

CMD ["/bin/forego", "start", "-r"]
