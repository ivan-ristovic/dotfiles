# Patches

Patches work by appending contents to a specified file. Patching is meant to be done by using `setup.sh` with `--patch` option. The main setup script will invoke `patch.sh` with the appropriate environment variables already set. `patch.sh` searches and applies pathes within this directory.

A patch is a file with `.patch` extension. The first line of a patch file is the path of the original (target) file that this patch is meant for. A blank line separates the filename from the actual patch contents that follow.

As to not perform the same patch multiple times, patch files that have their `.patched` file counterpart will be skipped. For example, performing `environment.patch` will create `environment.patch.patched` file in order to bookmark that the patch is performed successfully.
