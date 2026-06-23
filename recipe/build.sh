#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

make -j${CPU_COUNT} -f makefile.gcc -C CPP/7zip/Bundles/Alone7z/
make -j${CPU_COUNT} -f makefile.gcc -C CPP/7zip/Bundles/Alone2/
make -j${CPU_COUNT} -f makefile.gcc -C CPP/7zip/Bundles/Alone/
make -j${CPU_COUNT} -f makefile.gcc -C CPP/7zip/Bundles/Format7zF/
make -j${CPU_COUNT} -f makefile.gcc -C CPP/7zip/UI/Console/

# 7zr / 7za / 7zz are standalone builds with every codec compiled in, so they go
# straight into bin and just work.
install -D -m0755 -t "${PREFIX}/bin" CPP/7zip/Bundles/Alone7z/_o/7zr
install -D -m0755 -t "${PREFIX}/bin" CPP/7zip/Bundles/Alone2/_o/7zz
install -D -m0755 -t "${PREFIX}/bin" CPP/7zip/Bundles/Alone/_o/7za

# `7z` (CPP/7zip/UI/Console) is built with -DZ7_EXTERNAL_CODECS: it loads every
# codec/format from the external `7z.so` plugin, which it searches for next to
# argv[0]. When `7z` is launched via PATH, argv[0] is the bare name "7z" (no
# directory), so the lookup degrades to "./7z.so" in the current directory and
# the program aborts with "Codec Load Error: ./7z.so -> E_NOTIMPL".
#
# Install the real binary and its plugin together in libexec, then expose `7z`
# through a small wrapper that re-execs the binary by absolute path so the plugin
# is always found. This mirrors how Arch and Debian package the external-codecs
# 7-Zip CLI (real binary + 7z.so in a private libdir, wrapper in bin):
#   Arch:   https://gitlab.archlinux.org/archlinux/packaging/packages/7zip/-/blob/main/PKGBUILD
#   Debian: https://salsa.debian.org/debian/7zip/-/blob/master/debian/scripts/7z.sh
install -D -m0755 -t "${PREFIX}/libexec/7zip" CPP/7zip/UI/Console/_o/7z
install -D -m0755 -t "${PREFIX}/libexec/7zip" CPP/7zip/Bundles/Format7zF/_o/7z.so

cat > "${PREFIX}/bin/7z" <<'EOF'
#!/bin/sh
# Resolve our own directory (keeping 7z relocatable) and exec the real console
# binary by absolute path so it finds the co-located 7z.so codec plugin.
here=$(CDPATH= cd -- "$(dirname -- "$0")/../libexec/7zip" && pwd)
exec "$here/7z" "$@"
EOF
chmod 0755 "${PREFIX}/bin/7z"
