FROM python:3.12-slim-bookworm AS blast

ARG BLAST_VERSION

RUN apt update && apt install -y wget g++ make liblmdb-dev libsqlite3-dev
RUN mkdir /blast
RUN wget -qO- https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${BLAST_VERSION}/ncbi-blast-${BLAST_VERSION}+-src.tar.gz \
    | tar xz --strip-components 2 -C /blast
WORKDIR /blast
RUN ./configure --with-projects=scripts/projects/blast/project.lst
RUN cd ReleaseMT/build && make all_p

ENV PATH="$PATH:/blast/ReleaseMT/bin"