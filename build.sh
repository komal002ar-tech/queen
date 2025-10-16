#!/bin/bash

echo "=== Starting Chrome Installation for Render ==="

# System update
apt-get update
apt-get install -y wget gnupg unzip

# Install Google Chrome
echo "Installing Google Chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt-get update
apt-get install -y google-chrome-stable

# Install ChromeDriver
echo "Installing ChromeDriver..."
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+\.\d+' | head -1)
echo "Detected Chrome version: $CHROME_VERSION"

CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
echo "Matching ChromeDriver version: $CHROMEDRIVER_VERSION"

wget -q -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip -q /tmp/chromedriver.zip -d /usr/local/bin/
chmod +x /usr/local/bin/chromedriver

# Install system dependencies
echo "Installing system dependencies..."
apt-get install -y libnss3-dev libxss1 libappindicator3-1 libgdk-pixbuf2.0-0 libgtk-3-0 fonts-liberation xvfb

# Verify installations
echo "=== Verification ==="
echo "Chrome path: $(which google-chrome)"
echo "Chrome version: $(google-chrome --version)"
echo "ChromeDriver path: $(which chromedriver)"
echo "ChromeDriver version: $(chromedriver --version)"

echo "=== Chrome Installation Complete ==="
