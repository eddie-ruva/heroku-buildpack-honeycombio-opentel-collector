#!/usr/bin/env bash

APP_OTELCOL="$HOME/otelcol"
export OTELCOL_CONFIG_DIR="$HOME/.otelcol"

if [ "$DYNOTYPE" == "run" ]; then
  exit 0
fi

export CUSTOM_APP_CONFIG="$APP_OTELCOL/config.yaml"

if [[ -f "$CUSTOM_APP_CONFIG" ]]; then
  export OTEL_CONFIG="${CUSTOM_APP_CONFIG}"
else
  export OTEL_CONFIG="${OTELCOL_CONFIG_DIR}/config.yaml"
fi

if [ -n "$DISABLE_OTELCOL" ]; then
  echo "The OpenTelemetry Collector agent has been disabled. Unset the $DISABLE_OTELCOL or set missing environment variables."
else
  echo "-----> Starting OpenTelemetry Collector"
  echo $(ls)
  echo $(ls $OTELCOL_CONFIG_DIR)
  echo "USING CONFIG: ${OTEL_CONFIG}"
  echo "$OTELCOL_CONFIG_DIR/otelcol --config $OTEL_CONFIG 2>&1 &"
  echo "-----> "
  chmod a+x $OTELCOL_CONFIG_DIR/otelcol_hny_linux_amd64
  $OTELCOL_CONFIG_DIR/otelcol_hny_linux_amd64 --config $OTEL_CONFIG 2>&1&
  echo "-----> Started OpenTelemetry Collector"
fi
