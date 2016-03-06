FROM alpine:3.3
MAINTAINER Dan Norris <protochron@gmail.com>
WORKDIR /usr/app/tune

# Normally I'd remove the build tools from the image before moving on from this
# step, but then they're needed on every build and I'd rather just do it once
RUN apk --update add gcc musl-dev make ruby ruby-bundler \
  ruby-io-console ruby-irb && \
  rm -f /var/cache/apk/*
COPY . /usr/app/tune
RUN cd factoral && make
RUN cd sudoku && bundle install --without development
CMD sudoku/sudoku
