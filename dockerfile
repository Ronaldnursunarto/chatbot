# Use an official Node.js image
FROM node:20

# Set working directory in the container
WORKDIR /app

# Copy everything from your project into the container
COPY . .

# Install dependencies, but skip devDependencies
RUN npm install --omit=dev

# Generate Prisma Client
RUN npx prisma generate

# Make the start script executable
RUN chmod +x ./start.sh

# Expose default port (optional – for clarity only)
EXPOSE 3000

# Start the app with your custom script
CMD ["./start.sh"]
