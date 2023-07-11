#!/usr/bin/env bash

APP_OTELCOL="$HOME/otelcol"
export OTELCOL_CONFIG_DIR="$HOME/.otelcol"

if [ "$DYNOTYPE" == "run" ]; then
  exit 0
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
else
  echo "-----> Starting OpenTelemetry Collector"
  echo $(ls)
  echo $(ls $OTELCOL_CONFIG_DIR)
  echo "$OTELCOL_CONFIG_DIR/otelcol --config $APP_OTELCOL/config.yml 2>&1 &"
  echo "-----> "
  chmod a+x $OTELCOL_CONFIG_DIR/otelcol_hny_linux_amd64
  $OTELCOL_CONFIG_DIR/otelcol_hny_linux_amd64 --config $APP_OTELCOL/config.yml 2>&1&
  echo "-----> Started OpenTelemetry Collector"
fi
