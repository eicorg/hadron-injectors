# Structured AGS MAD-X lattice

This is the mechanically equivalent cleanup of the canonical CAD AGS
MAD-X model. It exposes the twelve A--L superperiods as separate files while
retaining the original element definitions, alternate beamlines, comments, and
evaluation order.

## Layout

- `ags.madx`: top-level assembly and zero-current default state.
- `strengths.madx`: current-to-strength transfer functions.
- `elements/main_magnets.madx`: 240 combined-function main magnets.
- `elements/elements_and_insertions.madx`: other elements and insertion lines.
- `superperiods/a.madx` through `l.madx`: superperiod definitions and their
  historical variants.
- `beamlines.madx`: complete-ring and extraction beamlines.
- `snakes/`: snake placeholders copied from the canonical tree.
- `machine_effects.madx`: orbit-bump and backleg-winding effects; a state file
  calls this after selecting the ring.
- `tests/`: periodic MAD-X regression check.

Files under `../source/` remain the immutable snapshot. This directory is a
working representation derived from `source/madx/xags.lattice`; extraction
line ranges are recorded at the top of each generated file.

Run the baseline check from this directory:

```bash
tests/run-baseline.sh
```

The remaining future cleanup should separate default state values from `ags.madx`,
identify the supported ring beamline, and quarantine unused historical
beamlines. Each pass must reproduce the baseline before it replaces this one.
The lossless structure and final formatting passes are complete; the remaining
items are semantic preparation for Bmad translation.
