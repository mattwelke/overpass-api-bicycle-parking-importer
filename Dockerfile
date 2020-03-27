FROM mongo:4.2.5

COPY program.sh data_transformed.json /

CMD [ "bash", "/program.sh" ]
