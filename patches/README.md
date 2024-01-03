# Patches

Patches work by appending/swapping contents in a specified file. Patching is meant to be done by using `setup` script with `--patch` option. The main setup script will invoke the `patch` script with the appropriate environment variables already set. `patch` script searches and applies patches within this directory.

A patch is a file (optionally with a `.patch` extension) contained in this directory. The relative path to the patch file is the same as the relative path from the root directory to the target file.

Patches that end with the `.patch` extension are appended to the corresponding target files. Else, the patch replaces the target file. Patches that append to the corresponding target file are performed only if the target file does not contain *ALL* lines of the patch file.

