# TMFMC

Terminal monitor for many-core and multi-GPU servers. Based on
[btop++ 1.4.8](https://github.com/aristocratos/btop/tree/v1.4.8).

- CPU-only view allocates more width to core columns. Use `v` / `V` to page through cores.
- GPU-only view shows up to four detailed GPU panels per page, depending on terminal height. Use `y` / `Y` to change pages.
- Press `5` or click `5 gpu` to toggle the GPU view. GPU detection depends on the driver and available metrics.
- Open **Lizenz** from the main menu for attribution and licensing information.

Install the AMD64 Debian package using `sudo apt install ./tmfmc_1.0.0-1_amd64.deb` and launch with `tmfmc`.
Configuration is stored in `${XDG_CONFIG_HOME:-~/.config}/tmfmc/tmfmc.conf`.
CPU, GPU, memory and network graphs use Braille by default. The optional xterm desktop launcher uses the bundled FreeMono font in UTF-8 mode. For other terminal emulators, select a monospace font with Braille coverage.

Build on Linux with GCC 14, make and pkg-config.

```sh
make -j4 CXX=g++-14 CC=gcc-14 GPU_SUPPORT=true INTEL_GPU_SUPPORT=true RSMI_STATIC=false
./bin/btop --version
./package-deb.sh
```

TMFMC changes © 2026 Norbert Jander. See [LICENSE](LICENSE), [NOTICE](NOTICE) and [upstream documentation](README.upstream.md).
