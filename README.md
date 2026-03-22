# CppUTest Docker

A base Docker image for TDD development with GCC and [CppUTest](http://cpputest.github.io/). Suitable for use across multiple C/C++ projects.

## Contents

- GCC 14 (via the official `gcc:14` base image)
- CppUTest v4.0
- CMake
- [James Grenning's legacy-build toolkit](https://github.com/jwgrenning/legacy-build)
- autoconf, automake, libtool

## Usage

Run tests by mounting your project directory (containing your `CMakeLists.txt` or `Makefile`) to `/home/src`:

```
docker run -v <path>:/home/src davidcozens/cpputest make
```

Where `<path>` is the fully qualified path to your project folder.

The `CPPUTEST_HOME` environment variable is set to `/home/cpputest` inside the container.

## Building

The image is built automatically via Docker Hub on each push to the `main` branch.

To build locally:

```
docker build -t cpputest .
```
