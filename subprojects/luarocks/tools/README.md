## Tools

- [7z](https://www.7-zip.org/download.html)
- [coreutils](https://github.com/uutils/coreutils)
- [fd](https://github.com/sharkdp/fd)

```bash
$ git clone https://github.com/uutils/coreutils
$ cd coreutils
$ git checkout 0.0.16
$ cargo build --release --features "cp ls hashsum" --no-default-features
```
