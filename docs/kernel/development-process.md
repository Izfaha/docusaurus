---
sidebar_title: Linux Kernel Development Process
---

# Linux Kernel Development Process

![Release Cycle](./img/RC.png)

## Cycle

![Cycle](./img/cycle.png)

## Time line 

![Time Line](./img/timeline-example.png)

```sh
┌──────────────────────────┬──────────────┬───────────────────────────────┬──────────────┐
│        Tahap             │ Periode      │ Keterangan                    │ Contoh 6.10  │
├──────────────────────────┼──────────────┼───────────────────────────────┼──────────────┤
│ Quiet Period             │ ~3 minggu    │ Maintainer siapkan patch      │ —            │
├──────────────────────────┼──────────────┼───────────────────────────────┼──────────────┤
│ Merge Window             │ 2 minggu     │ Fitur baru digabung ke mainline│ 12–26 Mei 2024│
├──────────────────────────┼──────────────┼───────────────────────────────┼──────────────┤
│ Release Candidates (rc)  │ 6–8 minggu   │ Fokus perbaikan bug, weekly  │ 27 Mei–13 Jul 2024 (9 minggu total)│
├──────────────────────────┼──────────────┼───────────────────────────────┼──────────────┤
│ Final Release            │ —            │ Kernel stabil dirilis         │ 14 Juli 2024 │
└──────────────────────────┴──────────────┴───────────────────────────────┴──────────────┘

```

# Active Kernel Release

![Abbreviation](./img/akr.png)
