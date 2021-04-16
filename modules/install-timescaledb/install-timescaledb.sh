#!/usr/bin/env bash

set -e

function print_usage {
  echo
  echo "Usage: install-timescaledb [options]"
  echo
  echo "This script can be used to install TimescaleDB and its dependencies. This script has been tested with Ubuntu 18.04."
  echo
  echo "Options:"
  echo
  echo -e "  --postgresql_version\t\tVersion of PostgreSQL to install."
  echo -e "  --postgresql_password\t\tPassword for the provisioned postgres user."
  echo -e "  --postgis_version\t\tVersion of PostGIS to install."
  echo -e "  --timescaledb_version\t\tVersion of TimescaleDB to install."
  echo
  echo "Example:"
  echo
  echo "  install-timescaledb --postgresql_version $DEFAULT_POSTGRESQL --postgis_version $DEFAULT_POSTGIS --timescaledb_version $DEFAULT_TIMESCALEDB"
}

function log {
  local -r level="$1"
  local -r message="$2"
  local -r timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  >&2 echo -e "$timestamp [$level] [$SCRIPT_NAME] $message"
}

function assert_not_empty {
  local -r arg_name="$1"
  local -r arg_value="$2"

  if [[ -z "$arg_value" ]]; then
    log "ERROR" "The value for '$arg_name' cannot be empty"
    print_usage
    exit 1
  fi
}

function has_apt_get {
  [ -n "$(command -v apt-get)" ]
}

function install_dependencies {
  log "INFO" "Installing dependencies"

  if has_apt_get; then
    sudo apt-get update -y
    sudo apt-get upgrade -y --with-new-pkgs
    sudo apt-get install -y gcc libreadline-dev libssl-dev libsystemd-dev make zlib1g-dev
  else
    log "ERROR" "Could not find apt-get. Cannot install dependencies on this OS."
    exit 1
  fi
}

function install_postgresql {
  local -r version="$1"
  local -r service="postgresql.service"
  local -r systemd="/etc/systemd/system/$service"
  log "INFO" "POSTGRESQL $version"
  # https://www.postgresql.org/docs/13/installation.html
  # https://www.postgresql.org/docs/13/runtime.html


  log "INFO" "Downloading the application"
  wget "https://ftp.postgresql.org/pub/source/v$version/postgresql-$version.tar.gz"
  tar xvf "postgresql-$version.tar.gz"
  cd "postgresql-$version"

  log "INFO" "Configuring (including the user), building and performing regression testing"

  ./configure --with-openssl --with-systemd
  make world

  log "INFO" "Installing, configuring the user, creating the data directory, and changing ownership"
  sudo make install-world
  sudo adduser --system --home /var/lib/postgresql postgres
  sudo mkdir /usr/local/pgsql/data
  sudo chown postgres /usr/local/pgsql/data

  log "INFO" "Intializing database and configuring systemd"
  sudo -u postgres /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
  cd .. && rm -rf postgresql-$version*
}

function install_postgis {
  local -r version="$1"
}

function install_timescaledb {
  local -r version="$1"
}

function install {
  local postgresql_version="$DEFAULT_POSTGRESQL"
  local postgis_version="$DEFAULT_POSTGIS"
  local timescaledb_version="$DEFAULT_TIMESCALEDB"

  while [[ $# -gt 0 ]]; do
    local key="$1"

    case "$key" in
      --postgresql_version)
        postgresql_version="$2"
        shift
        ;;
      --postgis_version)
        postgis_version="$2"
        shift
        ;;
      --timescaledb_version)
        timescaledb_version="$2"
        shift
        ;;
      --help)
        print_usage
        exit
        ;;
      *)
        echo "Unrecognized argument: $key"
        print_usage
        exit 1
        ;;
    esac

    shift
  done

  assert_not_empty "--postgresql_version" "$postgresql_version"
#  assert_not_empty "--postgis_version" "$postgis_version"
#  assert_not_empty "--timescaledb_version" "$timescaledb_version"

  install_dependencies
  install_postgresql "$postgresql_version"
#  install_postgis "$postgis_version"
#  install_timescaledb "$timescaledb_version"
}

install "$@"