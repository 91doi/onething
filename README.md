
# uphold/bitcoin-gold

A Bitcoin Gold docker image.

[![uphold/bitcoin-gold][docker-pulls-image]][docker-hub-url] [![uphold/bitcoin-gold][docker-stars-image]][docker-hub-url] [![uphold/bitcoin-gold][docker-size-image]][docker-hub-url] [![uphold/bitcoin-gold][docker-layers-image]][docker-hub-url]

## Tags

- `0.17.3-alpine`, `0.17-alpine`, `alpine`, `latest` ([0.17/alpine/Dockerfile](https://github.com/uphold/docker-bitcoin-gold/blob/master/0.17/alpine/Dockerfile))
- `0.17.3`, `0.17`  ([0.17/Dockerfile](https://github.com/uphold/docker-bitcoin-gold/blob/master/0.17/Dockerfile))
- `0.15.2-alpine`, `0.15-alpine`, `alpine`, `latest` ([0.15/alpine/Dockerfile](https://github.com/uphold/docker-bitcoin-gold/blob/master/0.15/alpine/Dockerfile))
- `0.15.2`, `0.15`  ([0.15/Dockerfile](https://github.com/uphold/docker-bitcoin-gold/blob/master/0.15/Dockerfile))

## What is Bitcoin Gold?

Bitcoin Gold is a fork of the Bitcoin blockchain. At block 491407, Bitcoin Gold miners began creating blocks with a new proof-of-work algorithm, and this caused a bifurcation of the Bitcoin blockchain. The new branch is a distinct blockchain with the same transaction history as Bitcoin up until the fork, but then diverges from it. As a result of this process, a new cryptocurrency was born. Learn more about [Bitcoin Gold](https://bitcoingold.org).

## Usage

### How to use this image

This image contains the main binaries from the Bitcoin Gold project - `bgoldd`, `bgold-cli` and `bitcoin-tx`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `bgoldd` binary:

```sh
❯ docker run --rm -it uphold/bitcoin-gold \
  -printtoconsole \
  -regtest=1 \
  -rpcallowip=172.17.0.0/16 \
  -rpcpassword=bar \
  -rpcuser=foo
```

By default, `bgoldd` will run as user `bitcoingold` for security reasons and with its default data dir (`~/.bitcoingold/`). If you'd like to customize where `bitcoin-gold` stores its data, you must use the `BITCOIN_GOLD_DATA` environment variable. The directory will be automatically created with the correct permissions for the `bitcoingold` user and `bitcoin-gold` automatically configured to use it.

```sh
❯ docker run --env BITCOIN_GOLD_DATA=/var/lib/bgold --rm -it uphold/bitcoin-gold \
  -printtoconsole \
  -regtest=1
```

You can also mount a directory it in a volume under `/home/bitcoingold/.bitcoingold` in case you want to access it on the host:

```sh
❯ docker run -v ${PWD}/data:/home/bitcoingold/.bitcoingold -it --rm uphold/bitcoin-gold \
  -printtoconsole \
  -regtest=1
```

You can optionally create a service using `docker-compose`:

```yml
bitcoin-gold:
  image: uphold/bitcoin-gold
  command:
    -printtoconsole
    -regtest=1
```

### Using RPC to interact with the daemon

There are two communications methods to interact with a running Bitcoin Gold daemon.

The first one is using a cookie-based local authentication. It doesn't require any special authentication information as running a process locally under the same user that was used to launch the Bitcoin Gold daemon allows it to read the cookie file previously generated by the daemon for clients. The downside of this method is that it requires local machine access.

The second option is making a remote procedure call using a username and password combination. This has the advantage of not requiring local machine access, but in order to keep your credentials safe you should use the newer `rpcauth` authentication mechanism.

#### Using cookie-based local authentication

Start by launching the Bitcoin Gold daemon:

```sh
❯ docker run --rm --name bitcoin-gold-server -it uphold/bitcoin-gold \
  -printtoconsole \
  -regtest=1
```

Then, inside the running `bitcoin-gold-server` container, locally execute the query to the daemon using `bgold-cli`:

```sh
❯ docker exec --user bitcoingold bitcoin-gold-server bgold-cli -regtest getmininginfo

{
  "blocks": 0,
  "currentblocksize": 0,
  "currentblockweight": 0,
  "currentblocktx": 0,
  "difficulty": 4.656542373906925e-10,
  "errors": "",
  "networkhashps": 0,
  "pooledtx": 0,
  "chain": "regtest"
}
```

In the background, `bgold-cli` read the information automatically from `/home/bitcoingold/.bitcoingold/regtest/.cookie`. In production, the path would not contain the regtest part.

#### Using rpcauth for remote authentication

Before setting up remote authentication, you will need to generate the `rpcauth` line that will hold the credentials for the Bitcoin Gold daemon. You can either do this yourself by constructing the line with the format `<user>:<salt>$<hash>` or use the official `rpcuser.py` script to generate this line for you, including a random password that is printed to the console.

Example:

```sh
❯ curl -sSL https://raw.githubusercontent.com/BTCGPU/BTCGPU/master/share/rpcuser/rpcuser.py | python - <username>

String to be appended to bitcoin.conf:
rpcauth=foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc
Your password:
qDDZdeQ5vw9XXFeVnXT4PZ--tGN2xNjjR4nrtyszZx0=
```

Note that for each run, even if the username remains the same, the output will be always different as a new salt and password are generated.
