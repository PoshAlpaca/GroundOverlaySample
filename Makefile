.PHONY: secrets

GOOGLE_MAPS_API_KEY = "\<\#GOOGLE_MAPS_API_KEY\#\>"
secrets:
	echo "//This file was auto-generated with \`make secrets\`.\nlet googleMapsAPIKey = \"$(GOOGLE_MAPS_API_KEY)\"" > GroundOverlaySample/Secrets.swift
