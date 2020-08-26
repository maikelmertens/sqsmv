# sqsmv

Move all messages from one SQS queue, to another.
This project has been created by Scott Barr, and improved by Maikel Mertens in regards to Docker functionality and several other smaller improvements.

## Configuration

The `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_REGION` environment variables must be set.

## Usage

Supply source and destination URL endpoints via Docker as follows:

    docker run --env-file <(env | grep AWS_) maikelmertens/sqsmv:latest -src https://region.queue.amazonaws.com/123/queue-a -dest https://region.queue.amazonaws.com/123/queue-b

## Testing

Create some SQS messages to play with using the AWS CLI.

    for i in {0..24..1}; do
        aws sqs send-message \
            --queue-url https://region.queue.amazonaws.com/123/queue-a
            --message-body "{\"id\": $i}"
    done

## Updating Policy

This Docker image will be automatically refreshed every week, hence you will have the latest updated version of the Docker image available anytime.

## License

The MIT License (MIT)

Copyright (c) 2016-2020 Scott Barr / Maikel Mertens

See [LICENSE.md](LICENSE.md)
