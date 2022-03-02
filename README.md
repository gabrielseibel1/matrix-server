# Pi Matrix Conduit

A matrix server using [Conduit](https://github.com/timokoesters/conduit), hosted at [pimatrixconduit.xyz](https://pimatrixconduit.xyz)

## Simple Usage

Please check the usage tutorial [here](docs/usage.md) to get ready to chat :D

## Installation (development)

You may ignore this section if you're a regular user.

If you're a developer running this project, you can build and install it as follows:

```
git submodule init
git submodule update
sudo apt install python3-markdown
make compile_html # compiles some files (e.g. MD -> HTML)
sudo make install # compiles conduit and moves files for webserver expectations
```
