# Delete cached audience keys in redis.

# empty contents of keys.txt
DATADIR="${HOME}/bin/redis-del"
> "${DATADIR}/keys.txt"
> "${DATADIR}/input_keys.txt"
cd ${DATADIR} 
python makekeys.py
while read p; do
  if [[ ${1} = "-r" ]]; then
    echo "Deleting keys from remote redis."
    redis-cli -h aud-api-production.lfmxl9.0001.use1.cache.amazonaws.com del ${p}
  fi
  # local version
  echo "Deleting keys from local redis."
  redis-cli del ${p}
done < input_keys.txt
