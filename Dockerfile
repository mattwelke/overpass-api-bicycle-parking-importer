FROM mongo:4.2.2

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
