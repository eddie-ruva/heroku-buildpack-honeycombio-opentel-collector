#!/usr/bin/env bash

OTELCOL_DIR="$HOME/.otelcol"
CONFIG_PATH="$OTELCOL_DIR/config.yaml"

# Check if it's a one-off dyno. When it is DYNO has a value like run.2123
if [ "$DYNO" == "run."* ]; then
  exit 0
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
else
  echo "-----> Starting OpenTelemetry Collector"
  echo $(ls)
  echo $(ls $OTELCOL_DIR)
  echo "USING CONFIG: ${CONFIG_PATH}"
  echo "$OTELCOL_DIR/otelcol --config $CONFIG_PATH 2>&1 &"
  echo "-----> "
  chmod a+x $OTELCOL_DIR/otelcol_hny_linux_amd64
  $OTELCOL_DIR/otelcol_hny_linux_amd64 --config $CONFIG_PATH 2>&1&
  echo "-----> Started OpenTelemetry Collector"
fi
