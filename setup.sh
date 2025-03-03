#!/bin/bash

# Create directories for persistent volumes
echo "Creating directories for Elasticsearch, Kibana, and Logstash volumes..."
mkdir -p ./elasticsearch-volume ./kibana-volume ./logstash-volume

# Set permissions so Docker can read/write
echo "Setting permissions for the volumes..."
chmod 775 -R ./elasticsearch-volume ./kibana-volume ./logstash-volume

# Start the ELK stack with Docker Compose
echo "Starting ELK stack using Docker Compose..."
docker-compose up -d

# Wait for the containers to be healthy
echo "Waiting for containers to be healthy..."

# Check container health status in a loop
while true; do
    # Check the health of each container
    elasticsearch_health=$(docker inspect --format '{{.State.Health.Status}}' elasticsearch)
    kibana_health=$(docker inspect --format '{{.State.Health.Status}}' kibana)
    logstash_health=$(docker inspect --format '{{.State.Health.Status}}' logstash)

    # If all containers are healthy, break the loop
    if [[ "$elasticsearch_health" == "healthy" && "$kibana_health" == "healthy" && "$logstash_health" == "healthy" ]]; then
        echo "All containers are healthy!"
        break
    else
        # Wait for 60 seconds before checking again
        echo "Waiting for containers to be healthy..."
        sleep 60
    fi
done

# Copy files from the containers to the host machine for persistent volume usage
echo "Copying Elasticsearch data and config..."
docker cp elasticsearch:/usr/share/elasticsearch/data ./elasticsearch-volume/
docker cp elasticsearch:/usr/share/elasticsearch/config ./elasticsearch-volume/

echo "Copying Kibana data and config..."
docker cp kibana:/usr/share/kibana/data ./kibana-volume/
docker cp kibana:/usr/share/kibana/config ./kibana-volume/

echo "Copying Logstash data, config, and pipeline..."
docker cp logstash:/usr/share/logstash/data ./logstash-volume/
docker cp logstash:/usr/share/logstash/config ./logstash-volume/
docker cp logstash:/usr/share/logstash/pipeline ./logstash-volume/

echo "Files copied to volumes successfully!"

# Set permissions for the copied files
echo "Setting permissions for the copied files..."
chmod 775 -R ./elasticsearch-volume ./kibana-volume ./logstash-volume

# Stop and remove the containers, networks, and volumes
echo "Stopping and removing containers, networks, and volumes..."
docker-compose down -v

# Replace the docker-compose.yml file with the one from ./after-setup
echo "Replacing docker-compose.yml with the one from ./after-setup..."
cp ./after-setup/docker-compose.yml ./docker-compose.yml

# Restart the containers with the updated docker-compose.yml
echo "Starting the containers with the updated docker-compose.yml..."
docker-compose up -d

# Wait for the containers to be healthy again
echo "Waiting for containers to be healthy after restart..."

# Check container health status again
while true; do
    # Check the health of each container
    elasticsearch_health=$(docker inspect --format '{{.State.Health.Status}}' elasticsearch)
    kibana_health=$(docker inspect --format '{{.State.Health.Status}}' kibana)
    logstash_health=$(docker inspect --format '{{.State.Health.Status}}' logstash)

    # If all containers are healthy, break the loop
    if [[ "$elasticsearch_health" == "healthy" && "$kibana_health" == "healthy" && "$logstash_health" == "healthy" ]]; then
        echo "All containers are healthy!"
        break
    else
        # Wait for 60 seconds before checking again
        echo "Waiting for containers to be healthy..."
        sleep 60
    fi
done

# Final message
echo "Process is finished! 🎉"
echo "I thank you for using my repo. Check out my GitHub repo at: https://github.com/yusufkaya01"
echo "Yusuf Kaya"
