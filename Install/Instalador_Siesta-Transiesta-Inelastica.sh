#!/bin/bash

############################################################################################################################
#DEVELOPER: REIS-SILVA                                                                                                     #
#LINK YOUTUBE: https://www.youtube.com/watch?v=af9cmUdHDJ8                                                                 #
#LINK GITHUB: https://github.com/Reis-Silva/Install_Use-Siesta-Transiesta-Inelastica                                       #
#LINK GITLAB SIESTA: https://gitlab.com/siesta-project/siesta                                                              #
#                                                                                                                          #
#                                                                                                                          #
#                                                                                                                          #
#Opções de instalação completa na interface do programa:                                                                   #
#[1] - Todos os Pacotes essenciais                                                                                         #
#[2] - Siesta/Transiesta - OBS: Todos os programas UTILS compilados!                                                       #
#[3] - Inelastica                                                                                                          #
#                                                                                                                          #
#OBS: Versão Generalizada do Ubuntu e algumas outras versões derivadas do Debian provavelmente (Testado com Linux Mint)    #
#OBS2: Realizando testes com openSUSE 15.2 ainda                                                                           #
#OBS3: Lembre-se quando terminar de instalar tudo, feche e abra o terminal de novo para poder emular(reload .bashrs)       #
#                                                                                                                          #
#                                                                                                                          #
#                                                                                                                          #
#                                                                                                                          #
#                                                                                                                          #
############################################################################################################################

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo rm /var/lib/dpkg/lock-frontend


linuxSistema="$(uname -r -s )"

if [ "$linuxSistema" = "Linux 5.3.18-lp152.33-default" ]; then
    sudo zypper --non-interactive install lsb-release
    raizInstalacao="$(pwd)"
    versionSistema="$(lsb_release -d -s)"
    nomeSistema=${versionSistema:1:8}
    numeracaoSistema="$(lsb_release -r -s)"
    
else
    raizInstalacao="$(pwd)"
    versionSistema="$(lsb_release -d -s)"
    numeracaoSistema="$(lsb_release -r -s)"
fi

if [ "$nomeSistema" = "openSUSE" ]; then

    touch .Xauthority
    xauth merge ~brainiac/.Xauthority
    export DISPLAY=:0.0
    comandoInicialSistema="sudo zypper --non-interactive install"
    comandoFinalSistema=" "
    comandoInicialLinha="-e"
    atualizacaoPacotes="zypper --non-interactive up"

    echo $comandoInicialLinha $comandoInicialLinha "SISTEMA $versionSistema\nAdicionando pacotes...\n\n"

    $comandoInicialSistema dpkg
    sudo dpkg --configure -a
    $comandoInicialSistema wget
    $comandoInicialSistema unzip
    $comandoInicialSistema make
    zypper addrepo -f https://ftp.lysator.liu.se/pub/opensuse/repositories/GNOME:/Apps/openSUSE_Leap_15.1/ gnome-apps-x86_64
    zypper --gpg-auto-import-keys refresh
    $comandoInicialSistema yad

else

    comandoInicialSistema="sudo apt-get install"
    comandoFinalSistema="-y"
    comandoInicialLinha=" "
    atualizacaoPacotes="sudo apt-get update && sudo apt-get dist-upgrade $comandoFinalSistema"

    echo $comandoInicialLinha $comandoInicialLinha "SISTEMA $versionSistema\nAdicionando pacotes...\n\n"

    sudo dpkg --configure -a
    $comandoInicialSistema make
    $comandoInicialSistema unzip
    $comandoInicialSistema synaptic $comandoFinalSistema
    $comandoInicialSistema yad $comandoFinalSistema

    #Ativando repositorio canoninal e adicionando repositorios
    echo $comandoInicialLinha "ativando repositorio canoninal e adicionando repositorios\n\n"
    sudo sed -i.bak "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test $comandoFinalSistema
    echo $comandoInicialLinha "\n\n"

fi

