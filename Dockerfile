# Stage 1: Use the Cypress included base image
FROM cypress/included:12.10.0 as cypress-stage

# Install NPM and required packages globally
RUN npm install -g npm@9.5.1 && \
    npm install -g junit-merge

# Stage 2: Use Alpine to install MinIO client and copy it over
FROM alpine:3.15

# Install MinIO client and any other tools needed from Alpine
RUN apk add --no-cache bash wget grep curl && \
    wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc

# Copy the MinIO client to the Cypress image
COPY --from=cypress-stage /usr/local/bin/mc /usr/local/bin/mc

# Switch back to the Cypress image
FROM cypress-stage

# Copy everything needed from the Alpine stage
COPY --from=alpine-stage /usr/local/bin/mc /usr/local/bin/mc
