repo=qphix

print-fancy-heading $repo

clone-if-needed https://github.com/JeffersonLab/qphix.git $repo master

pushd $repo
cflags="$base_cflags $openmp_flags"
cxxflags="$base_cxxflags $openmp_flags $cxx11_flags"
autoreconf-if-needed
popd

mkdir -p "$build/$repo"
pushd "$build/$repo"
if ! [[ -f Makefile ]]; then
    $sourcedir/$repo/configure $base_configure \
        --disable-mm-malloc \
        --enable-proc=QPX \
        --enable-soalen=4 \
        --disable-testing \
        --enable-clover \
        --enable-openmp \
        --enable-parallel-arch=parscalar \
        --with-qdp="$prefix" \
        --with-qmp="$prefix" \
        CFLAGS="$cflags" CXXFLAGS="$cxxflags"
fi
make-make-install
popd
