: ${CI_REGISTRY:=}
: ${CI_PROJECT_PATH:=feduxorg/www_test_server}
: ${CI_PROJECT_NAME:=www_test_server}
: ${CI_COMMIT_SHA:=latest}
: ${CI_WORK_DIR:=./}
: ${CI_NETWORK_MODE:=internal}
: ${CI_DOCKER_FILE:=docker/latest/Dockerfile}
if [ -z "$CI_REGISTRY" ]; then
: ${DOCKER_CURRENT_IMAGE_TAG:=$CI_PROJECT_PATH:$CI_COMMIT_SHA}
else
: ${DOCKER_CURRENT_IMAGE_TAG:=$CI_REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA}
fi
: ${DOCKER_CONTAINER_NAME:=$(basename $DOCKER_CURRENT_IMAGE_TAG | sed -e 's/:/-/')-1}
