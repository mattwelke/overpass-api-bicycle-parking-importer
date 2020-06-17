FROM mongo:4.2.8

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
