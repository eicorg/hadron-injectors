#!/usr/bin/env bash
set -euo pipefail

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tao_bin=${TAO_BIN:-$HOME/.conda/envs/ags-bmad/bin/tao}
log_file=$(mktemp)
trap 'rm -f "$log_file"' EXIT

"$tao_bin" -lattice_file "$root_dir/ags.bmad" -noplot -quiet all \
  -command 'show universe' >"$log_file" 2>&1

python3 - "$log_file" <<'PY'
import math
import re
import sys

text = open(sys.argv[1]).read()
checks = {
    "length": (r"Lattice branch length:\s+([0-9.Ee+-]+)", 807.0912776, 5e-4),
    "qx": (r"Q\s+([0-9.Ee+-]+)\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+", 8.711255608, 5e-6),
    "qy": (r"Q\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+([0-9.Ee+-]+)\s+[0-9.Ee+-]+", 8.764719225, 5e-6),
    "gamma_trans": (r"gamma_trans:\s+([0-9.Ee+-]+)", 8.450251471, 5e-5),
}
for name, (pattern, expected, tolerance) in checks.items():
    match = re.search(pattern, text)
    if not match:
        raise SystemExit(f"could not read {name} from Tao output")
    actual = float(match.group(1))
    if not math.isclose(actual, expected, rel_tol=0, abs_tol=tolerance):
        raise SystemExit(f"{name}: expected {expected}, got {actual}")
    print(f"{name}: {actual} (PASS)")
PY
