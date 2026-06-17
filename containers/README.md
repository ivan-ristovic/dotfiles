# dotfiles/containers

Docker images used for testing and as a sandbox environment.

Run `image` to build a docker image or run a container for the specified configuration. Configuration name must match an existing directory in this folder that contains a Dockerfile.

Use `--ssh` with `image run` to forward the host SSH agent into the container:

```bash
./image run arch --ssh
```

This mounts `$SSH_AUTH_SOCK` at `/run/host-ssh-agent`, sets `SSH_AUTH_SOCK` inside the container, and mounts `~/.ssh/known_hosts` read-only for Git SSH host verification when that file exists. Private keys stay on the host.

Run `check-setup` to perform a non-interactive clean setup smoke test. The host
orchestrator lives in `check-setup`; the assertions that run inside the
container live in `check-setup-in-container`. The default target is Arch, and
Ubuntu can be selected explicitly:

```bash
./check-setup
./check-setup ubuntu
```

The script writes `setup-container-*.log` in the repository root. The log is
ignored by Git. Passing checks remove the test container; failing checks keep it
for inspection and print its name. Use `--no-remove` or `--keep` to keep a
passing test container for debugging.

Neovim `:checkhealth` errors are printed in the script output and the full
health buffer is appended to the log. Use `--strict-health` when those reported
errors should fail the smoke test.

The repository-level `./check` script runs this container smoke test after its
local checks. To run only the local checks, use:

```bash
./check --no-container
```
