if [ $(id -u) != 0 ]; then
    echo "Please run this command with superuser privileges:";
    exit 1; else
    echo "You have the privileges."
fi


