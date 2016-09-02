FROM base/archlinux

MAINTAINER Kibaek Kim "kimk@anl.gov"

RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Su openmpi gcc gcc-fortran git blas lapack make autoconf automake subversion cmake bzip2 zlib julia

RUN pacman-db-upgrade
RUN trust extract-compat

# Julia packages
RUN julia -e 'Pkg.add("MathProgBase")'
RUN julia -e 'Pkg.add("JuMP")'
RUN julia -e 'Pkg.add("MPI")'
RUN julia -e 'Pkg.clone("http://github.com/kibaekkim/Dsp.jl")'
RUN julia -e 'Pkg.update()'
RUN julia -e 'using JuMP, MPI'