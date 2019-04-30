# Streeklab Haarlem

Galaxy workflows created for projects in collaboration with Streeklab Haarlem

# Quay.io

Images are available on [Quay.io](https://quay.io)

- [MYcrobiota Galaxy](https://quay.io/repository/erasmusmc_bioinformatics/streeklab-haarlem-mycrobiota)
- [HLA/JAK2 Galaxy](https://quay.io/repository/erasmusmc_bioinformatics/streeklab-haarlem-galaxy)

## Running Galaxy Servers

To run both Galaxy servers (MYcrobiota and HLA/JAK2):

```
docker-compose up
```

This will automatically pull the required images from quay.io, and run the two Galaxy servers on port 8080 and 8081 (but this can be customized, see later section).

### Updating the Galaxy Servers

Every time a change is made in this github repository, a new docker image is built on quay.io. To fetch the latest images, use:

```
docker-compose pull
```

### Accessing Galaxy

After running docker compose, you can access Galaxy by pointing your browser to `localhost:8080` and `localhost:8081`. Both Galaxy's have been configured with an admin user with credentials `admin@galaxy.org:admin`

### Customizing Galaxy Settings

The docker-compose file can be customized to your needs, for example to specify the ports for each Galaxy server to run on, or the location to store the data and database.

Config settings for Galaxy itself can be passed as environment variables, more information can be found at the [docker-galaxy-stable](https://github.com/bgruening/docker-galaxy-stable) repository.

#### Change ports

```yml
    ports:
      - 4243:80
```

Change the first number to the port you wish to run the image on

#### Change storage location

```yml
    volumes:
      - /home/user/galaxy_storage_mycrobiota/:/export/
```

change the part before the `:` to the location on your system you want the Galaxy files to be stored.

## Docker build

Build the MycroBiota galaxy with:
```
docker build -t mycrobiota-galaxy -f mycrobiota.Dockerfile .
```

Build the HLA-JAK2 galaxy with:
```
docker build -t hla-jak2-galaxy -f hla-jak2.Dockerfile .
```
