FROM vvakame/review:5.9

RUN apt-get update -qq \
    && apt-get install -y -qq --no-install-recommends graphviz \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /book

COPY . /book

RUN ./setup.sh
