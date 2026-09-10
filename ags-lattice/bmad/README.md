# AGS BMAD translation

This is a first verified BMAD translation of the active bare AGS ring. It is
materialized at the reference state used by the MAD-X regression: proton beam,
PC = 2.160068369 GeV/c, zero-current machine effects, and the twelve `nk`
superperiods A through L.

`elements/active_elements.bmad` contains numeric element definitions generated
from the MAD-X TWISS table. `superperiods/a.bmad` through `l.bmad` preserve the
periodic structure explicitly. `ags.bmad` is the Tao entry point.

This translation intentionally excludes MAD-X commands for errors, extraction
studies, and online current updates. Those require separate BMAD controls after
the baseline ring is accepted.

Run `tests/run-baseline.sh` to check the BMAD circumference, tunes, and
transition gamma against the MAD-X baseline. The current comparison is
numerical to the tolerances in that script; element-by-element field and sign
checks remain part of the next validation pass.
