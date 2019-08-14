FROM mongo:4.2.0

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
