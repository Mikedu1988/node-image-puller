FROM alpine
COPY imagelist /opt/app/imagelist
COPY skopeo-run.sh /opt/app/skopeo-run.sh
RUN apk update && apk add curl && apk add bash && apk add skopeo && chmod u+x /opt/app/skopeo-run.sh
ENV CONFIG_URL=https://raw.githubusercontent.com/Mikedu1988/node-image-puller/master/config/imagelist
WORKDIR /opt/app
CMD ["./skopeo-run.sh"]