Instalacao_PacotesEssenciais_Geral() {
    ####INSTALATAÇÃO DE PACOTES INICIAIS PARA SIESTA/TRANSIESTA - ARQUITETURA AMD64####
    echo $comandoInicialLinha '\033[05;33m####INSTALATAÇÃO DE PACOTES INICIAIS PARA SIESTA/TRANSIESTA - ARQUITETURA AMD64####\033[00;00m'

    ###Atualização do repositorio e Atualização de pacotes para a versão mais recente####
    echo $comandoInicialLinha "###Atualização do repositorio e Atualização de pacotes para a versão mais recente####\n\n"
    $atualizacaoPacotes

    # Removendo processos anteriores
    echo $comandoInicialLinha "\n\nRemovendo processos anteriores \n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then
        zypper --non-interactive clean
    else
        sudo apt-get clean $comandoFinalSistema
    fi

    sudo rm /var/lib/apt/lists/lock
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
    sudo rm /var/lib/dpkg/lock-frontend
    echo $comandoInicialLinha "\n\n"

    # Instalando programas essenciais de instalação
    echo $comandoInicialLinha "#Instalando programas essenciais de instalação\n\n"

    echo $comandoInicialLinha "##wget\n\n"
    $comandoInicialSistema wget $comandoFinalSistema #instalando para baixar direito de sites
    echo $comandoInicialLinha "\n\n"

    echo $comandoInicialLinha "##unzip\n\n"
    $comandoInicialSistema unzip $comandoFinalSistema
    echo $comandoInicialLinha "\n\n"

    echo $comandoInicialLinha "##python3-tk\n\n"
    $comandoInicialSistema python3-tk $comandoFinalSistema
    echo $comandoInicialLinha "\n\n"

    echo $comandoInicialLinha "##python3\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then
        $comandoInicialSistema python3 $comandoFinalSistema
        $comandoInicialSistema python3-devel $comandoFinalSistema

    else
        $comandoInicialSistema python3 $comandoFinalSistema
        $comandoInicialSistema python3-dev $comandoFinalSistema
    fi

    echo $comandoInicialLinha "\n\n"

    echo $comandoInicialLinha "##python3-pip\n\n"
    $comandoInicialSistema python3-pip $comandoFinalSistema
    echo $comandoInicialLinha "\n\n"

    ####PACOTES A SEREM INSTALADOS####
    echo $comandoInicialLinha "#####PACOTES A SEREM INSTALADOS####\n\n"

    #PACOTE gfortran
    echo $comandoInicialLinha "#PACOTE gfortran - 1 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then
        $comandoInicialSistema gcc-fortran gcc-c++ gcc9$comandoFinalSistema
    else
        $comandoInicialSistema g++ $comandoFinalSistema
        $comandoInicialSistema gfortran $comandoFinalSistema
        $comandoInicialSistema gfortran-10 $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE m4
    echo $comandoInicialLinha "#PACOTE m4 - 2 de 10\n\n"
    $comandoInicialSistema m4 $comandoFinalSistema
    echo $comandoInicialLinha "\n\n"

    #PACOTE bcc
    echo $comandoInicialLinha "#PACOTE bcc - 3 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        $comandoInicialSistema bcc-devel $comandoFinalSistema

    else
        $comandoInicialSistema bcc bpfcc-tools $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE CCCC
    echo $comandoInicialLinha "#PACOTE CCCC - 4 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then
        zypper addrepo -f zypper addrepo https://download.opensuse.org/repositories/home:illuusio/openSUSE_Leap_15.2/home:illuusio.repo
        zypper --gpg-auto-import-keys refresh
        $comandoInicialSistema cccc $comandoFinalSistema
    else
        $comandoInicialSistema cccc $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE fcc
    echo $comandoInicialLinha "#PACOTE fcc - 5 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then
        echo " "
    else
        $comandoInicialSistema fcc $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE GPAW e suas dependencias
    echo $comandoInicialLinha "#PACOTE GPAW e suas dependencias - 6 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        zypper addrepo -f https://ftp.lysator.liu.se/pub/opensuse/repositories/science/openSUSE_Leap_15.2/ science-x86_64
        zypper addrepo -f https://download.opensuse.org/repositories/science/openSUSE_Leap_15.2/science.repo
        zypper addrepo -f https://download.opensuse.org/repositories/Education/openSUSE_Leap_15.2/Education.repo
        zypper addrepo -f https://download.opensuse.org/repositories/home:eeich:hpc/openSUSE_Factory/home:eeich:hpc.repo
        zypper addrepo -f https://download.opensuse.org/repositories/devel:languages:python/openSUSE_Leap_15.2/devel:languages:python.repo
        zypper --gpg-auto-import-keys refresh

        $comandoInicialSistema zypper install libopenblas_pthreads0 $comandoFinalSistema
        $comandoInicialSistema libopenblas_pthreads-devel $comandoFinalSistema
        $comandoInicialSistema openblas-devel $comandoFinalSistema
        $comandoInicialSistema libscalapack2-mvapich2 $comandoFinalSistema

        #wget -c https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.6.tar.gz
        #tar vxf -o openmpi-3.1.6.tar.gz
        #cd openmpi-3.1.6
        #./configure --prefix=$HOME/opt/usr/local
        #make all
        #make install
        #cd ..
        $comandoInicialSistema cairo-devel python-pycairo-common-devel$comandoFinalSistema
        $comandoInicialSistema libtool $comandoFinalSistema
        $comandoInicialSistema lapack $comandoFinalSistema
        $comandoInicialSistema openmpi $comandoFinalSistema
        $comandoInicialSistema openmpi3-devel $comandoFinalSistema
        $comandoInicialSistema openmpi3-gnu-hpc-devel $comandoFinalSistema
        $comandoInicialSistema lam lam-devel $comandoFinalSistema
        $comandoInicialSistema libxc-devel $comandoFinalSistema
        $comandoInicialSistema libfftw3-3 $comandoFinalSistema
        $comandoInicialSistema mpich $comandoFinalSistema
        $comandoInicialSistema automake autoconf libtool $comandoFinalSistema
        pip install --upgrade pip
        pip install numpy scipy matplotlib
        pip install --upgrade --user ase
        $comandoInicialSistema python3-wheel $comandoFinalSistema

        wget -c https://salsa.debian.org/debichem-team/gpaw/-/archive/master/gpaw-master.zip
        sudo unzip -o gpaw-master.zip
        cd gpaw-master
        sed -i "68cmpicompiler = 'gcc'" setup.py
        sed -i "69cmpilinker = 'gcc'" setup.py
        sed -i "71cerror = subprocess.call(['which', 'gcc'], stdout=subprocess.PIPE)" setup.py
        python3 setup.py install
        cd ..

    else

        $comandoInicialSistema libopenblas-dev libxc-dev libscalapack-mpi-dev libfftw3-dev $comandoFinalSistema

        ##DEPEDENCIAS VARIADAS DE python e python3
        $comandoInicialSistema libhdf5-dev $comandoFinalSistema
        $comandoInicialSistema python3-numpy python3-scipy python3-matplotlib $comandoFinalSistema
        $comandoInicialSistema python3-netcdf4 $comandoFinalSistema

        $comandoInicialSistema python-scipy python-matplotlib python-netcdf4 $comandoFinalSistema
        pacote=$(dpkg --get-selections | grep python-scipy)
        pacote2=$(dpkg --get-selections | grep python-matplotlib)
        pacote3=$(dpkg --get-selections | grep python-netcdf4)

        if [ -n "$pacote" ] && [ -n "$pacote2" ] && [ -n "$pacote3" ]; then

            $comandoInicialSistema python-tk $comandoFinalSistema
            $comandoInicialSistema python-numpy $comandoFinalSistema
            $comandoInicialSistema python $comandoFinalSistema
            $comandoInicialSistema python-dev $comandoFinalSistema
            echo $comandoInicialLinha "\n\nPacotes $pacote $pacote2 $pacote3 Encontrados\n\n"
            apt-mark hold libpython-dbg libpython-dev python python-dbg python-dev python-h5py python-mpi4py python-netcdf4 python-numpy-dbg python-scipy python-scipy-dbg

        else
            echo $comandoInicialLinha "\n\nPacotes $pacote $pacote2 $pacote3 não Encontrados\nBaixando por outras fontes...\n\n"
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/a/aglfn/aglfn_1.7+git20191031.4036a9c-2_all.deb
            sudo dpkg -i aglfn_1.7+git20191031.4036a9c-2_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gnuplot/gnuplot-data_5.2.8+dfsg1-2_all.deb
            sudo dpkg -i gnuplot-data_5.2.8+dfsg1-2_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/d/double-conversion/libdouble-conversion3_3.1.5-4ubuntu1_amd64.deb
            sudo dpkg -i libdouble-conversion3_3.1.5-4ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/p/pcre2/libpcre2-16-0_10.34-7_amd64.deb
            sudo dpkg -i libpcre2-16-0_10.34-7_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5core5a_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5core5a_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5dbus5_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5dbus5_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5network5_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5network5_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/libx/libxcb/libxcb-xinerama0_1.14-2_amd64.deb
            sudo dpkg -i libxcb-xinerama0_1.14-2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/libx/libxcb/libxcb-xinput0_1.14-2_amd64.deb
            sudo dpkg -i libxcb-xinput0_1.14-2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5gui5_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5gui5_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5widgets5_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5widgets5_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtbase-opensource-src/libqt5printsupport5_5.12.8+dfsg-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5printsupport5_5.12.8+dfsg-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/q/qtsvg-opensource-src/libqt5svg5_5.12.8-0ubuntu1_amd64.deb
            sudo dpkg -i libqt5svg5_5.12.8-0ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/w/wxwidgets3.0/libwxbase3.0-0v5_3.0.4+dfsg-15build1_amd64.deb
            sudo dpkg -i libwxbase3.0-0v5_3.0.4+dfsg-15build1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/w/wxwidgets3.0/libwxgtk3.0-gtk3-0v5_3.0.4+dfsg-15build1_amd64.deb
            sudo dpkg -i libwxgtk3.0-gtk3-0v5_3.0.4+dfsg-15build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/main/l/lua5.3/liblua5.3-0_5.3.3-1.1ubuntu2_amd64.deb
            sudo dpkg -i liblua5.3-0_5.3.3-1.1ubuntu2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gnuplot/gnuplot-qt_5.2.8+dfsg1-2_amd64.deb
            sudo dpkg -i gnuplot-qt_5.2.8+dfsg1-2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gnuplot/gnuplot_5.2.8+dfsg1-2_all.deb #instalando GNUplot
            sudo dpkg -i gnuplot_5.2.8+dfsg1-2_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-minimal_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i libpython2.7-minimal_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/python2.7-minimal_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i python2.7-minimal_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python2-minimal_2.7.16-1_amd64.deb
            sudo dpkg -i python2-minimal_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python-minimal_2.7.16-1_amd64.deb
            sudo dpkg -i python-minimal_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/libf/libffi/libffi6_3.2.1-9_amd64.deb
            sudo dpkg -i libffi6_3.2.1-9_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/r/readline/libreadline7_7.0-5_amd64.deb
            sudo dpkg -i libreadline7_7.0-5_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-stdlib_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i libpython2.7-stdlib_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/python2.7_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i python2.7_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython2-stdlib_2.7.16-1_amd64.deb
            sudo dpkg -i libpython2-stdlib_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython-stdlib_2.7.16-1_amd64.deb
            sudo dpkg -i libpython-stdlib_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python2_2.7.16-1_amd64.deb
            sudo dpkg -i python2_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python_2.7.16-1_amd64.deb
            sudo dpkg -i python_2.7.16-1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/e/elpa/libelpa4_2016.05.001-6build1_amd64.deb
            sudo dpkg -i libelpa4_2016.05.001-6build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/e/elpa/libelpa-dev_2016.05.001-6build1_amd64.deb
            sudo dpkg -i libelpa-dev_2016.05.001-6build1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-setuptools/python-pkg-resources_40.8.0-1_all.deb
            sudo dpkg -i python-pkg-resources_40.8.0-1_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-numpy/python-numpy_1.16.2-1_amd64.deb
            sudo dpkg -i python-numpy_1.16.2-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/u/underscore/libjs-underscore_1.9.1~dfsg-1_all.deb
            sudo dpkg -i libjs-underscore_1.9.1~dfsg-1_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/s/sphinx/libjs-sphinxdoc_1.8.4-1_all.deb
            sudo dpkg -i libjs-sphinxdoc_1.8.4-1_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-numpy/python-numpy-doc_1.16.2-1_all.deb
            sudo dpkg -i python-numpy-doc_1.16.2-1_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dbg_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i libpython2.7-dbg_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython2-dbg_2.7.16-1_amd64.deb
            sudo dpkg -i libpython2-dbg_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython-dbg_2.7.16-1_amd64.deb
            sudo dpkg -i libpython-dbg_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/python2.7-dbg_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i python2.7-dbg_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python2-dbg_2.7.16-1_amd64.deb
            sudo dpkg -i python2-dbg_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python-dbg_2.7.16-1_amd64.deb
            sudo dpkg -i python-dbg_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-numpy/python-numpy-dbg_1.16.2-1_amd64.deb
            sudo dpkg -i python-numpy-dbg_1.16.2-1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/s/six/python-six_1.12.0-2_all.deb
            sudo dpkg -i python-six_1.12.0-2_all.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/hdf5/libhdf5-openmpi-103_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-openmpi-103_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/mpi4py/python-mpi4py_3.0.2-13_amd64.deb
            sudo dpkg -i python-mpi4py_3.0.2-13_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/h5py/python-h5py_2.9.0-7_amd64.deb
            sudo dpkg -i python-h5py_2.9.0-7_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-setuptools/python-pkg-resources_44.0.0-3_all.deb
            sudo dpkg -i python-pkg-resources_44.0.0-3_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-setuptools/python-setuptools_44.0.0-3_all.deb
            sudo dpkg -i python-setuptools_44.0.0-3_all.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i libpython2.7_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython2-dev_2.7.16-1_amd64.deb
            sudo dpkg -i libpython2-dev_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/libpython-dev_2.7.16-1_amd64.deb
            sudo dpkg -i libpython-dev_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python2.7/python2.7-dev_2.7.16-2+deb10u1_amd64.deb
            sudo dpkg -i python2.7-dev_2.7.16-2+deb10u1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python2-dev_2.7.16-1_amd64.deb
            sudo dpkg -i python2-dev_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/p/python-defaults/python-dev_2.7.16-1_amd64.deb
            sudo dpkg -i python-dev_2.7.16-1_amd64.deb
            wget -c http://ftp.us.debian.org/debian/pool/main/libf/libffi/libffi-dev_3.2.1-9_amd64.deb
            sudo dpkg -i libffi-dev_3.2.1-9_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/c/cython/cython_0.29.14-0.1ubuntu3_amd64.deb
            sudo dpkg -i cython_0.29.14-0.1ubuntu3_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/netcdf/libnetcdf13_4.6.2-1build1_amd64.deb
            sudo dpkg -i libnetcdf13_4.6.2-1build1_amd64.deb
            wget -c http://ftp.br.debian.org/debian/pool/main/c/cftime/python-cftime_1.0.3.4-1_amd64.deb
            sudo dpkg -i python-cftime_1.0.3.4-1_amd64.deb
            wget -c http://ftp.br.debian.org/debian/pool/main/n/netcdf4-python/python-netcdf4_1.4.2-1+b1_amd64.deb
            sudo dpkg -i python-netcdf4_1.4.2-1+b1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/p/python-decorator/python-decorator_4.3.0-1.1_all.deb
            sudo dpkg -i python-decorator_4.3.0-1.1_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/p/python-scipy/python-scipy_1.2.2-4_amd64.deb
            sudo dpkg -i python-scipy_1.2.2-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/p/python-scipy/python-scipy-dbg_1.2.2-4_amd64.deb
            sudo dpkg -i python-scipy-dbg_1.2.2-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/m/mathjax/fonts-mathjax_2.7.4+dfsg-1_all.deb
            sudo dpkg -i fonts-mathjax_2.7.4+dfsg-1_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/m/mathjax/libjs-mathjax_2.7.4+dfsg-1_all.deb
            sudo dpkg -i libjs-mathjax_2.7.4+dfsg-1_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/p/python-scipy/python-scipy-doc_1.2.2-4_all.deb
            sudo dpkg -i python-scipy-doc_1.2.2-4_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/libh/libhdf4/libhdf4-0_4.2.10-3.2_amd64.deb
            sudo dpkg -i libhdf4-0_4.2.10-3.2_amd64.deb
            wget -c http://security.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.23-0ubuntu11.2_amd64.deb
            sudo dpkg -i multiarch-support_2.23-0ubuntu11.2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/libm/libmatheval/libmatheval1_1.1.11+dfsg-2_amd64.deb
            sudo dpkg -i libmatheval1_1.1.11+dfsg-2_amd64.deb
            wget -c http://ppa.launchpad.net/linuxuprising/libpng12/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1+1~ppa0~focal_amd64.deb
            sudo dpkg -i libpng12-0_1.2.54-1ubuntu1.1+1~ppa0~focal_amd64.deb
            wget -c http://security.ubuntu.com/ubuntu/pool/main/g/gcc-5/gcc-5-base_5.4.0-6ubuntu1~16.04.12_amd64.deb
            sudo dpkg -i gcc-5-base_5.4.0-6ubuntu1~16.04.12_amd64.deb
            wget -c http://security.ubuntu.com/ubuntu/pool/main/g/gcc-5/libgfortran3_5.4.0-6ubuntu1~16.04.12_amd64.deb
            sudo dpkg -i libgfortran3_5.4.0-6ubuntu1~16.04.12_amd64.deb
            wget -c http://security.ubuntu.com/ubuntu/pool/universe/h/hdf5/libhdf5-10_1.8.16+docs-4ubuntu1.1_amd64.deb
            sudo dpkg -i libhdf5-10_1.8.16+docs-4ubuntu1.1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/h5utils/h5utils_1.12.1-4_amd64.deb
            sudo dpkg -i h5utils_1.12.1-4_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/s/sip4/python3-sip_4.19.21+dfsg-1build1_amd64.deb
            sudo dpkg -i python3-sip_4.19.21+dfsg-1build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/w/wxpython4.0/python3-wxgtk4.0_4.0.7+dfsg-2build1_amd64.deb
            sudo dpkg -i python3-wxgtk4.0_4.0.7+dfsg-2build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/mpi4py/python3-mpi4py_3.0.3-4build2_amd64.deb
            sudo dpkg -i python3-mpi4py_3.0.3-4build2_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/h5py/python3-h5py_2.10.0-2build2_amd64.deb
            sudo dpkg -i python3-h5py_2.10.0-2build2_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/hdf-compass/python3-hdf-compass_0.7~b8-2_all.deb
            sudo dpkg -i python3-hdf-compass_0.7~b8-2_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf-compass/hdf-compass_0.7~b8-2_all.deb
            sudo dpkg -i hdf-compass_0.7~b8-2_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf-compass/hdf-compass-doc_0.7~b8-2_all.deb
            sudo dpkg -i hdf-compass-doc_0.7~b8-2_all.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-openmpi-dev_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-openmpi-dev_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-mpi-dev_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-mpi-dev_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hwloc/hwloc-nox_2.1.0+dfsg-4_amd64.deb
            sudo dpkg -i hwloc-nox_2.1.0+dfsg-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/m/mpich/libmpich12_3.3.2-2build1_amd64.deb
            sudo dpkg -i libmpich12_3.3.2-2build1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-mpich-103_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-mpich-103_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/mpich/mpich_3.3.2-2build1_amd64.deb
            sudo dpkg -i mpich_3.3.2-2build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/mpich/libmpich-dev_3.3.2-2build1_amd64.deb
            sudo dpkg -i libmpich-dev_3.3.2-2build1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-mpich-dev_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-mpich-dev_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-doc_1.10.0-patch1+docs-4_all.deb
            sudo dpkg -i libhdf5-doc_1.10.0-patch1+docs-4_all.deb
            $comandoInicialSistema python-tk $comandoFinalSistema
            apt-mark hold libpython-dbg libpython-dev python python-cftime python-dbg python-dev python-h5py python-mpi4py python-netcdf4 python-numpy-dbg python-scipy python-scipy-dbg python2-dbg python2-dev
        fi

        $comandoInicialSistema gpaw $comandoFinalSistema
        
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE abinit
    echo $comandoInicialLinha "#PACOTE abinit - 7 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        wget -c https://www.abinit.org/sites/default/files/packages/abinit-8.10.2.tar.gz
        tar vxf abinit-8.10.2.tar.gz
        cd abinit-8.10.2
        ./configure
        make
        make install
        cd ..

    else

        $comandoInicialSistema abinit $comandoFinalSistema

        pacote=$(dpkg --get-selections | grep abinit)

        if [ -n "$pacote" ]; then

            echo $comandoInicialLinha "\n\nPacote $pacote Encontrado"

        else

            echo $comandoInicialLinha "\n\nPacote $pacote não Encontrado\nBaixando por outras fontes...\n\n"
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/a/abinit/abinit-data_8.10.2-2_all.deb
            sudo dpkg -i abinit-data_8.10.2-2_all.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/a/abinit/abinit_8.10.2-2_amd64.deb
            sudo dpkg -i abinit_8.10.2-2_amd64.deb

        fi

    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE quantum-espresso
    echo $comandoInicialLinha "#PACOTE quantum-espresso - 8 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        wget -c https://github.com/QEF/q-e/archive/qe-6.6.tar.gz
        tar vxf qe-6.6.tar.gz
        cd q-e-qe-6.6
        ./configure
        make all
        cd ..

    else
        $comandoInicialSistema quantum-espresso $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE meep-lam4
    echo $comandoInicialLinha "#PACOTE meep-lam4 - 9 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        $comandoInicialSistema meep $comandoFinalSistema

    else

        $comandoInicialSistema libhdf5-serial-dev $comandoFinalSistema
        $comandoInicialSistema hdf5-tools $comandoFinalSistema
        $comandoInicialSistema libatlas-base-dev $comandoFinalSistema
        $comandoInicialSistema libatlas-ecmwf-utils $comandoFinalSistema
        $comandoInicialSistema meep-lam4 $comandoFinalSistema

        pacote=$(dpkg --get-selections | grep meep-lam4)

        if [ -n "$pacote" ]; then

            echo $comandoInicialLinha "\n\nPacote $pacote Encontrado"

        else

            echo $comandoInicialLinha "\n\nPacote $pacote não Encontrado\nBaixando por outras fontes..."
            wget -c http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8-dev_2.0.3-0ubuntu1.20.04.1_amd64.deb
            sudo dpkg -i libjpeg-turbo8-dev_2.0.3-0ubuntu1.20.04.1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8-dev_8c-2ubuntu8_amd64.deb
            sudo dpkg -i libjpeg8-dev_8c-2ubuntu8_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg-dev_8c-2ubuntu8_amd64.deb
            sudo dpkg -i libjpeg-dev_8c-2ubuntu8_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/liba/libaec/libaec0_1.0.4-1_amd64.deb
            sudo dpkg -i libaec0_1.0.4-1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/liba/libaec/libsz2_1.0.4-1_amd64.deb
            sudo dpkg -i libsz2_1.0.4-1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/liba/libaec/libaec-dev_1.0.4-1_amd64.deb
            sudo dpkg -i libaec-dev_1.0.4-1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/hdf5-helpers_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i hdf5-helpers_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/libc/libctl/libctl7_4.4.0-3_amd64.deb
            sudo dpkg -i libctl7_4.4.0-3_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/l/lam/liblam4_7.1.4-6build1_amd64.deb
            sudo dpkg -i liblam4_7.1.4-6build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/a/atlas/libatlas3-base_3.10.3-8ubuntu7_amd64.deb
            sudo dpkg -i libatlas3-base_3.10.3-8ubuntu7_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb
            sudo dpkg -i libgslcblas0_2.5+dfsg-6_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb
            sudo dpkg -i libgsl23_2.5+dfsg-6_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/harminv/libharminv3_1.4.1-2_amd64.deb
            sudo dpkg -i libharminv3_1.4.1-2_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/h/hdf5/libhdf5-cpp-103_1.10.4+repack-11ubuntu1_amd64.deb
            sudo dpkg -i libhdf5-cpp-103_1.10.4+repack-11ubuntu1_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/m/meep-lam4/libmeep-lam4-12_1.7.0-3_amd64.deb
            sudo dpkg -i libmeep-lam4-12_1.7.0-3_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/o/openssh/openssh-client_8.2p1-4_amd64.deb
            sudo dpkg -i openssh-client_8.2p1-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/o/openssh/openssh-sftp-server_8.2p1-4_amd64.deb
            sudo dpkg -i openssh-sftp-server_8.2p1-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/main/o/openssh/openssh-server_8.2p1-4_amd64.deb
            sudo dpkg -i openssh-server_8.2p1-4_amd64.deb
            wget -c http://mirrors.kernel.org/ubuntu/pool/universe/l/lam/lam-runtime_7.1.4-6build1_amd64.deb
            sudo dpkg -i lam-runtime_7.1.4-6build1_amd64.deb
            wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/meep-lam4/meep-lam4_1.7.0-3_amd64.deb
            sudo dpkg -i meep-lam4_1.7.0-3_amd64.deb

        fi
        
    fi
    echo $comandoInicialLinha "\n\n"

    #PACOTE GaussSum e suas dependencias
    echo $comandoInicialLinha "#PACOTE GaussSum e suas dependencias - 10 de 10\n\n"

    if [ "$nomeSistema" = "openSUSE" ]; then

        wget -c https://sourceforge.net/projects/gausssum/files/gausssum3/GaussSum%203.0.2/GaussSum-3.0.2.tar.gz/download?use_mirror=ufpr&download=
        tar vxf GaussSum-3.0.2.tar.gz
        cd GaussSum-3.0.2
        ./configure
        make all
        cd ..

    else
        $comandoInicialSistema gausssum $comandoFinalSistema
    fi
    echo $comandoInicialLinha "\n\n"

    #Reatualização de repositorios e bibliotecas
    echo $comandoInicialLinha "#Reatualização de repositorios e bibliotecas\n\n"
    $atualizacaoPacotes
    echo $comandoInicialLinha "\n\n"

    ##FIM DAS INSTALAÇÕES DOS PACOTES ESSENCIAIS
    echo $comandoInicialLinha '\033[05;33m"#FIM DAS INSTALAÇÕES DOS PACOTES ESSENCIAIS"\033[00;00m\n\n'
    sleep 3

    cd $raizInstalacao
    sudo chmod -R 777 PackagesESSENCIAIS

}

