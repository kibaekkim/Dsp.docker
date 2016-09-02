FROM centos:7

MAINTAINER Kibaek Kim "kimk@anl.gov"

RUN yum -y update
RUN yum -y install git gcc gcc-c++ gcc-gfortran kernel-devel
RUN yum -y install cmake blas-devel lapack-devel subversion make autoconf automake bzip2-devel zlib-devel

# Install MPI
RUN yum -y install mpich
RUN yum -y install mpich-devel
RUN yum -y install mpich-autoload

# Install Julia
RUN yum -y install wget
RUN wget https://copr.fedorainfracloud.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo
RUN mv nalimilan-julia-epel-7.repo /etc/yum.repos.d/
RUN yum -y install epel-release
RUN yum -y install julia

# Julia packages
RUN julia -e 'Pkg.add("MathProgBase")'
RUN julia -e 'Pkg.add("JuMP")'
RUN source /etc/profile.d/modules.sh; module load mpi; julia -e 'Pkg.add("MPI")'
RUN julia -e 'Pkg.clone("http://github.com/kibaekkim/Dsp.jl")'
RUN julia -e 'Pkg.update()'
RUN julia -e 'using JuMP, MPI'