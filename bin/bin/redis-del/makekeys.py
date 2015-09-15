import hashlib


def sha1(s):
    """Compute the sha1 hash of the input string."""
    h = hashlib.sha1()
    h.update(s.encode())
    return h.hexdigest()

def worker(infile, outfile):
    del_key = ""
    with open(infile) as f:
        with open(outfile, "w") as g:
            for aud in f:
                aud = aud.strip()
                aud = "sample:follower_dist:" + aud
                key = sha1(aud)
                if del_key:
                    del_key += " "
                del_key +=  key
                print(key, file=g)

        # Write keys as a single line so they can be ingested
        # by the redis-cli del command
        with open("input_" + outfile, "w") as h:
            print(del_key, file=h)

def worker2(infile, outfile):
    with open(infile) as f:
        auds = f.readlines()
        keys = [sha1(aud.strip()) for aud in auds]
        input_key = " ".join(keys)

        # write output to two files which bash then reads
        # FIXME really should just connect to redis directly
        with open("input_" + outfile, "w") as h:
            print(input_key, file=h)

        with open(outfile, "w") as g:
            for key in keys:
                print(key, file=g)

# keys = [sha1(aud) for aud in auds]

def main():

     worker("auds.txt", "keys.txt")

if  __name__ == "__main__":
    main()


