print-fancy-heading bagel 3.3

wget-if-needed http://www2.ph.ed.ac.uk/~paboyle/bagel/bagel-3.3.tar bagel

pushd bagel
cflags="$base_cflags"
cxxflags="$base_cxxflags"
autoreconf-if-needed
popd

mkdir -p "$build/$repo"
pushd "$build/$repo"
if ! [[ -f Makefile ]]; then
    ./configure $base_configure \
        --enable-itype=uint64_t --enable-isize=8 --enable-ifmt=%lx \
        --enable-istype=uint32_t --enable-issize=4 --enable-isfmt=%x \
        CFLAGS="$cflags" CXXFLAGS="$cxxflags"
fi
make-make-install
popd
