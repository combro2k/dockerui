FROM debian:jessie

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    mercurial \
    git-core

RUN curl -s https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | tar -v -C /usr/local -xza

ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/go/bin

RUN go get github.com/abbot/go-http-auth

ADD ./dockerui /app/
WORKDIR /app/
RUN go build dockerui.go
EXPOSE 9000
CMD ["./dockerui"]
