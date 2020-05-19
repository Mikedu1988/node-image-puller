FROM alpine
COPY imagelist /opt/app/imagelist
COPY skopeo-run.sh /opt/app/skopeo-run.sh
RUN apk update && apk add bash && apk add skopeo && chmod u+x /opt/app/skopeo-run.sh
WORKDIR /opt/app
CMD ["./skopeo-run.sh"]