#!/usr/bin/env bash
set -euo pipefail

DOMAIN_NAME="hamsammich.local"
SHARE_PATH="//fileshare/FileshareMain"
MOUNT_POINT="/mnt/main"
MOUNT_OWNER="root"
REBOOT_AFTER="yes"

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Run as root."
  exit 1
fi

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
else
  echo "Cannot detect OS."
  exit 1
fi

is_debian_like() {
  [[ "${ID_LIKE:-}" == *"debian"* || "${ID:-}" == "debian" || "${ID:-}" == "ubuntu" ]]
}

is_rhel_like() {
  [[ "${ID_LIKE:-}" == *"rhel"* || "${ID:-}" == "rocky" || "${ID:-}" == "almalinux" || "${ID:-}" == "rhel" || "${ID:-}" == "centos" ]]
}

read -r -p "Domain join user (e.g. admin@$DOMAIN_NAME): " JOIN_USER
read -r -s -p "Domain join password: " JOIN_PASS
echo

read -r -p "SMB username for $SHARE_PATH (leave empty to skip mount): " SMB_USER
SMB_PASS=""
if [[ -n "$SMB_USER" ]]; then
  read -r -s -p "SMB password: " SMB_PASS
  echo
fi

if is_debian_like; then
  apt-get update -y
  apt-get install -y realmd sssd sssd-tools adcli oddjob oddjob-mkhomedir packagekit krb5-user samba-common-bin cifs-utils
  apt-get upgrade -y
elif is_rhel_like; then
  dnf -y update
  dnf -y install realmd sssd sssd-tools adcli oddjob oddjob-mkhomedir samba-common-tools krb5-workstation cifs-utils
else
  echo "Unsupported distro: $ID"
  exit 1
fi

echo "$JOIN_PASS" | realm join --user="$JOIN_USER" "$DOMAIN_NAME"

if [[ -n "$SMB_USER" ]]; then
  mkdir -p "$MOUNT_POINT"
  chmod 755 "$MOUNT_POINT"
  chown "$MOUNT_OWNER":"$MOUNT_OWNER" "$MOUNT_POINT"

  CRED_FILE="/root/.smb-cred"
  cat > "$CRED_FILE" <<EOF
username=$SMB_USER
password=$SMB_PASS
domain=$DOMAIN_NAME
EOF
  chmod 600 "$CRED_FILE"

  if ! grep -q "$SHARE_PATH" /etc/fstab; then
    echo "$SHARE_PATH $MOUNT_POINT cifs credentials=$CRED_FILE,iocharset=utf8,uid=0,gid=0,file_mode=0644,dir_mode=0755 0 0" >> /etc/fstab
  fi
  mount -a
fi

if [[ "$REBOOT_AFTER" == "yes" ]]; then
  reboot
fi
