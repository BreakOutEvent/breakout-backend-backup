FROM ubuntu:17.10
RUN apt-get update && apt-get install mariadb-client bash zip curl watch -y
COPY . .
RUN chmod +x backup.sh
ENV TERM xterm
CMD ["watch", "-n", "3600", "bash /backup.sh"]
