# Opensearch on Elestio with CI/CD

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/docker-compose-mysql"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Example CI/CD pipeline showing how to deploy a Opensearch instance to elestio.

# Once deployed ...

You are able now to connect to the Opensearch Dashboard:

    Access URL: https://[CI_CD_DOMAIN]/
    Login: root
    Password: [APP_PASSWORD] (set in reverse proxy configuration)

OpenSearch API endpoint:

    Host: [CI_CD_DOMAIN]
    Protocol: https
    Port: 19200
    Login: root
    Password: [APP_PASSWORD] (set in reverse proxy configuration)


# Quick start with curl examples:

Create your first index:

    curl -XPUT -u 'root:[APP_PASSWORD]' 'https://[CI_CD_DOMAIN]:19200/my-first-index'

Add some data to your newly created index:

    curl -XPUT -u 'root:[APP_PASSWORD]' 'https://[CI_CD_DOMAIN]:19200/my-first-index/_doc/1' -H 'Content-Type: application/json' -d '{"Description": "To be or not to be, that is the question."}'

Retrieve the data to see that it was added properly:

    curl -XGET -u 'root:[APP_PASSWORD]' 'https://[CI_CD_DOMAIN]:19200/my-first-index/_doc/1'

After verifying that the data is correct, delete the document:

    curl -XDELETE -u 'root:[APP_PASSWORD]' 'https://[CI_CD_DOMAIN]:19200/my-first-index/_doc/1'

Finally, delete the index: 

    curl -XDELETE -u 'root:[APP_PASSWORD]' 'https://[CI_CD_DOMAIN]:19200/my-first-index/'


Documentation: 
https://opensearch.org/docs/
