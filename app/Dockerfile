# Node.js 18 LTS image from Docker Hub
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
