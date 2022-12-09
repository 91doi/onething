
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