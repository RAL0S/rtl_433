#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/rtl_433/releases/download/v21.12-146/rtl_433-21.12-146.tar.gz -O $RALPM_TMP_DIR/rtl_433-21.12-146.tar.gz
  tar xf $RALPM_TMP_DIR/rtl_433-21.12-146.tar.gz -C $RALPM_PKG_INSTALL_DIR/
  rm $RALPM_TMP_DIR/rtl_433-21.12-146.tar.gz

  ln -s $RALPM_PKG_INSTALL_DIR/bin/rtl_433 $RALPM_PKG_BIN_DIR/
  echo "This package adds the command: rtl_433"
}

uninstall() {
  rm -rf $RALPM_PKG_INSTALL_DIR/*
  rm $RALPM_PKG_BIN_DIR/rtl_433
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1