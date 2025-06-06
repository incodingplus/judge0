FROM buildpack-deps:bookworm

# clang-19 is the latest version available in Debian Bookworm
RUN set -xe && \
  apt update && \
  apt install -y clang-19 libc++-19-dev libc++abi-19-dev && \
  rm -rf /var/lib/apt/lists/* && \
  apt clean

RUN set -xe && \
  mkdir -p /tmp/openssl && \
  cd /tmp/openssl && \
  wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz && \
  tar -xf openssl-1.1.1w.tar.gz && \
  cd openssl-1.1.1w && \
  ./config --prefix=/usr/local/openssl-1.1.1w --openssldir=/usr/local/openssl-1.1.1w && \
  make -j$(nproc) && \
  make -j$(nproc) install && \
  rm -rf /usr/local/openssl-1.1.1w/certs && \
  ln -s /etc/ssl/certs /usr/local/openssl-1.1.1w/certs && \
  rm -rf /tmp/*


RUN curl -sSL https://get.rvm.io | bash && \
    bash -c "source /usr/local/rvm/scripts/rvm && \
    rvm install ruby-2.7.8 --with-openssl-dir=/usr/local/openssl-1.1.1w"

# Check for latest version here: https://www.python.org/downloads
ENV PYTHON_VERSIONS=3.13.3
RUN set -xe && \
    for VERSION in $PYTHON_VERSIONS; do \
      wget "https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz" -O /tmp/python-$VERSION.tar.xz && \
      mkdir /tmp/python-$VERSION && \
      tar -xf /tmp/python-$VERSION.tar.xz -C /tmp/python-$VERSION --strip-components=1 && \
      rm /tmp/python-$VERSION.tar.xz && \
      cd /tmp/python-$VERSION && \
      ./configure \
        --prefix=/usr/local/python-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://ftp.gnu.org/gnu/octave
# ENV OCTAVE_VERSIONS \
#       5.1.0
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends gfortran libblas-dev liblapack-dev libpcre3-dev && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $OCTAVE_VERSIONS; do \
#       curl -fSsL "https://ftp.gnu.org/gnu/octave/octave-$VERSION.tar.gz" -o /tmp/octave-$VERSION.tar.gz && \
#       mkdir /tmp/octave-$VERSION && \
#       tar -xf /tmp/octave-$VERSION.tar.gz -C /tmp/octave-$VERSION --strip-components=1 && \
#       rm /tmp/octave-$VERSION.tar.gz && \
#       cd /tmp/octave-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/octave-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://jdk.java.net
RUN set -xe && \
    wget "https://download.java.net/java/GA/jdk24.0.1/24a58e0e276943138bf3e963e6291ac2/9/GPL/openjdk-24.0.1_linux-x64_bin.tar.gz" -O /tmp/openjdk24.tar.gz && \
    mkdir /usr/local/openjdk24 && \
    tar -xf /tmp/openjdk24.tar.gz -C /usr/local/openjdk24 --strip-components=1 && \
    rm /tmp/openjdk24.tar.gz && \
    ln -s /usr/local/openjdk24/bin/javac /usr/local/bin/javac && \
    ln -s /usr/local/openjdk24/bin/java /usr/local/bin/java && \
    ln -s /usr/local/openjdk24/bin/jar /usr/local/bin/jar

# Check for latest version here: https://ftpmirror.gnu.org/bash
ENV BASH_VERSIONS=5.2.37
RUN set -xe && \
    for VERSION in $BASH_VERSIONS; do \
      wget "https://ftpmirror.gnu.org/bash/bash-$VERSION.tar.gz" -O /tmp/bash-$VERSION.tar.gz && \
      mkdir /tmp/bash-$VERSION && \
      tar -xf /tmp/bash-$VERSION.tar.gz -C /tmp/bash-$VERSION --strip-components=1 && \
      rm /tmp/bash-$VERSION.tar.gz && \
      cd /tmp/bash-$VERSION && \
      ./configure \
        --prefix=/usr/local/bash-$VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/*; \
    done

# Check for latest version here: https://www.freepascal.org/download.html
# ENV FPC_VERSIONS \
#       3.0.4
# RUN set -xe && \
#     for VERSION in $FPC_VERSIONS; do \
#       curl -fSsL "ftp://ftp.freepascal.org/fpc/dist/$VERSION/x86_64-linux/fpc-$VERSION.x86_64-linux.tar" -o /tmp/fpc-$VERSION.tar && \
#       mkdir /tmp/fpc-$VERSION && \
#       tar -xf /tmp/fpc-$VERSION.tar -C /tmp/fpc-$VERSION --strip-components=1 && \
#       rm /tmp/fpc-$VERSION.tar && \
#       cd /tmp/fpc-$VERSION && \
#       echo "/usr/local/fpc-$VERSION" | sh install.sh && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://www.haskell.org/ghc/download.html
# ENV HASKELL_VERSIONS \
#       8.8.1
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends libgmp-dev libtinfo5 && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $HASKELL_VERSIONS; do \
#       curl -fSsL "https://downloads.haskell.org/~ghc/$VERSION/ghc-$VERSION-x86_64-deb8-linux.tar.xz" -o /tmp/ghc-$VERSION.tar.xz && \
#       mkdir /tmp/ghc-$VERSION && \
#       tar -xf /tmp/ghc-$VERSION.tar.xz -C /tmp/ghc-$VERSION --strip-components=1 && \
#       rm /tmp/ghc-$VERSION.tar.xz && \
#       cd /tmp/ghc-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/ghc-$VERSION && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://www.mono-project.com/download/stable
# ENV MONO_VERSIONS \
#       6.6.0.161
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends cmake && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $MONO_VERSIONS; do \
#       curl -fSsL "https://download.mono-project.com/sources/mono/mono-$VERSION.tar.xz" -o /tmp/mono-$VERSION.tar.xz && \
#       mkdir /tmp/mono-$VERSION && \
#       tar -xf /tmp/mono-$VERSION.tar.xz -C /tmp/mono-$VERSION --strip-components=1 && \
#       rm /tmp/mono-$VERSION.tar.xz && \
#       cd /tmp/mono-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/mono-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(proc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://nodejs.org/en
# ENV NODE_VERSIONS \
#       22.16.0
# RUN set -xe && \
#     for VERSION in $NODE_VERSIONS; do \
#       curl -fSsL "https://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz" -o /tmp/node-$VERSION.tar.gz && \
#       mkdir /tmp/node-$VERSION && \
#       tar -xf /tmp/node-$VERSION.tar.gz -C /tmp/node-$VERSION --strip-components=1 && \
#       rm /tmp/node-$VERSION.tar.gz && \
#       cd /tmp/node-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/node-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://github.com/erlang/otp/releases
# ENV ERLANG_VERSIONS \
#       22.2
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends unzip && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $ERLANG_VERSIONS; do \
#       curl -fSsL "https://github.com/erlang/otp/archive/OTP-$VERSION.tar.gz" -o /tmp/erlang-$VERSION.tar.gz && \
#       mkdir /tmp/erlang-$VERSION && \
#       tar -xf /tmp/erlang-$VERSION.tar.gz -C /tmp/erlang-$VERSION --strip-components=1 && \
#       rm /tmp/erlang-$VERSION.tar.gz && \
#       cd /tmp/erlang-$VERSION && \
#       ./otp_build autoconf && \
#       ./configure \
#         --prefix=/usr/local/erlang-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done; \
#     ln -s /usr/local/erlang-22.2/bin/erl /usr/local/bin/erl

# Check for latest version here: https://github.com/elixir-lang/elixir/releases
# ENV ELIXIR_VERSIONS \
#       1.9.4
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends unzip && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $ELIXIR_VERSIONS; do \
#       curl -fSsL "https://github.com/elixir-lang/elixir/releases/download/v$VERSION/Precompiled.zip" -o /tmp/elixir-$VERSION.zip && \
#       unzip -d /usr/local/elixir-$VERSION /tmp/elixir-$VERSION.zip && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://www.rust-lang.org
# ENV RUST_VERSIONS \
#       1.40.0
# RUN set -xe && \
#     for VERSION in $RUST_VERSIONS; do \
#       curl -fSsL "https://static.rust-lang.org/dist/rust-$VERSION-x86_64-unknown-linux-gnu.tar.gz" -o /tmp/rust-$VERSION.tar.gz && \
#       mkdir /tmp/rust-$VERSION && \
#       tar -xf /tmp/rust-$VERSION.tar.gz -C /tmp/rust-$VERSION --strip-components=1 && \
#       rm /tmp/rust-$VERSION.tar.gz && \
#       cd /tmp/rust-$VERSION && \
#       ./install.sh \
#         --prefix=/usr/local/rust-$VERSION \
#         --components=rustc,rust-std-x86_64-unknown-linux-gnu && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://golang.org/dl
# ENV GO_VERSIONS \
#       1.13.5
# RUN set -xe && \
#     for VERSION in $GO_VERSIONS; do \
#       curl -fSsL "https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz" -o /tmp/go-$VERSION.tar.gz && \
#       mkdir /usr/local/go-$VERSION && \
#       tar -xf /tmp/go-$VERSION.tar.gz -C /usr/local/go-$VERSION --strip-components=1 && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux
# ENV FBC_VERSIONS \
#       1.07.1
# RUN set -xe && \
#     for VERSION in $FBC_VERSIONS; do \
#       curl -fSsL "https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-$VERSION-linux-x86_64.tar.gz" -o /tmp/fbc-$VERSION.tar.gz && \
#       mkdir /usr/local/fbc-$VERSION && \
#       tar -xf /tmp/fbc-$VERSION.tar.gz -C /usr/local/fbc-$VERSION --strip-components=1 && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://github.com/ocaml/ocaml/releases
# ENV OCAML_VERSIONS \
#       4.09.0
# RUN set -xe && \
#     for VERSION in $OCAML_VERSIONS; do \
#       curl -fSsL "https://github.com/ocaml/ocaml/archive/$VERSION.tar.gz" -o /tmp/ocaml-$VERSION.tar.gz && \
#       mkdir /tmp/ocaml-$VERSION && \
#       tar -xf /tmp/ocaml-$VERSION.tar.gz -C /tmp/ocaml-$VERSION --strip-components=1 && \
#       rm /tmp/ocaml-$VERSION.tar.gz && \
#       cd /tmp/ocaml-$VERSION && \
#       ./configure \
#         -prefix /usr/local/ocaml-$VERSION \
#         --disable-ocamldoc --disable-debugger && \
#       make -j$(nproc) world.opt && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://www.php.net/downloads
# ENV PHP_VERSIONS \
#       7.4.1
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends bison re2c && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $PHP_VERSIONS; do \
#       curl -fSsL "https://codeload.github.com/php/php-src/tar.gz/php-$VERSION" -o /tmp/php-$VERSION.tar.gz && \
#       mkdir /tmp/php-$VERSION && \
#       tar -xf /tmp/php-$VERSION.tar.gz -C /tmp/php-$VERSION --strip-components=1 && \
#       rm /tmp/php-$VERSION.tar.gz && \
#       cd /tmp/php-$VERSION && \
#       ./buildconf --force && \
#       ./configure \
#         --prefix=/usr/local/php-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://dlang.org/download.html#dmd
# ENV D_VERSIONS \
#       2.089.1
# RUN set -xe && \
#     for VERSION in $D_VERSIONS; do \
#       curl -fSsL "http://downloads.dlang.org/releases/2.x/$VERSION/dmd.$VERSION.linux.tar.xz" -o /tmp/d-$VERSION.tar.gz && \
#       mkdir /usr/local/d-$VERSION && \
#       tar -xf /tmp/d-$VERSION.tar.gz -C /usr/local/d-$VERSION --strip-components=1 && \
#       rm -rf /usr/local/d-$VERSION/linux/*32 && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://www.lua.org/download.html
# ENV LUA_VERSIONS \
#       5.3.5
# RUN set -xe && \
#     for VERSION in $LUA_VERSIONS; do \
#       curl -fSsL "https://downloads.sourceforge.net/project/luabinaries/$VERSION/Tools%20Executables/lua-${VERSION}_Linux44_64_bin.tar.gz" -o /tmp/lua-$VERSION.tar.gz && \
#       mkdir /usr/local/lua-$VERSION && \
#       tar -xf /tmp/lua-$VERSION.tar.gz -C /usr/local/lua-$VERSION && \
#       rm -rf /tmp/*; \
#     done; \
#     ln -s /lib/x86_64-linux-gnu/libreadline.so.7 /lib/x86_64-linux-gnu/libreadline.so.6

# Check for latest version here: https://github.com/microsoft/TypeScript/releases
# ENV TYPESCRIPT_VERSIONS=5.8.3
RUN set -xe && \
    curl -fSsL "https://deb.nodesource.com/setup_22.x" | bash - && \
    apt update && \
    apt install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*
    # for VERSION in $TYPESCRIPT_VERSIONS; do \
    #   npm install -g typescript@$VERSION; \
    # done

# Check for latest version here: https://nasm.us
# ENV NASM_VERSIONS \
#       2.14.02
# RUN set -xe && \
#     for VERSION in $NASM_VERSIONS; do \
#       curl -fSsL "https://www.nasm.us/pub/nasm/releasebuilds/$VERSION/nasm-$VERSION.tar.gz" -o /tmp/nasm-$VERSION.tar.gz && \
#       mkdir /tmp/nasm-$VERSION && \
#       tar -xf /tmp/nasm-$VERSION.tar.gz -C /tmp/nasm-$VERSION --strip-components=1 && \
#       rm /tmp/nasm-$VERSION.tar.gz && \
#       cd /tmp/nasm-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/nasm-$VERSION && \
#       make -j$(nproc) nasm ndisasm && \
#       make -j$(nproc) strip && \
#       make -j$(nproc) install && \
#       echo "/usr/local/nasm-$VERSION/bin/nasm -o main.o \$@ && ld main.o" >> /usr/local/nasm-$VERSION/bin/nasmld && \
#       chmod +x /usr/local/nasm-$VERSION/bin/nasmld && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: http://gprolog.org/#download
# ENV GPROLOG_VERSIONS \
#       1.4.5
# RUN set -xe && \
#     for VERSION in $GPROLOG_VERSIONS; do \
#       curl -fSsL "http://gprolog.org/gprolog-$VERSION.tar.gz" -o /tmp/gprolog-$VERSION.tar.gz && \
#       mkdir /tmp/gprolog-$VERSION && \
#       tar -xf /tmp/gprolog-$VERSION.tar.gz -C /tmp/gprolog-$VERSION --strip-components=1 && \
#       rm /tmp/gprolog-$VERSION.tar.gz && \
#       cd /tmp/gprolog-$VERSION/src && \
#       ./configure \
#         --prefix=/usr/local/gprolog-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install-strip && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: http://www.sbcl.org/platform-table.html
# ENV SBCL_VERSIONS \
#       2.0.0
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends bison re2c && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $SBCL_VERSIONS; do \
#       curl -fSsL "https://downloads.sourceforge.net/project/sbcl/sbcl/$VERSION/sbcl-$VERSION-x86-64-linux-binary.tar.bz2" -o /tmp/sbcl-$VERSION.tar.bz2 && \
#       mkdir /tmp/sbcl-$VERSION && \
#       tar -xf /tmp/sbcl-$VERSION.tar.bz2 -C /tmp/sbcl-$VERSION --strip-components=1 && \
#       cd /tmp/sbcl-$VERSION && \
#       export INSTALL_ROOT=/usr/local/sbcl-$VERSION && \
#       sh install.sh && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://ftp.gnu.org/gnu/gnucobol
# ENV COBOL_VERSIONS \
#       2.2
# RUN set -xe && \
#     for VERSION in $COBOL_VERSIONS; do \
#       curl -fSsL "https://ftp.gnu.org/gnu/gnucobol/gnucobol-$VERSION.tar.xz" -o /tmp/gnucobol-$VERSION.tar.xz && \
#       mkdir /tmp/gnucobol-$VERSION && \
#       tar -xf /tmp/gnucobol-$VERSION.tar.xz -C /tmp/gnucobol-$VERSION --strip-components=1 && \
#       rm /tmp/gnucobol-$VERSION.tar.xz && \
#       cd /tmp/gnucobol-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/gnucobol-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://swift.org/download
# ENV SWIFT_VERSIONS \
#       5.2.3
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends libncurses5 && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $SWIFT_VERSIONS; do \
#       curl -fSsL "https://swift.org/builds/swift-$VERSION-release/ubuntu1804/swift-$VERSION-RELEASE/swift-$VERSION-RELEASE-ubuntu18.04.tar.gz" -o /tmp/swift-$VERSION.tar.gz && \
#       mkdir /usr/local/swift-$VERSION && \
#       tar -xf /tmp/swift-$VERSION.tar.gz -C /usr/local/swift-$VERSION --strip-components=2 && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://kotlinlang.org
# ENV KOTLIN_VERSIONS \
#       1.3.70
# RUN set -xe && \
#     for VERSION in $KOTLIN_VERSIONS; do \
#       curl -fSsL "https://github.com/JetBrains/kotlin/releases/download/v$VERSION/kotlin-compiler-$VERSION.zip" -o /tmp/kotlin-$VERSION.zip && \
#       unzip -d /usr/local/kotlin-$VERSION /tmp/kotlin-$VERSION.zip && \
#       mv /usr/local/kotlin-$VERSION/kotlinc/* /usr/local/kotlin-$VERSION/ && \
#       rm -rf /usr/local/kotlin-$VERSION/kotlinc && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://hub.docker.com/_/mono
# I currently use this to add support for Visual Basic.Net but this can be also
# used to support C# language which has been already supported but with manual
# installation of Mono (see above).
# ENV MONO_VERSION 6.6.0.161
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends gnupg dirmngr && \
#     rm -rf /var/lib/apt/lists/* && \
#     export GNUPGHOME="$(mktemp -d)" && \
#     gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#     gpg --batch --export --armor 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /etc/apt/trusted.gpg.d/mono.gpg.asc && \
#     gpgconf --kill all && \
#     rm -rf "$GNUPGHOME" && \
#     apt-key list | grep Xamarin && \
#     apt purge -y --auto-remove gnupg dirmngr && \
#     echo "deb http://download.mono-project.com/repo/debian stable-stretch/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official-stable.list && \
#     apt update && \
#     apt install -y --no-install-recommends mono-vbnc && \
#     rm -rf /var/lib/apt/lists/* /tmp/*

# Check for latest version here: https://packages.debian.org/buster/clang-7
# Used for additional compilers for C, C++ and used for Objective-C.
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends clang-7 gnustep-devel && \
#     rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://cloud.r-project.org/src/base
# ENV R_VERSIONS \
#       4.0.0
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends libpcre2-dev && \
#     rm -rf /var/lib/apt/lists/* && \
#     for VERSION in $R_VERSIONS; do \
#       curl -fSsL "https://cloud.r-project.org/src/base/R-4/R-$VERSION.tar.gz" -o /tmp/r-$VERSION.tar.gz && \
#       mkdir /tmp/r-$VERSION && \
#       tar -xf /tmp/r-$VERSION.tar.gz -C /tmp/r-$VERSION --strip-components=1 && \
#       rm /tmp/r-$VERSION.tar.gz && \
#       cd /tmp/r-$VERSION && \
#       ./configure \
#         --prefix=/usr/local/r-$VERSION && \
#       make -j$(nproc) && \
#       make -j$(nproc) install && \
#       rm -rf /tmp/*; \
#     done

# Check for latest version here: https://packages.debian.org/buster/sqlite3
# Used for support of SQLite.
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends sqlite3 && \
#     rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://scala-lang.org
# ENV SCALA_VERSIONS \
#       2.13.2
# RUN set -xe && \
#     for VERSION in $SCALA_VERSIONS; do \
#       curl -fSsL "https://downloads.lightbend.com/scala/$VERSION/scala-$VERSION.tgz" -o /tmp/scala-$VERSION.tgz && \
#       mkdir /usr/local/scala-$VERSION && \
#       tar -xf /tmp/scala-$VERSION.tgz -C /usr/local/scala-$VERSION --strip-components=1 && \
#       rm -rf /tmp/*; \
#     done

# Support for Perl came "for free" since it is already installed.

# Check for latest version here: https://github.com/clojure/clojure/releases
# ENV CLOJURE_VERSION 1.10.1
# RUN set -xe && \
#     apt update && \
#     apt install -y --no-install-recommends maven && \
#     cd /tmp && \
#     git clone https://github.com/clojure/clojure && \
#     cd clojure && \
#     git checkout clojure-$CLOJURE_VERSION && \
#     mvn -Plocal -Dmaven.test.skip=true package && \
#     mkdir /usr/local/clojure-$CLOJURE_VERSION && \
#     cp clojure.jar /usr/local/clojure-$CLOJURE_VERSION && \
#     apt remove --purge -y maven && \
#     rm -rf /var/lib/apt/lists/* /tmp/*

# Check for latest version here: https://github.com/dotnet/sdk/releases
# RUN set -xe && \
#     curl -fSsL "https://download.visualstudio.microsoft.com/download/pr/7d4c708b-38db-48b2-8532-9fc8a3ab0e42/23229fd17482119822bd9261b3570d87/dotnet-sdk-3.1.202-linux-x64.tar.gz" -o /tmp/dotnet.tar.gz && \
#     mkdir /usr/local/dotnet-sdk && \
#     tar -xf /tmp/dotnet.tar.gz -C /usr/local/dotnet-sdk && \
#     rm -rf /tmp/*

# Check for latest version here: https://groovy.apache.org/download.html
# RUN set -xe && \
#     curl -fSsL "https://dl.bintray.com/groovy/maven/apache-groovy-binary-3.0.3.zip" -o /tmp/groovy.zip && \
#     unzip /tmp/groovy.zip -d /usr/local && \
#     rm -rf /tmp/*

RUN set -xe && \
    wget "https://www.sqlite.org/2025/sqlite-autoconf-3500000.tar.gz" -O /tmp/sqlite.tar.gz && \
    mkdir /tmp/sqlite && \
    tar -xf /tmp/sqlite.tar.gz -C /tmp/sqlite --strip-components=1 && \
    rm /tmp/sqlite.tar.gz && \
    cd /tmp/sqlite && \
    ./configure \
      --prefix=/usr/local/sqlite3 && \
    make -j$(nproc) && \
    make -j$(nproc) install && \
    rm -rf /tmp/*

RUN set -xe && \
    apt update && \
    apt install -y --no-install-recommends locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
    apt update && \
    apt install -y --no-install-recommends git pkg-config libcap-dev libsystemd-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean -y && \
    git clone https://github.com/incodingplus/isolate /tmp/isolate && \
    cd /tmp/isolate && \
    make -j$(nproc) install isolate && \
    rm -rf /tmp/*
ENV BOX_ROOT=/var/local/lib/isolate

LABEL maintainer="Han Kyeol Kim <myrlagksruf@gmail.com>"
LABEL version="1.0.3"