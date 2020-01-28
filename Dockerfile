FROM mongo:4.2.3

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
