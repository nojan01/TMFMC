#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT
doc="$stage/usr/share/doc/tmfmc"
themes="$stage/usr/share/tmfmc/themes"
install -Dm755 bin/btop "$stage/usr/bin/tmfmc"
install -d "$doc" "$themes" "$stage/DEBIAN"
install -m644 LICENSE NOTICE NOTICE-UPSTREAM.txt README.md themes/LICENSE-GPU-Taskmanager.txt "$doc"
install -m644 include/fmt/LICENSE.rst "$doc/LICENSE-fmt.rst"
install -m644 themes/*.theme "$themes"
install -Dm644 packaging/freemono/FreeMono.ttf "$stage/usr/share/fonts/truetype/tmfmc/FreeMono.ttf"
install -Dm644 packaging/freemono/copyright "$doc/FreeMono-copyright"
install -Dm644 packaging/freemono/source.txt "$doc/FreeMono-source.txt"
install -Dm644 packaging/tmfmc.desktop "$stage/usr/share/applications/tmfmc.desktop"
cat > "$stage/DEBIAN/control" <<'CONTROL'
Package: tmfmc
Version: 1.0.1-1
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Norbert Jander <36399468+nojan01@users.noreply.github.com>
Depends: libc6 (>= 2.38), libgcc-s1 (>= 3.0), libstdc++6 (>= 14)
Suggests: xterm
Description: Terminal monitor for many-core and multi-GPU servers
 Displays CPU cores, GPU telemetry, memory, storage, network and processes.
CONTROL
mkdir -p dist
dpkg-deb --root-owner-group --build "$stage" dist/tmfmc_1.0.1-1_amd64.deb
(cd dist && sha256sum tmfmc_1.0.1-1_amd64.deb > SHA256SUMS)
