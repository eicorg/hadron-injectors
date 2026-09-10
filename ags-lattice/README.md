# AGS lattice working copy

This directory is a working area for building a verified Bmad representation
of the AGS lattice and evaluating a clearer representation of its twelve
superperiods before creating an EIC GitHub repository.

## Layout

- `source/madx/`: byte-for-byte snapshot of the active shared MAD-X lattice
  files from `/operations/app_store/AgsModelPlayer/madx/`.
- `source/snakes/`: byte-for-byte snapshot of the non-backup files under the
  production `snakes_madx/` tree.
- `source/states/`: recent `MadxFromSnapramp` machine-state snapshots, kept
  separate from the shared lattice.
- `bmad/`: future Bmad conversion.
- `tests/`: cross-code geometry and optics validation.
- `docs/`: design notes for the proposed human-readable twelve-superperiod
  structure.

Do not edit files under `source/`. Develop converted or reorganized variants
in `bmad/` or another clearly named working directory. `SOURCE_MANIFEST.sha256`
records the copied source bytes.

The current production main-magnet representation puts K1 and K2 directly in
`xags.rbend_plain`; generated 2026 ramp states leave the older
`xags.rbends_add_k1k2` call commented out.

