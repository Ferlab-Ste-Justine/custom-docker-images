# Stage 1: Use Alpine to install MinIO client
FROM alpine:3.15 as alpine-stage

# Install MinIO client and any other tools needed from Alpine
RUN apk add --no-cache bash wget grep curl && \
    wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

# Stage 2: Use the Cypress included base image
FROM cypress/included:12.10.0

# Copy MinIO client from Alpine stage to the final image
COPY --from=alpine-stage /usr/local/bin/mc /usr/local/bin/mc

# Install NPM and required packages globally
RUN npm install -g npm@9.5.1 && \
    npm install -g junit-merge
