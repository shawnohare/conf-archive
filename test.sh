if [ $(id -u) != 0 ]; then
    echo "Please run this command with superuser privileges:";
    echo "$ sudo install.sh";
    exit 1
fi
