FROM opensuse

MAINTAINER Kibaek Kim "kimk@anl.gov"

RUN zypper update -y
RUN zypper install --no-recommends -y gcc gcc-c++ gcc-fortran git
RUN zypper install --no-recommends -y cmake blas-devel lapack-devel subversion make autoconf automake libbz2-devel zlib-devel

# MPI
RUN zypper install --no-recommends -y openmpi openmpi-devel openmpi-libs
ENV PATH=$PATH:/usr/lib64/mpi/gcc/openmpi/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/mpi/gcc/openmpi/lib64


# Install Julia
RUN zypper install --no-recommends -y julia

# Additional library and settings For Julia
RUN zypper install -y libopenlibm1
RUN zypper install --no-recommends -y libcholmod-3_0_6
RUN ln -s /usr/lib64/libcholmod-3.0.6.so /usr/lib64/libcholmod.so
RUN ln -s /usr/lib64/libsuitesparseconfig-4.4.5.so /usr/lib64/libsuitesparseconfig.so

# Julia packages
RUN julia -e 'Pkg.add("MathProgBase")'
RUN julia -e 'Pkg.add("JuMP")'
RUN julia -e 'Pkg.add("MPI")'
RUN julia -e 'Pkg.clone("http://github.com/kibaekkim/Dsp.jl")'
RUN julia -e 'Pkg.update()'
RUN julia -e 'using JuMP, MPI'