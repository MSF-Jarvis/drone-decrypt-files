FROM alpine:latest

LABEL maintainer "Harsh Shandilya <msfjarvis@gmail.com>"

COPY decrypt.sh /bin/decrypt

RUN chmod +x /bin/decrypt

RUN apk --no-cache add \
    bash \
    openssl

ENTRYPOINT [ "/bin/decrypt" ]
