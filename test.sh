#!/bin/sh
DOCKER_IMAGE=$1
DOCKER_RUN="docker run --rm -i -v $(pwd):/local -w /local ${DOCKER_IMAGE}"

CMD="mkdir -p src bin && \
    cp -r /usr/local/src/* src/ && \
    cp hello_world.mth src/ && \
    mirth hello_world.mth 1>&2 && \
    gcc -o hello_world bin/hello_world.c && \
    ./hello_world && \
    rm -rf src bin hello_world"
RESULT="$(${DOCKER_RUN} sh -c "${CMD}")"
echo "${RESULT}"
if [ "${RESULT}" = "Hello, world!" ]
then
    echo "PASSED"
else
    echo "FAILED"
    exit 1
fi
