FROM postgres:latest
LABEL maintainer="s172071@student.pg.edu.pl"
COPY db.sql /docker-entrypoint-initdb.d/
EXPOSE 5433
CMD ["postgres"]