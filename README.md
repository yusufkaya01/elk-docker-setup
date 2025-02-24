# ELK Docker Setup

This repository provides a Dockerized setup for the Elastic Stack (Elasticsearch, Logstash, and Kibana) for testing and development environments. The setup includes preconfigured services for Elasticsearch, Kibana, and Logstash, along with environment variables for easy customization.

## Requirements
- Docker
- Docker Compose

## Setup and Usage

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

## Configuration

- Logstash is configured to listen for logs on port 5044 with JSON codec and send them to Elasticsearch.
- Elasticsearch is configured with basic authentication, using the provided credentials in the `.env` file.
- Kibana is configured to connect to Elasticsearch and display the logs.

## Customization

You can adjust the setup by modifying the `.env` file and the Logstash configuration files (`logstash.conf` and `logstash.yml`). The Docker Compose file is set up for easy scaling and service management.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
