FROM mongo:4.4.1

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
