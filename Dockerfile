FROM golang:1.12.5-alpine as build-step
RUN apk add --update --no-cache ca-certificates git

WORKDIR /go/src/lecture-app
ENV GO111MODULE=on

COPY go.mod .
COPY go.sum .

RUN go mod download
COPY . .

RUN CGO_ENABLED=0 go build -o /go/bin/lecture-app

FROM scratch
COPY --from=build-step /go/bin/lecture-app /go/bin/lecture-app

ENTRYPOINT [ "/go/bin/lecture-app" ]
