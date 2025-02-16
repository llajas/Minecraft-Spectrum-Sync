#!/bin/bash

# Cloudflare API Variables (retrieved from Kubernetes secrets)
API_TOKEN="${API_TOKEN:?Missing API_TOKEN}"
ZONE_ID="${ZONE_ID:?Missing ZONE_ID}"
CUSTOM_DOMAIN="${CUSTOM_DOMAIN:?Missing CUSTOM_DOMAIN}"
SPECTRUM_PROTOCOL="${SPECTRUM_PROTOCOL:-minecraft}"  # Default to Minecraft if not set
SPECTRUM_PORT="${SPECTRUM_PORT:-25565}"  # Default port 25565

while true; do
  # Get current public IP
  CURRENT_IP=$(curl -s http://ipv4.icanhazip.com | tr -d '\n')

  # Fetch existing Spectrum apps
  RESPONSE=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/spectrum/apps" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json")

  # Extract Spectrum app details
  APP_ID=$(echo "$RESPONSE" | jq -r ".result[] | select(.dns.name == \"$CUSTOM_DOMAIN\") | .id")
  CLOUDFLARE_IP=$(echo "$RESPONSE" | jq -r ".result[] | select(.dns.name == \"$CUSTOM_DOMAIN\") | .origin_direct[0]" | sed 's/tcp:\/\///' | cut -d':' -f1)

  # If Spectrum application doesn't exist, create it (if allowed)
  if [ -z "$APP_ID" ]; then
    echo "Spectrum application not found. Attempting to create one for $CUSTOM_DOMAIN..."

    CREATE_RESPONSE=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/spectrum/apps" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{
        \"dns\": {\"type\": \"CNAME\", \"name\": \"$CUSTOM_DOMAIN\"},
        \"protocol\": \"$SPECTRUM_PROTOCOL\",
        \"origin_direct\": [\"tcp://$CURRENT_IP:$SPECTRUM_PORT\"]
      }")

    if echo "$CREATE_RESPONSE" | jq -e '.success' >/dev/null; then
      echo "Spectrum application created successfully."
    else
      ERROR_CODE=$(echo "$CREATE_RESPONSE" | jq -r '.errors[0].code')
      ERROR_MSG=$(echo "$CREATE_RESPONSE" | jq -r '.errors[0].message')

      if [ "$ERROR_CODE" == "11034" ]; then
        echo "⚠️ Cannot create another Spectrum application: $ERROR_MSG"
        echo "Skipping creation..."
      else
        echo "❌ Error creating Spectrum application: $ERROR_MSG"
      fi
    fi

  # If Spectrum app exists but IP is different, update it
  elif [ "$CURRENT_IP" != "$CLOUDFLARE_IP" ]; then
    echo "IP has changed from $CLOUDFLARE_IP to $CURRENT_IP. Updating Spectrum app..."

    UPDATE_RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/spectrum/apps/$APP_ID" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{
        \"dns\": {\"type\": \"CNAME\", \"name\": \"$CUSTOM_DOMAIN\"},
        \"protocol\": \"$SPECTRUM_PROTOCOL\",
        \"origin_direct\": [\"tcp://$CURRENT_IP:$SPECTRUM_PORT\"]
      }")

    if echo "$UPDATE_RESPONSE" | jq -e '.success' >/dev/null; then
      echo "✅ Spectrum application updated successfully."
    else
      echo "❌ Error updating Spectrum application: $(echo "$UPDATE_RESPONSE" | jq '.errors')"
    fi
  else
    echo "✔️ No change in IP. Spectrum application is up to date."
  fi

  sleep 300  # Run every 5 minutes
done

