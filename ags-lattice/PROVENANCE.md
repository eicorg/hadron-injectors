# Provenance

Snapshot made on 2026-09-10 from files mounted on the BNL CAD computer.

## Shared lattice

Source directory: `/operations/app_store/AgsModelPlayer/madx/`

Copied active files:

- `xags.madx`
- `xags.conversions`
- `xags.lattice`
- `xags.rbend_plain`
- `xags.bumps`

The complete non-backup `snakes_madx/` tree was copied separately under
`source/snakes/`.

## Machine-state examples

The following recent `MadxFromSnapramp` results were copied as state examples:

- `/operations/app_store/AGSModelServer/RunData/run_fy25/Ags/25Dec22/ppmUser4/25Dec22-0945_U4set/`
- `/operations/app_store/AGSModelServer/RunData/run_fy25/Ags/25Dec30/ppmUser6/25Dec30-2145_U6cur/`

Only MAD-X input files were copied. Generated Twiss and SXF outputs were not
included.

## Initial numerical check

The installed MAD-X 5.03.06 loaded the production `xags.madx` and completed a
periodic Twiss calculation normally:

- circumference: 807.0912776 m
- Qx: 8.711255608
- Qy: 8.764719225
- transition gamma: 8.450251471

A recent FY25 state (`25Dec22-0945_U4set/model_1450.madx`) also completed
normally after redirecting its Twiss output to the temporary validation area:

- circumference: 807.0912776 m
- Qx: 8.707725932
- Qy: 8.759216863
- transition gamma: 8.452978668

These are calculated checks, not replacements for a formal MAD-X/Bmad
cross-code validation.
