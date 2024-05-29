# Use an official Cypress image as a base
FROM cypress/included:12.10.0

# Install a compatible version of npm
RUN npm install -g npm@9.5.1

# Install junit-merge globally
RUN npm install -g junit-merge

# Install MinIO client and necessary tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends bash wget grep && \
    wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc && \
    rm -rf /var/lib/apt/lists/*
