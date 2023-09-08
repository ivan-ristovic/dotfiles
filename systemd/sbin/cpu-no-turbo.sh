#!/bin/bash

echo "1" | tee /sys/devices/system/cpu/intel_pstate/no_turbo
