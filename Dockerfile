FROM ubuntu

MAINTAINER Kibaek Kim "kimk@anl.gov"

RUN apt-get update

# Prerequisites for DSP
RUN apt-get install -y libmpich-dev
RUN apt-get install -y cmake
RUN apt-get install -y libblas-dev
RUN apt-get install -y liblapack-dev
RUN apt-get install -y subversion
RUN apt-get install -y build-essential
RUN apt-get install -y autoconf
RUN apt-get install -y automake
RUN apt-get install -y libbz2-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y xutils-dev

# Install python 
RUN apt-get install -y python
RUN apt-get install -y libpython-dev
RUN apt-get install -y python-pip

# for Python interface
RUN pip install --upgrade pip
RUN pip install mpi4py
RUN apt-get install -y swig

# Install Julia
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN add-apt-repository ppa:staticfloat/julia-deps
RUN apt-get install -y julia

# Julia packages
RUN julia -e 'Pkg.add("MathProgBase")'
RUN julia -e 'Pkg.add("JuMP")'
RUN julia -e 'Pkg.update()'
RUN julia -e 'using JuMP'