InstalacaoPacotesEssenciaisIntermediario() {

    #if [ "`echo $comandoInicialLinha "${numeracaoSistema} >= 20.00" | bc`" -eq 1 ] && [ "`echo $comandoInicialLinha "${numeracaoSistema} < 21.00" | bc`" -eq 1 ]; then

    echo $comandoInicialLinha 'Instalando pacotes essenciais para versão: \033[05;33m'$versionSistema'\033[00;00m\n\n'
    sleep 2

    Instalacao_PacotesEssenciais_Geral

}

InstalacaoPacotesEssenciais() {

    if [ -e "PackagesESSENCIAIS" ]; then
        echo $comandoInicialLinha 'O DIRETÓRIO \033[32m"PackagesESSENCIAIS"\033[00m EXISTE
        \n\n MUDANDO O DIRETÓRIO ATUAL PARA: \033[05;33m"PackagesESSENCIAIS"\033[00;00m\n\n'
        sleep 2
        cd PackagesESSENCIAIS

        InstalacaoPacotesEssenciaisIntermediario

    else

        echo $comandoInicialLinha 'O DIRETÓRIO \033[32m"PackagesESSENCIAIS"\033[00m NÃO EXISTE
        \n\n CRIANDO O DIRETÓRIO: \033[05;33m"PackagesESSENCIAIS"\033[00;00m\n\n'
        mkdir PackagesESSENCIAIS
        cd PackagesESSENCIAIS
        sleep 2

        InstalacaoPacotesEssenciaisIntermediario

    fi
}

arch_make_UTILS() {

    cp arch.make archSIESTAORIGINAL.bkp

    #CONSTRUINDO O ARCH_MAKE DO SIESTA_UTILS
    echo $comandoInicialLinha "#CONSTRUINDO O ARCH_MAKE DO SIESTA_UTILS\n\n"

    cd ..

    cd Util
    sh build_all.sh
    echo $comandoInicialLinha "\n\n"

    ###COPIANDO OS PROGRAMAS DA PASTA UTILS DO SIESTA PARA A PASTA BIN DO SISTEMA
    echo $comandoInicialLinha "###COPIANDO O PROGRAMA TBtrans DA PASTA UTILS DO SIESTA PARA A PASTA BIN DO SISTEMA\n\n"
    echo $comandoInicialLinha '#OBS: Para outros software da pasta "UTILS" entre na pasta do programa e utilize o comando\033[05;33m"sudo cp NomeDoPrograma /usr/local/bin/NomeDoPrograma"\033[00;00m\n\n'
    sleep 3

    #PASTA TBtrans
    echo $comandoInicialLinha "#PASTA TBtrans\n\n"
    cd TS/TBtrans
    sudo cp -rf tbtrans /usr/local/bin/tbtrans
}

arch_make() {

    rm arch.make
    make clean
    cp gfortran.make gfortran.bkp

    #CONSTRUINDO O ARCH_MAKE DO GFORTRAN
    echo $comandoInicialLinha "#CONSTRUINDO O ARCH_MAKE DO GFORTRAN\n\n"

    sed -i '18s, unknown, SIESTA 4.1 - '"$versionSistema"',' gfortran.make
    sed -i "20s/CC = gcc/CPP = gcc -E -P -x c/" gfortran.make
    sed -i '22s, gfortran, mpif90,' gfortran.make
    sed -i "24s,^,\n,g" gfortran.make
    sed -i '25cFFTW_LIBS = -L\/usr\/lib\/x86_64-linux-gnu -lfftw3f -lfftw3\n' gfortran.make
    sed -i '26cFFTW_INCFLAGS = -I\/usr\/include\n\n' gfortran.make
    sed -i '28cHDF5_LIBS = -L'"$pathSIESTA"'\/siesta-master\/Docs\/build\/lib -lhdf5_hl -lhdf5\n' gfortran.make
    sed -i '29cHDF5_INCFLAGS = -I'"$pathSIESTA"'\/siesta-master\/Docs\/build\/include\n\n' gfortran.make
    sed -i '31cWITH_MPI=1\n' gfortran.make
    sed -i '32cWITH_NETCDF=1\n' gfortran.make
    sed -i '33cWITH_NCDF=1\n\n' gfortran.make
    sed -i '35cNETCDF_LIBS = -L'"$pathSIESTA"'\/siesta-master\/Docs\/build\/lib -lnetcdff -lnetcdf\n' gfortran.make
    sed -i '36cNETCDF_INCFLAGS = -I'"$pathSIESTA"'\/siesta-master\/Docs\/build\/include\n\n' gfortran.make
    sed -i '38cOTHER_LIBS = -L'"$pathSIESTA"'\/siesta-master\/Docs\/build\/lib -lz\n' gfortran.make
    sed -i '40s/FFLAGS = -O2 -fPIC -ftree-vectorize/FFLAGS = -g -O2 $(INCFLAGS) $(NETCDF_INCFLAGS) $(FFTW_INCFLAGS) $(HDF5_INCFLAGS)/' gfortran.make
    sed -i "53s,COMP_LIBS = libsiestaLAPACK.a libsiestaBLAS.a,COMP_LIBS = libncdf.a libfdict.a\n\n\n," gfortran.make
    sed -i "55s/^/LAPACK_LIBS = -llapack -lblas/" gfortran.make

    if [ -e "/usr/lib/x86_64-linux-gnu/libscalapack-openmpi.so" ]; then

        sed -i "56cSCALAPACK_LIBS = /usr/lib/x86_64-linux-gnu/libscalapack-openmpi.so\n\n" gfortran.make
        sed -i '62s/LIBS =/LIBS = $(SCALAPACK_LIBS) $(LAPACK_LIBS) $(INCFLAGS) $(NETCDF_LIBS) $(HDF5_LIBS) $(OTHER_LIBS) $(MPI_LIBS) -fopenmp\n\n\n/' gfortran.make

    elif [ -e "/usr/lib/libscalapack-openmpi.so" ]; then

        sed -i "54cBLACS_LIBS=/usr/lib/libblacs-openmpi.so /usr/lib/libblacsF77init-openmpi.so /usr/lib/libblacsCinit-openmpi.so" gfortran.make
        sed -i "56cSCALAPACK_LIBS = /usr/lib/libscalapack-openmpi.so\n\n" gfortran.make
        sed -i '62s/LIBS =/LIBS = $(SCALAPACK_LIBS) $(LAPACK_LIBS) $(BLACS_LIBS) $(INCFLAGS) $(NETCDF_LIBS) $(HDF5_LIBS) $(OTHER_LIBS) $(MPI_LIBS) -fopenmp\n\n\n/' gfortran.make

    else
        echo $comandoInicialLinha " Caminhos não encontrados"
    fi

    sed -i "58cFPPFLAGS_CDF = -DNCDF -DNCDF_4 -DCDF" gfortran.make
    sed -i '60cFPPFLAGS = $(FPPFLAGS_MPI) $(DEFS_PREFIX) $(FPPFLAGS_CDF) -DFC_HAVE_ABORT -DMPI -DFC_HAVE_FLUSH -DGFORTRAN -DGRID_DP -DPHI_GRID_SP -DUSE_GEMM3m' gfortran.make
    sed -i "64s/^/MPI_INTERFACE = libmpi_f90.a/" gfortran.make
    sed -i "65s/^/MPI_INCLUDE = ./" gfortran.make
    sed -i "69s/FFLAGS_DEBUG = -g -O1/FFLAGS_DEBUG = -g -O0/" gfortran.make

    cp gfortran.make arch.make
    rm gfortran.make
    cp gfortran.bkp gfortran.make
    rm gfortran.bkp

    ###ARCH_MAKE DO GFORTRAN CRIADO
    echo $comandoInicialLinha "##ARCH_MAKE DO GFORTRAN CRIADO\n\n"

    ######iNSTALANDO SIESTA4.1
    echo $comandoInicialLinha "###INSTALANDO SIESTA\n\n"
    make
    sudo cp -rf siesta /usr/local/bin/siesta
    echo $comandoInicialLinha "\n\n"

    #REFERÊNCIA NO .bashrc
    cd ${HOME}
    sudo sed -i '$ { s/^.*$/&\n\n#netcdf/ }' ~/.bashrc
    sudo sed -i '$ { s|^.*$|&\nLD_LIBRARY_PATH=$LD_LIBRARY_PATH:'"$pathSIESTA"'/siesta-master/Docs/build/lib\nexport LD_LIBRARY_PATH| }' ~/.bashrc
    sudo sed -i '$ { s|^.*$|&\nINCLUDE=$INCLUDE:'"$pathSIESTA"'/siesta-master/Docs/build/include\nexport INCLUDE| }' ~/.bashrc

    cd /home/$(users)
    sudo sed -i '$ { s/^.*$/&\n\n##netcdf/ }' .bashrc
    sudo sed -i '$ { s|^.*$|&\nLD_LIBRARY_PATH=$LD_LIBRARY_PATH:'"$pathSIESTA"'/siesta-master/Docs/build/lib\nexport LD_LIBRARY_PATH| }' .bashrc
    sudo sed -i '$ { s|^.*$|&\nINCLUDE=$INCLUDE:'"$pathSIESTA"'/siesta-master/Docs/build/include\nexport INCLUDE| }' .bashrc

    cd $raizInstalacao/PackageSIESTA/siesta-master/Obj

}

Instalacao_SiestaTransiesta() {

    wget -c https://gitlab.com/siesta-project/siesta/-/archive/master/siesta-master.tar.gz
    tar -vzxf siesta-master.tar.gz
    pathSIESTA="$(pwd)"
    #Escrevendo arquivo gfortran.make
    echo $comandoInicialLinha "#Escrevendo arquivo gfortran.make\n\n"

    tar vxf siesta-master.tar.gz -C $pathSIESTA siesta-master/Obj/gfortran.make
    echo $comandoInicialLinha "\n\n"

    #./install_netcdf4.bash
    echo $comandoInicialLinha "#./install_netcdf4.bash\n\n"
    cd siesta-master/Docs
    sed -i '213c\ ' install_netcdf4.bash
    sed -i '214c\ ' install_netcdf4.bash
    ./install_netcdf4.bash
    echo $comandoInicialLinha "\n\n"

    cd ..
    cd Obj
    sh ../Src/obj_setup.sh
    arch_make

    ###COMPILANDO TODOS OS PROGRAMAS DA PASTA UTILS DO SIESTA
    echo $comandoInicialLinha "###COMPILANDO TODOS OS PROGRAMAS DA PASTA UTILS DO SIESTA\n\n"

    arch_make_UTILS

    echo $comandoInicialLinha "TERMÍNO DAS COPIAS\n\n"

    ##TERMÍNO DA INSTALAÇÃO DO SIESTA/TRANSIESTA
    echo $comandoInicialLinha "#TERMÍNO DA INSTALAÇÃO DO SIESTA/TRANSIESTA\n\n"
    sleep 3

    cd $raizInstalacao
    sudo chmod -R 777 PackageSIESTA
}

InstalacaoSiestaTransiesta() {

    if [ -e "PackageSIESTA" ]; then
        echo $comandoInicialLinha 'O DIRETÓRIO \033[32mPackageSIESTA"\033[00m EXISTE
        \n\n MUDANDO O DIRETÓRIO ATUAL PARA: \033[05;33m"PackageSIESTA"\033[00;00m\n\n'

        sleep 2

        cd PackageSIESTA
        Instalacao_SiestaTransiesta

    else

        echo $comandoInicialLinha 'O DIRETÓRIO \033[32m"PackageSIESTA"\033[00m NÃO EXISTE
        \n\n CRIANDO O DIRETÓRIO: \033[05;33m"PackageSIESTA"\033[00;00m\n\n'

        sleep 2
        mkdir PackageSIESTA

        cd PackageSIESTA
        Instalacao_SiestaTransiesta

    fi

}

Instalacao_Inelastica() {

    ###INSTALAÇÃO DO INELASTICA 446
    echo $comandoInicialLinha "###INSTALAÇÃO DO INELASTICA\n\n"

    # instalar destino de inelastica
    wget -c https://sourceforge.net/projects/inelastica/files/latest/download
    sudo unzip -o download
    cd inelastica-code-446
    rm -r build
    sudo python setup.py build --fcompiler=gfortran
    pathInelastica="/usr/local/software/Inelastica"
    sudo python setup.py install --prefix=$pathInelastica

    #REFERÊNCIA NO .bashrc
    cd ${HOME}
    sudo sed -i '$ { s/^.*$/&\n\n#INELASTICA446/ }' ~/.bashrc
    sudo sed -i '$ { s|^.*$|&\nPYTHONPATH=$PYTHONPATH:'"$pathInelastica"'/lib/python2.7/site-packages\nexport PYTHONPATH| }' ~/.bashrc
    sudo sed -i '$ { s|^.*$|&\nPATH=$PATH:'"$pathInelastica"'/bin\nexport PATH| }' ~/.bashrc

    cd /home/$(users)
    sudo sed -i '$ { s/^.*$/&\n\n#INELASTICA446/ }' .bashrc
    sudo sed -i '$ { s|^.*$|&\nPYTHONPATH=$PYTHONPATH:'"$pathInelastica"'/lib/python2.7/site-packages\nexport PYTHONPATH| }' .bashrc
    sudo sed -i '$ { s|^.*$|&\nPATH=$PATH:'"$pathInelastica"'/bin\nexport PATH| }' .bashrc

    #TERMÍNO DA INSTALAÇÃO DO INELASTICA
    echo $comandoInicialLinha "#\n\nOBS: FECHAR O TERMINAL E EMULAR OUTRO PARA RECARREGAR A FUNÇÃO DO .BARSCH\n\n"
    echo $comandoInicialLinha "#TERMÍNO DA INSTALAÇÃO DO INELASTICA\n\n"

    sleep 3

    cd $raizInstalacao
    sudo chmod -R 777 PackagesINELASTICA
}

InstalacaoInelastica() {

    if [ -e "PackagesINELASTICA" ]; then
        echo $comandoInicialLinha 'O DIRETÓRIO \033[32mPackagesINELASTICA"\033[00m EXISTE
        \n\n MUDANDO O DIRETÓRIO ATUAL PARA: \033[05;33m"PackagesINELASTICA"\033[00;00m\n\n'

        sleep 2

        cd PackagesINELASTICA
        Instalacao_Inelastica

    else

        echo $comandoInicialLinha 'O DIRETÓRIO \033[32m"PackagesINELASTICA"\033[00m NÃO EXISTE
        \n\n CRIANDO O DIRETÓRIO: \033[05;33m"PackagesINELASTICA"\033[00;00m\n\n'

        sleep 2
        mkdir PackagesINELASTICA

        cd PackagesINELASTICA
        Instalacao_Inelastica

    fi

}

Main() {

    ####INICIANDO SISTEMA####
    echo $comandoInicialLinha '\033[05;37m                              ####INICIANDO SISTEMA####\033[00;00m\n\n'

    sleep 3

    github=$(
        yad --form --title "DEVELOPER" --buttons-layout=center --button=READY:0 \
        --image="$raizInstalacao/img/IronGit.png" --image-on-top \
        --text "Developer: Júlio César Reis da Silva\nGithub: https://github.com/Reis-Silva\nLicence: Open-Source\n\n
	        Page: https://github.com/Reis-Silva/Install_Use-Siesta-Transiesta-Inelastica" --text-align=center
    )

    while :; do

        instalacao=$(
            yad --form --title "INSTALAÇÃO SIESTA/TRANSIESTA/INELASTICA" \
            --image="$raizInstalacao/img/SIESTA_INELASTICA.png" --image-on-top \
            --text "VERSION: Siesta-master v4.1 - 260\nLINK: https://gitlab.com/siesta-project/siesta 
    		\nVERSION: Inelastica v1.3.6\nLINK: http://https://tfrederiksen.github.io/inelastica/docs/latest/index.html\n" --text-align=center \
            --field="INSTALAÇÃO - PACOTES ESSENCIAIS":CHK \
            --field="INSTALAÇÃO - SIESTA/TRANSIESTA":CHK \
            --field="INSTALAÇÃO - INELASTICA":CHK \
            --buttons-layout=end --button="gtk-close":1 --button=" INSTALAR!.icons/te.png":2
        )

        escolha=$(echo $comandoInicialLinha $?)
        op=$(echo $comandoInicialLinha "$instalacao" | cut -d "|" -f 1)
        op2=$(echo $comandoInicialLinha "$instalacao" | cut -d "|" -f 2)
        op3=$(echo $comandoInicialLinha "$instalacao" | cut -d "|" -f 3)

        if [ "$op" = "TRUE" ]; then

            InstalacaoPacotesEssenciais

        else
            echo $comandoInicialLinha ""
        fi

        if [ "$op2" = "TRUE" ]; then

            InstalacaoSiestaTransiesta

        else
            echo $comandoInicialLinha ""
        fi

        if [ "$op3" = "TRUE" ]; then

            InstalacaoInelastica

        else
            echo $comandoInicialLinha ""
        fi

        if [ "$op" = "TRUE" ] || [ "$op2" = "TRUE" ] || [ "$op3" = "TRUE" ]; then

            exit

        else
            echo $comandoInicialLinha ""
        fi

        if [ "$escolha" = 1 ] || [ "$escolha" = 252 ]; then

            exit

        else
            echo $comandoInicialLinha ""
        fi

        if [ "$op" = "FALSE" ] && [ "$op2" = "FALSE" ] && [ "$op3" = "FALSE" ]; then
            yad --width 325 --height 50 --title "ERROR" --image=dialog-question --buttons-layout=center --button=OK:0 --text="ESCOLHA UMA OPÇÃO DE INSTALAÇÃO"
        else
            echo $comandoInicialLinha ""
        fi

    done

}

Main
