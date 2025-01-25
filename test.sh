#!/bin/sh
DOCKER_IMAGE=$1
DOCKER_RUN="docker run --rm -i -v $(pwd):/local -w /local ${DOCKER_IMAGE}"

CMD="mkdir -p examples/src examples/bin && \
    cp hello_world.mth examples/src/ && \
    ln -s /root/.mirth/lib examples/lib && \
    cd examples && \
    mirth -o bin/hello_world.c src/hello_world.mth 1>&2 && \
    gcc -o hello_world bin/hello_world.c && \
    ./hello_world && \
    cd .. && \
    rm -rf examples hello_world"
RESULT="$(${DOCKER_RUN} sh -c "${CMD}")"
echo "${RESULT}"
if [ "${RESULT}" = "Hello, world!" ]
then
    echo "PASSED"
else
    echo "FAILED"
    exit 1
fi
