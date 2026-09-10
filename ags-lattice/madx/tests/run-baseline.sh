#!/usr/bin/env bash
set -euo pipefail

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
log_file=$(mktemp)
trap 'rm -f "$log_file"' EXIT

cd "$root_dir"
madx < tests/baseline.madx > "$log_file"

python3 - "$log_file" <<'PY'
import math
import re
import sys

text = open(sys.argv[1]).read()
patterns = {
    "length": (r"length\s+orbit5\s+alfa\s+gammatr\s+\n\s*([0-9.Ee+-]+)", 807.0912776, 1e-7),
    "qx": (r"q1\s+dq1\s+betxmax\s+dxmax\s+\n\s*([0-9.Ee+-]+)", 8.711255608, 1e-9),
    "qy": (r"dxrms\s+xcomax\s+xcorms\s+q2\s+\n\s*[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+([0-9.Ee+-]+)", 8.764719225, 1e-9),
}

for name, (pattern, expected, tolerance) in patterns.items():
    match = re.search(pattern, text, re.IGNORECASE)
    if not match:
        raise SystemExit(f"could not read {name} from MAD-X output")
    actual = float(match.group(1))
    if not math.isclose(actual, expected, rel_tol=0, abs_tol=tolerance):
        raise SystemExit(f"{name}: expected {expected}, got {actual}")
    print(f"{name}: {actual} (PASS)")
PY
