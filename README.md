# CppUTest Docker

This repository contains the docker file and jenkins file for creating a docker image for running CppuTest code with gcc. The container is derived from my GoogleTest docker image, as CppuTest can also run GoogleTests.

* http://cpputest.github.io/
* https://github.com/google/googletest

As well as the test framework the image includeds James Grenning's legacy build toolkit

* https://github.com/jwgrenning/legacy-build
  
To run tests execute the command below where <path> is the fully qualified path to the folder with your makefile and code.  
  
docker run -v <path>:/mnt davidcozens/cpputest make

NOTE: The specific version of the image can also be referenced in build commands as davidcozens/cpputest:n where n is the build number
