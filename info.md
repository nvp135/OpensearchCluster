# Кластер OpenSearch

## Репозиторий содержит:

- setup_certs.sh - генерация SSL сертификатов
- security_admin.sh - активация защиты кластера
- docker-compose.yml - docker-compose файл для запуска


# Docker compose file

    version: '3'
    services:
    
      os01:
        image: "sbt/opensearch:1.2.4"
        container_name: os01
        environment:
          - "DISABLE_INSTALL_DEMO_CONFIG=true"
          - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m" # minimum and maximum Java heap size, recommend setting both to    50% of system RAM
          #- "node.name=os-01"
          #- discovery.type=single-node
          #- cluster.name=os-cluster
          - "node.name=os01"
          #- discovery.seed_hosts=os01,os02,os03
          #- cluster.initial_master_nodes=os01,os02,os03
          #- cluster.initial_cluster_manager_nodes="127.0.0.1","127.0.0.2"
          #- bootstrap.memory_lock=true # along with the memlock settings below, disables swapping
          - "network.host=0.0.0.0" # required if not using the demo security configuration
          - "path.repo=/mnt/snapshots"
          - "reindex.remote.whitelist=*:*"
          - "reindex.ssl.verification_mode=none"
        ulimits:
          memlock:
            soft: -1
            hard: -1
          nofile:
            soft: 65536 # maximum number of open files for the OpenSearch user, set to at least 65536 on modern     systems
            hard: 65536
        volumes:
          - ./os-config/01/opensearch.yml:/usr/share/opensearch/config/opensearch.yml:ro
          - ./os-config/01/securityconfig:/usr/share/opensearch/plugins/opensearch-security/securityconfig
          - ./os-config/01/config.yml:/usr/share/opensearch/plugins/opensearch-security/securityconfig/config.yml:ro
          - ./backup:/mnt/snapshots
          - ./data/01:/usr/share/opensearch/data
          - ./logs/01:/usr/share/opensearch/logs
          - ./certs:/usr/share/opensearch/config/certificates:ro
        ports:
          - 9201:9200
          - 9301:9300
          - 9601:9600 # required for Performance Analyzer
        networks:
          - os-net
        #command: sh -c "chmod +x /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh && bash /    usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/opensearch/plugins/  opensearch-security/securityconfig/ -icl -nhnv -cacert config/certificates/ca/ca.pem -cert config/    certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"
      os02:
        image: "sbt/opensearch:1.2.4"
        container_name: os02
        environment:
          - "DISABLE_INSTALL_DEMO_CONFIG=true"
          - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m" # minimum and maximum Java heap size, recommend setting both to    50% of system RAM
          #- "node.name=os-02"
          #- discovery.type=single-node
          #- cluster.name=os-cluster
          - "node.name=os02"
          #- discovery.seed_hosts=os01,os02,os03
          #- cluster.initial_master_nodes=os01,os02,os03
          #- cluster.initial_cluster_manager_nodes="127.0.0.1","127.0.0.2"
          #- bootstrap.memory_lock=true # along with the memlock settings below, disables swapping
          #- "network.host=0.0.0.0" # required if not using the demo security configuration
          - "path.repo=/mnt/snapshots"
          - "reindex.remote.whitelist=*:*"
          - "reindex.ssl.verification_mode=none"
        ulimits:
          memlock:
            soft: -1
            hard: -1
          nofile:
            soft: 65536 # maximum number of open files for the OpenSearch user, set to at least 65536 on modern     systems
            hard: 65536
        volumes:
          - ./os-config/02/opensearch.yml:/usr/share/opensearch/config/opensearch.yml:ro
          - ./os-config/02/securityconfig:/usr/share/opensearch/plugins/opensearch-security/securityconfig
          - ./os-config/02/config.yml:/usr/share/opensearch/plugins/opensearch-security/securityconfig/config.yml:ro
          - ./data/02:/usr/share/opensearch/data
          - ./logs/02:/usr/share/opensearch/logs
          - ./certs:/usr/share/opensearch/config/certificates:ro
          - ./backup:/mnt/snapshots
        ports:
          - 9202:9200
          - 9302:9300
          - 9602:9600 # required for Performance Analyzer
        networks:
          - os-net
        #command: sh -c "chmod +x /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh && bash /    usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/opensearch/plugins/  opensearch-security/securityconfig/ -icl -nhnv -cacert config/certificates/ca/ca.pem -cert config/    certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"
    
      os03:
        image: "sbt/opensearch:1.2.4"
        container_name: os03
        environment:
          - "DISABLE_INSTALL_DEMO_CONFIG=true"
          - "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m" # minimum and maximum Java heap size, recommend setting both to    50% of system RAM
          #- "node.name=os-03"
          #- discovery.type=single-node
          #- cluster.name=os-cluster
          - "node.name=os03"
          #- discovery.seed_hosts=os01,os02,os03
          #- cluster.initial_master_nodes=os01,os02,os03
          #- cluster.initial_cluster_manager_nodes="127.0.0.1","127.0.0.2"
          #- bootstrap.memory_lock=true # along with the memlock settings below, disables swapping
          - "network.host=0.0.0.0" # required if not using the demo security configuration
          - "path.repo=/mnt/snapshots"
          - "reindex.remote.whitelist=*:*"
          - "reindex.ssl.verification_mode=none"
        ulimits:
          memlock:
            soft: -1
            hard: -1
          nofile:
            soft: 65536 # maximum number of open files for the OpenSearch user, set to at least 65536 on modern     systems
            hard: 65536
        volumes:
          - ./os-config/03/opensearch.yml:/usr/share/opensearch/config/opensearch.yml:ro
          - ./os-config/03/securityconfig:/usr/share/opensearch/plugins/opensearch-security/securityconfig
          - ./os-config/03/config.yml:/usr/share/opensearch/plugins/opensearch-security/securityconfig/config.yml:ro
          - ./backup:/mnt/snapshots
          - ./data/03:/usr/share/opensearch/data
          - ./logs/03:/usr/share/opensearch/logs
          - ./certs:/usr/share/opensearch/config/certificates:ro
        ports:
          - 9203:9200
          - 9303:9200
          - 9603:9600 # required for Performance Analyzer
        networks:
          - os-net
        #command: sh -c "chmod +x /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh && bash /    usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/opensearch/plugins/  opensearch-security/securityconfig/ -icl -nhnv -cacert config/certificates/ca/ca.pem -cert config/    certificates/ca/admin.pem -key config/certificates/ca/admin.key -h localhost"
    
      osdb:
        image: "sbt/opensearch-dashboards:1.2.0"
        container_name: osdb
        volumes:
          - ./osdb-config/opensearch-dashboards.yml:/usr/share/opensearch-dashboards/config/opensearch_dashboards.yml
          - ./certs:/usr/share/opensearch-dashboards/config/certificates:ro
        ports:
          - 5601:5601
        expose:
          - "5601"
        networks:
          - os-net
        healthcheck:
          test: ["CMD-SHELL", "curl -f http://localhost:5601/"]
          interval: 30s
          timeout: 20s
          retries: 3
        
    #  ls:
    #    image: "sbt/logstash-oss-alt:7.16.3"
    #    container_name: ls
    #    volumes:
    #      - ./ls/data:/usr/share/logstash/data:Z
    #      - ./ls/config/log4j2.properties:/usr/share/logstash/config/log4j2.properties:ro,Z
    #      - ./ls/config/pipelines.yml:/usr/share/logstash/config/pipelines.yml:ro,Z
    #      - ./ls/pipeline:/usr/share/logstash/pipeline:ro,Z
    #      - ./ls/queue:/usr/share/logstash/queue:Z
    #      - ./ls/logs:/usr/share/logstash/logs:Z
    #      - ./ls/misc:/usr/share/logstash/misc:Z
    #    ports:
    #      - "127.0.0.1:9602:9602" #9601 original
    #      - 8888:8888 # test input for nexus input pipeline
    #    security_opt:
    #      - label:disable
    #    ulimits:
    #      memlock:
    #        soft: -1
    #        hard: -1
    #      nofile:
    #        soft: 65536
    #        hard: 65536
    #    mem_limit: '9530m'
    #    memswap_limit: '15884m'
    #    oom_score_adj: -100
    #    cpu_shares: 1024
    #    cpu_quota: 320000
    #    cpuset: 0-1
    #    environment:
    #      - "LS_JAVA_OPTS=-Xms1942m -Xmx1942m -Djavax.net.debug=SSL -Dcom.sun.net.ssl.checkRevocation=false"
    #      - "config.reload.automatic=false"
    #      - "dead_letter_queue.enable=true"
    #      - "node.name=logstash-worker@p-elkmon-logstashworker-01"
    #      - "path.logs=/usr/share/logstash/logs"
    #      - "path.queue=/usr/share/logstash/queue"
    #      - "path.settings=/usr/share/logstash/config"
    #      - "pipeline.id=worker"
    #      - "pipeline.unsafe_shutdown=true"
    #      - "pipeline.workers=4"
    #      - "queue.max_bytes=256mb"
    #      - "queue.max_events=100"
    #      - "queue.type=persisted"
    #      - "slowlog.threshold.warn=10s"
    #      - "log_level=debug"
    #    logging:
    #      driver: json-file
    #      options:
    #          max-file: '3'
    #          max-size: 10m
    #    restart: on-failure
    #    networks:
    #      - os-net
    
    networks:
      os-net: