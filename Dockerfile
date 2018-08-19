FROM mongo:4.0

COPY program.sh /
COPY data_transformed.json /

CMD [ "bash", "/program.sh" ]
