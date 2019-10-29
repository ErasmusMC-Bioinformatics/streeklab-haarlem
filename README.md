# Streeklab Haarlem

Galaxy workflows created for projects in collaboration with Streeklab Haarlem

# Quay.io

Images are available on [Quay.io](https://quay.io)

- [MYcrobiota Galaxy](https://quay.io/repository/erasmusmc_bioinformatics/streeklab-haarlem-galaxy-mycrobiota)
- [HLA/JAK2 Galaxy](https://quay.io/repository/erasmusmc_bioinformatics/streeklab-haarlem-galaxy)


## Running Galaxy Servers

To run both Galaxy servers (MYcrobiota and HLA/JAK2):

Install Docker according to the installation instructions for your server: [Docker Docs](https://docs.docker.com/)

Next, clone this repository:

```bash
git clone git@github.com:ErasmusMC-Bioinformatics/streeklab-haarlem.git
cd  streeklab-haarem
```

Run docker-compose:

```bash
docker-compose up
```

This will automatically pull the required images from quay.io, and run the two Galaxy servers on port 8080 and 8081 (but this can be customized, see later section).

### Accessing Galaxy

After running docker compose, you can access Galaxy by pointing your browser to `localhost:8080` and `localhost:8081`. Both Galaxy's have been configured with an admin user with credentials `admin@galaxy.org:admin`

### Customizing Docker and Galaxy Settings

The `docker-compose.yml` file can be customized to your needs, for example to specify the ports for each Galaxy server to run on, or the location to store the data and database.

#### Change ports

```yml
    ports:
      - 8081:80
```

Change the first number to the port you wish to run the image on

#### Change storage location

```yml
    volumes:
      - /home/user/galaxy_storage_mycrobiota/:/export/
```

change the part before the `:` to the location on your system you want the Galaxy files to be stored.

#### Changing Galaxy settings

Config settings for Galaxy itself can be passed as environment variables in the docker compose file, by adding a section like

```yml
environment:
  - "GALAXY_CONFIG_BRAND=MYcrobiota"
```

This environment variable sets the branding for the home page. All other options in the [Galaxy config file](https://github.com/galaxyproject/galaxy/blob/dev/config/galaxy.yml.sample#L671) can be set in this way (prepend `GALAXY_BRAND_` to the name of the setting in the galaxy.yml file to get the corresponding environment variable name).

More information can be found at the [docker-galaxy-stable](https://github.com/bgruening/docker-galaxy-stable) repository.


### Updating the Galaxy Servers

Every time a change is made in this github repository, a new docker image is built on quay.io. To fetch the latest images, use:

```
docker-compose pull
```

## Building the Docker images locally [only for development]

To update the images, simply make changes in this repository, and images will be automatically be rebuilt on quay.

But if you would like to build the images locally (e.g. for testing changes), you can do so by running the following commands:

Build the MYcrobiota Galaxy with:

```
docker build -t mycrobiota-galaxy -f mycrobiota.Dockerfile .
```

Build the HLA-JAK2 Galaxy with:

```
docker build -t hla-jak2-galaxy -f hla-jak2.Dockerfile .
```
