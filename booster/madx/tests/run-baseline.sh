#!/usr/bin/env bash
set -euo pipefail

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
madx_bin=${MADX_BIN:-madx}
log_file=$(mktemp)
trap 'rm -f "$log_file" /tmp/booster-clean-baseline.twiss' EXIT

cd "$root_dir"
"$madx_bin" < tests/baseline.madx >"$log_file"

python3 - "$log_file" <<'PY'
import math, re, sys
text = open(sys.argv[1], encoding='ascii', errors='strict').read()

def value(label, pattern):
    m = re.search(pattern, text, re.S)
    if not m:
        raise SystemExit(f"missing MAD-X summary: {label}")
    return float(m.group(1))

checks = {
    "length": (value("length", r"length\s+orbit5\s+alfa\s+gammatr\s*\n\s*([0-9.Ee+-]+)"), 201.7825368),
    "qx": (value("qx", r"q1\s+dq1\s+betxmax\s+dxmax\s*\n\s*([0-9.Ee+-]+)"), 4.634076709),
    "qy": (value("qy", r"dxrms\s+xcomax\s+xcorms\s+q2\s*\n\s*[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+([0-9.Ee+-]+)"), 4.606677589),
    "gammatr": (value("gammatr", r"length\s+orbit5\s+alfa\s+gammatr\s*\n\s*[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+[0-9.Ee+-]+\s+([0-9.Ee+-]+)"), 4.661707553),
}
for name, (actual, expected) in checks.items():
    if not math.isclose(actual, expected, rel_tol=0, abs_tol=2e-8):
        raise SystemExit(f"{name}: {actual} != {expected}")
    print(f"{name}: {actual:.10g}")
PY
