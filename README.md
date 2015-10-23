S3 Sync
=======

This docker repository handles a safe backup of a single source folder recursively on Aws S3.

If you need to backup different folders you may run multiple containers :).

### Envs - docker-compose/tutum.io

1. `ACCESS_KEY`

2. `SECRET_KEY`

3. `SOURCE_DIR` eg /home

4. `S3_PATH`  eg. s3://THISISMYAWSBUCKETNAME

5. optional `S3_CMD_FLAGS` eg. "--dry-run" or "--exclude ... " more at [http://s3tools.org/s3cmd-sync](http://s3tools.org/s3cmd-sync)

### Tip - Keeping multiple variants

On S3 you can configure the bucket with the [versioning](http://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html) flag.

### Advanced Envs

1. `LOOP_DELAY` is the delay between the next sync, default is `200s` you can change to `3m` or `10h` or `3d` for days.

1. `BUCKET_LOCATION=US` You can set different bucket location.

2. `MIME_TYPE` If empty it uses the default mime type using python-magic (suggest to not add this env)

### More

You can play with the [run.sh](./run.sh) with your local docker repo.
