#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR"/.. || exit 1
OUTPUT_FOLDER_NAME=local-single-file-with-encoding
OUTPUT_DIR=$SCRIPT_DIR/structured-output/$OUTPUT_FOLDER_NAME

PYTHONPATH=. ./unstructured/ingest/main.py \
    --metadata-exclude filename,file_directory,metadata.data_source.date_processed,metadata.date \
    --local-input-path example-docs/fake-html-cp1252.html \
    --structured-output-dir "$OUTPUT_DIR" \
    --encoding cp1252 \
    --verbose \
    --reprocess

set +e

sh "$SCRIPT_DIR"/check-diff-expected-output.sh $OUTPUT_FOLDER_NAME