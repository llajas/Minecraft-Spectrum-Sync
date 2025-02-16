# Use a lightweight base image
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache curl jq bash

# Copy the updater script
WORKDIR /app
COPY updater.sh /app/updater.sh
RUN chmod +x /app/updater.sh

# Define environment variables (these will be set in Kubernetes)
ENV API_TOKEN=""
ENV ZONE_ID=""
ENV CUSTOM_DOMAIN=""
ENV SPECTRUM_PORT="25565"

# Run the script in a loop
CMD ["/bin/bash", "/app/updater.sh"]

