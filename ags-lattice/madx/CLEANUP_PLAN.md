# Cleanup and translation plan

## Rules

1. Treat `../source/` as immutable evidence.
2. Make one class of change at a time and run `tests/run-baseline.sh` after it.
3. Keep lattice topology, strength conversion, and machine state in separate
   files.
4. Preserve element names until MAD-X/Bmad element-by-element comparisons pass.
5. Keep the twelve A--L superperiods visible in both MAD-X and Bmad.

## Current active topology

The operational entry point selects:

```text
ring = mstart, AGSnk, mend
AGSnk = SUPERAnk, SUPERBnk, ... SUPERLnk
```

The `nk` superperiod variants are therefore the current bare-ring topology.
Other lines in the source support extraction studies and historical layouts.
They remain available in this lossless first split but should move under a
clearly labelled `legacy/` or `studies/` area after their users are identified.

## MAD-X cleanup passes

### Pass 1: lossless structure (complete)

- Split definitions, A--L superperiods, and whole-ring beamlines.
- Replace production absolute paths with working-tree relative paths.
- Preserve original statement order and all historical variants.
- Verify periodic circumference and tunes exactly.

### Pass 1a: final formatting (complete)

- Keep one beam declaration at the entry point.
- Normalize malformed delayed-assignment spacing in retained state values.
- Preserve the original include order and active `AGSnk` topology.
- Re-run the exact circumference and tune regression after the edits.

### Pass 2: configuration boundaries

- Move particle and default current values out of `ags.madx` into a named
  state file.
- Put geometry constants in one file and current-to-strength functions in
  another.
- Make state files set values before the lattice is selected and call
  `machine_effects.madx` explicitly after `use` where MAD-X requires it.
- Add representative injection, transition, and extraction regression cases.

### Pass 3: active model versus studies

- Retain `AGSnk` as the supported ring until another topology is selected.
- Move unused extraction and multi-turn beamlines out of the default load path.
- Resolve the duplicate `SSG10` definition and document which definition is
  active.
- Remove commented-out alternatives only after recording their provenance.

### Pass 4: repetition and naming

- Compare all 20 locations across A--L and tabulate the real exceptions.
- Factor only truly identical patterns; keep named exceptions explicit.
- Normalize comments, indentation, assignment spacing, and filename suffixes.
- Do not rename physical elements until cross-code comparison tooling can map
  old and new names.

## Hand translation to Bmad

Translate the cleaned files in the same hierarchy. MAD-X semicolons are
accepted by the Bmad parser, but punctuation alone is insufficient. The main
semantic differences to handle explicitly are:

- MAD-X deferred assignments (`:=`) versus Bmad's ordered variable evaluation.
- MAD-X variable redefinition versus Bmad's single-definition requirement.
- beam particle, reference energy, and closed-ring geometry declarations.
- element attribute names and sign conventions, especially combined-function
  bends, edge angles, multipoles, kickers, and RF.
- MAD-X commands such as `twiss`, `survey`, `value`, and error application,
  which are not lattice declarations.

For each machine state, materialize an unambiguous Bmad parameter set and then
compare circumference, reference orbit, tunes, chromaticity, transition gamma,
and element-by-element optics against MAD-X.
