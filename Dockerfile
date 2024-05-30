# Stage 1: Alpine based stage to install MinIO Client
FROM alpine:latest as minio-installer

# Install wget and ca-certificates for HTTPS connections
RUN apk --no-cache add wget ca-certificates

# Download and install MinIO Client
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc

# Stage 2: Cypress base image with MinIO Client copied over
FROM cypress/included:12.10.0

# Copy MinIO Client from the Alpine stage
COPY --from=minio-installer /usr/local/bin/mc /usr/local/bin/mc
