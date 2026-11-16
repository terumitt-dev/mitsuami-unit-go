FROM golang:1.27-bookworm AS build

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o /unit .

FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=build /unit /unit

EXPOSE 8080
ENTRYPOINT ["/unit"]
