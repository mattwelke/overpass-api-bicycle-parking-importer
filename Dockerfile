FROM mongo:4.0

COPY program.sh /
COPY data.json /

CMD [ "bash", "/program.sh" ]
