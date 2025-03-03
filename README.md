# ELK Docker Setup 🐳

This repository provides a Dockerized setup for the Elastic Stack (Elasticsearch, Logstash, and Kibana) for testing and development environments. The setup includes preconfigured services for Elasticsearch, Kibana, and Logstash, along with environment variables for easy customization.

The setup process is divided into two steps:

### 1. Fresh Setup: 🆕
    
First, we deploy ELK containers without persistent volumes to initialize the necessary configuration files.

### 2. Persistent Volume Setup: 💾

After the initial setup, we copy the required files from the containers to the host machine and modify the configuration to use persistent volumes. A dedicated after-setup directory in this repository contains the updated Docker Compose file for this setup.

## Requirements 📋
- Docker
- Docker Compose
- (Optional) Bash (for automating setup using `setup.sh`)

## Setup and Usage 🚀

### Option 1: Manual Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/yusufkaya01/elk-docker-setup.git
    cd elk-docker-setup
    ```

2. Modify the `.env` file with your desired configuration values. Ensure passwords, memory limits, and ports are set as per your needs.

3. **Add an Encryption Key**:  
   To ensure security, you'll need to add an encryption key to the `.env` file. To generate a secure encryption key, use the following command:

    ```bash
    openssl rand -base64 32
    ```

   This will generate a random 32-byte encryption key, which you can then paste into the `.env` file as shown below:

    ```bash
    # SAMPLE Predefined Key only to be used in POC environments
    ENCRYPTION_KEY=<your-generated-encryption-key>
    ```

4. Start the ELK stack using Docker Compose:

    ```bash
    docker-compose up -d
    ```

5. Access Kibana via the following URL in your browser:

    ```
    http://localhost:5601
    ```

6. Elasticsearch can be accessed at:

    ```
    http://localhost:9200
    ```

---

### Option 2: Automated Setup with `setup.sh` (Recommended for ease)

You can automate the entire process by running the `setup.sh` script. This script will guide you through the configuration and setup process in your terminal.

1. Clone the repository:

    ```bash
    git clone https://github.com/yusufkaya01/elk-docker-setup.git
    cd elk-docker-setup
    ```

2. Make sure the script is executable:

    ```bash
    chmod +x setup.sh
    ```

3. Run the `setup.sh` script:

    ```bash
    ./setup.sh
    ```

4. Follow the prompts in the terminal to:
    - Enter the desired configuration values for the `.env` file (e.g., passwords, ports).
    - Generate and automatically add the encryption key to the `.env` file.
    - Start the ELK stack using Docker Compose.

   The script will automate the following:
   - Clone the repository
   - Modify the `.env` file with appropriate values
   - Generate and insert the encryption key
   - Start the ELK containers via Docker Compose

5. After the script completes, access Kibana via:

    ```
    http://localhost:5601
    ```

6. Elasticsearch can be accessed at:

    ```
    http://localhost:9200
    ```

---

## Configuration ⚙️

- Logstash is configured to listen for logs on port 5044 with JSON codec and send them to Elasticsearch.
- Elasticsearch is configured with TLS encryption and basic authentication, using the provided credentials in the `.env` file.
- Kibana is configured to connect to Elasticsearch and display the logs. 📊

## Customization ✏️

You can adjust the setup by modifying the `.env` file and the Logstash configuration files (`logstash.conf` and `logstash.yml`). The Docker Compose file is set up for easy scaling and service management.

## Copying Files and Using Persistent Volumes 🔄

After starting the ELK stack, the following directories need to be copied from the containers to the host machine for persistent volume usage:

- Elasticsearch:

    ```
    /usr/share/elasticsearch/data
    /usr/share/elasticsearch/config
    ```

- Kibana:

    ```
    /usr/share/kibana/data
    /usr/share/kibana/config
    ```

- Logstash:

    ```
    /usr/share/logstash/data
    /usr/share/logstash/config
    /usr/share/logstash/pipeline
    ```

### Example Copy Command
Use the following command to copy necessary files from a running container to the host machine:

```bash
docker cp logstash:/usr/share/logstash/config <path-to-copy>/
```

### Using the Persistent Volume Setup 📦

Once the required files have been copied, use the updated Docker Compose file located in the after-setup directory to run ELK with persistent volumes. This ensures that settings, configurations, and data are not lost on container restarts.


## License 📜

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
