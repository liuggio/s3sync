S3 Sync
=======

This docker repository handles a safe backup of a single source folder recursively on Aws S3.

If you need to backup different folders you may run multiple containers :).

### Tutum-like stack file

``` yml
stg-s3sync:
  image: 'liuggio/s3sync:latest'
  autoredeploy: true
  environment:
	- ACCESS_KEY=YOURKEY
    - SECRET_KEY=YOURSECRET
    - SOURCE_DIR=/files
    - S3_PATH=s3://YOURBUCKET
    - LOOP_DELAY=12h
  restart: on-failure
  volumes:
    - '/node_files:/files'
```

### Tip - Keeping multiple variants

On S3 you can configure the bucket with the [versioning](http://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html) flag.

### Advanced Optional Envs

1. `S3_CMD_FLAGS` eg. "--dry-run" or "--exclude ... " more at [http://s3tools.org/s3cmd-sync](http://s3tools.org/s3cmd-sync)

2. `LOOP_DELAY` is the delay between the next sync, default is `200s` you can change to `3m` or `10h` or `3d` for days.

3. `BUCKET_LOCATION=US` You can set different bucket location.

4. `MIME_TYPE` If empty it uses the default mime type using python-magic (suggest to not add this env)

### More

You can play with the [run.sh](./run.sh) with your local docker repo.

### LICENSE

MIT LICENSE

