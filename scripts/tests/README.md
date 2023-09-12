<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Opensearch, verified and packaged by Elestio

[Opensearch](https://github.com/opensearch-project/OpenSearch) Open source distributed and RESTful search engine.

<img src="https://github.com/elestio-examples/opensearch/raw/master/screenshot.png" alt="opensearch" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/opensearch">fully managed opensearch</a> on <a target="_blank" href="https://elest.io/">elest.io</a> OpenSearch is a community-driven, open source search and analytics suite derived from Apache 2.0 licensed Elasticsearch 7.10.2 & Kibana \n7.10.2.

[![deploy](https://github.com/elestio-examples/opensearch/raw/master/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/opensearch)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/opensearch.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./postgresql
    chown -R 1000:1000 ./postgresql

    mkdir -p ./addons
    chown -R 1000:1000 ./addons

    mkdir -p ./config
    chown -R 1000:1000 ./config

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:5601`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: '3.3'
    services:
      opensearch-node1:
        image: elestio4test/opensearch:${SOFTWARE_VERSION_TAG}
        container_name: opensearch-node1
        environment:
          - cluster.name=opensearch-cluster
          - node.name=opensearch-node1
          - bootstrap.memory_lock=true
          - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m"
          - "DISABLE_INSTALL_DEMO_CONFIG=true"
          - "DISABLE_SECURITY_PLUGIN=true"
          - "discovery.type=single-node"
        ulimits:
          memlock:
            soft: -1
            hard: -1
          nofile:
            soft: 65536
            hard: 65536
        volumes:
          - ./data:/usr/share/opensearch/data
        ports:
          - 172.17.0.1:9200:9200
          - 172.17.0.1:9600:9600
        networks:
          - opensearch-net
      opensearch-dashboards:
        image: opensearchproject/opensearch-dashboards:${SOFTWARE_VERSION_TAG}
        container_name: opensearch-dashboards
        ports:
          - 172.17.0.1:5601:5601
        expose:
          - "5601"
        environment:
          OPENSEARCH_HOSTS: '["http://opensearch-node1:9200"]'
          DISABLE_SECURITY_DASHBOARDS_PLUGIN: 'true'
        networks:
          - opensearch-net
    volumes:
      opensearch-data1:
    networks:
      opensearch-net:

# Maintenance

## Logging

The Elestio opensearch Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/opensearch-project/OpenSearch">Opensearch Github repository</a>

- <a target="_blank" href="https://opensearch.org/docs/latest/">Opensearch documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/opensearch">Elestio/Opensearch Github repository</a>
