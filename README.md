# docker-puppetmaster
Docker image for puppetmaster

## Build

    git clone https://github.com/skylost/docker-puppetmaster.git
    docker build -t skylost/puppetmaster .

## Run

    docker run -d -h puppet -p 8140:8140 --name puppetmaster skylost/puppetmaster 

## Usage

### To see list of certs

    docker exec puppetmaster puppet cert list --all

### To remove node

    docker exec puppetmaster puppet cert clean <hostname>
