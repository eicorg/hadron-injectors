#!/usr/bin/env bash
set -euo pipefail

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tao_bin=${TAO_BIN:-tao}
log_file=$(mktemp)
trap 'rm -f "$log_file"' EXIT

cd "$root_dir"
"$tao_bin" -lat booster.bmad -noplot <<'EOF' >"$log_file" 2>&1
show lat -all
quit
EOF

python3 - "$log_file" <<'PY'
import math
import re
import sys

text = open(sys.argv[1], encoding="ascii", errors="strict").read()
if re.search(r"ERROR IN bmad_parser|FATAL", text):
    raise SystemExit("Tao reported a lattice parse error")
m = re.search(r"^\s*550\s+END\s+Marker\s+([0-9.]+)", text, re.M)
if not m:
    raise SystemExit("could not find the BMAD ring endpoint")
length = float(m.group(1))
if not math.isclose(length, 201.7825368, rel_tol=0, abs_tol=5e-4):
    raise SystemExit(f"length {length} does not match the MAD-X baseline")
print(f"BMAD ring length: {length:.10f} m")
PY
