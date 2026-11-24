#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT
doc="$stage/usr/share/doc/ebtop"
themes="$stage/usr/share/ebtop/themes"
install -Dm755 bin/btop "$stage/usr/bin/ebtop"
install -d "$doc" "$themes" "$stage/DEBIAN"
install -m644 LICENSE NOTICE NOTICE-UPSTREAM.txt README.md themes/LICENSE-GPU-Taskmanager.txt "$doc"
install -m644 include/fmt/LICENSE.rst "$doc/LICENSE-fmt.rst"
install -m644 themes/*.theme "$themes"
cat > "$stage/DEBIAN/control" <<'CONTROL'
Package: ebtop
Version: 1.0.0-1
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Norbert Jander <36399468+nojan01@users.noreply.github.com>
Depends: libc6 (>= 2.38), libgcc-s1 (>= 3.0), libstdc++6 (>= 14)
Description: Terminal system monitor for large servers
 Displays CPU cores, GPU telemetry, memory, storage, network and processes.
CONTROL
mkdir -p dist
dpkg-deb --root-owner-group --build "$stage" dist/ebtop_1.0.0-1_amd64.deb
(cd dist && sha256sum ebtop_1.0.0-1_amd64.deb > SHA256SUMS)
