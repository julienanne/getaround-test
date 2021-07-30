FROM ruby

RUN apt update && apt install -y \
  inotify-tools \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/ruby

COPY ./entrypoint.sh /usr/src

CMD ["../entrypoint.sh"]
