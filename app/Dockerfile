# Use official Node.js 18 LTS image from Docker Hub
# This is a public image: https://hub.docker.com/_/node
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application code
COPY server.js ./

# Expose port 3000
EXPOSE 3000

# Define environment variable with default
ENV PORT=3000

# Run the application
CMD ["node", "server.js"]
#```

#**What this Dockerfile does**:
#- `FROM node:18-alpine`: Uses the official lightweight Node.js 18 image (alpine variant is smaller)
#- `WORKDIR`: Sets the working directory
#- `COPY package*.json`: Copies package files first (Docker layer caching optimization)
#- `RUN npm install`: Installs dependencies
#- `COPY server.js`: Copies application code
#- `EXPOSE 3000`: Documents which port the container listens on
#- `CMD`: Command to run when container starts

#**Public Dockerfile source**: The `node:18-alpine` image Dockerfile can be viewed at https://github.com/nodejs/docker-node

#**Create `app/.dockerignore`:**
#```
#node_modules
#npm-debug.log
#.git
#.gitignore
#README.md
#.env