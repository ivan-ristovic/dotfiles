# Patches

Patches work by patching/swapping contents in a file. Patching is meant to be done by using `setup` script with `--patch` option. The main setup script will invoke the `patch` script with the appropriate environment variables already set. `patch` script searches and applies patches within this directory.

A patch is a file (optionally with a `.patch` extension) contained in this directory. The relative path to the patch file is the same as the relative path from the root directory to the target file.

Patches that end with the `.patch` extension are applied to the corresponding target files. Else, the patch replaces the target file. 

