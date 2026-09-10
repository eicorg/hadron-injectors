# AGS Booster BMAD lattice

This is a baseline BMAD translation of the cleaned Booster MAD-X model in
`../madx/`. The entry point is `booster.bmad`; it loads conversion
expressions, element definitions, beamlines, and baseline state in the same
order as the MAD-X model.

The model uses the proton baseline at `p0c = 0.3440803921 GeV/c` and the
active `BOOSTER` ring line. Its translated ring length is `201.7825368 m`,
matching the MAD-X baseline. Kicker and collimator attributes are represented
with their zero-baseline geometry; nonzero extraction and orbit-bump settings
remain a follow-up semantic conversion.

Run `tests/run-baseline.sh` to parse the lattice with Tao and verify its ring
length.
