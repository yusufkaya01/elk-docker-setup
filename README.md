# ELK Docker Setup 🐳

This repository provides a Dockerized setup for the Elastic Stack (Elasticsearch, Logstash, and Kibana) for testing and development environments. The setup includes preconfigured services for Elasticsearch, Kibana, and Logstash, along with environment variables for easy customization.

The setup process is divided into two steps:

### 1.Fresh Setup: 🆕
    
First, we deploy ELK containers without persistent volumes to initialize the necessary configuration files.

### 2.Persistent Volume Setup: 💾

After the initial setup, we copy the required files from the containers to the host machine and modify the configuration to use persistent volumes. A dedicated after-setup directory in this repository contains the updated Docker Compose file for this setup.

## Requirements 📋
- Docker
- Docker Compose

## Setup and Usage 🚀

1. Clone the repository:

    ```bash
    git clone https://github.com/yusufkaya01/elk-docker-setup.git
    cd elk-docker-setup
    ```

2. Modify the `.env` file with your desired configuration values. Ensure passwords, memory limits, and ports are set as per your needs.

3. Start the ELK stack using Docker Compose:

    ```bash
    docker-compose up -d
    ```

4. Access Kibana via the following URL in your browser:

    ```
    http://localhost:5601
    ```

5. Elasticsearch can be accessed at:

    ```
    http://localhost:9200
    ```

## Configuration ⚙️

- Logstash is configured to listen for logs on port 5044 with JSON codec and send them to Elasticsearch.
- Elasticsearch is configured with TLS encryption and basic authentication, using the provided credentials in the `.env` file
- Kibana is configured to connect to Elasticsearch and display the logs. 📊

## Customization ✏️

You can adjust the setup by modifying the `.env` file and the Logstash configuration files (`logstash.conf` and `logstash.yml`). The Docker Compose file is set up for easy scaling and service management.

## Copying Files and Using Persistent Volumes 🔄

After starting the ELK stack, the following directories need to be copied from the containers to the host machine for persistent volume usage:

Elasticsearch:

```
/usr/share/elasticsearch/data
/usr/share/elasticsearch/config
```

Kibana:

```
/usr/share/kibana/data
/usr/share/kibana/config
```

Logstash:

```
/usr/share/logstash/data
/usr/share/logstash/config
/usr/share/logstash/pipeline
```

Example Copy Command
Use the following command to copy necessary files from a running container to the host machine:
`docker cp logstash:/usr/share/logstash/config <path-to-copy>/`

### Using the Persistent Volume Setup 📦

Once the required files have been copied, use the updated Docker Compose file located in the after-setup directory to run ELK with persistent volumes. This ensures that settings, configurations, and data are not lost on container restarts.


## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
