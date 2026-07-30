# GEssence / Eve.H2O Core

A base-13 resolver skeleton written in Ada, designed as a small foundational library that can grow into games, visual tools, and larger symbolic models.

This project keeps the core intentionally small: a 1..13 address system, a small set of resolver states, and a calculator-style test surface. The goal is to prove the core math first, then reuse that engine in future projects instead of expanding the foundation too early.

## What this is

This repository is the first stable layer of a larger idea. Right now it should be understood as:

- A base-13 notation skeleton.
- A resolver engine (Hydrogen, Helium, Oxygen, Water).
- A calculator/test harness for checking how values fold back into the base address space.
- A future library for games, visualization, and system experiments.
The core model is intentionally built without relying on outside math libraries so the behavior of the 1..13 system stays understandable and testable before expansion.

## Core concepts

### Base-13 skeleton

The current notation model uses 1..13 as the foundational address range. That range is the human-scale core of the system and acts as the first stable boundary for experimentation.

This is not the final size of the model. It is the first clean scope that can later be expanded into larger notational systems (17 or 53, depending on difficulty and usefulness) after the current engine is proven through use. 

### Resolver states

The current working vocabulary of the library:

- **Hydrogen** — square-root pointer for the 13×13 matrix; resolves 14–169 via square boundaries (1, 4, 9…169). `[CONFIRMED]` 
- **Oxygen** — self-power pointer; resolves 170–13^13 via self‑power boundaries (1^1, 2^2, 3^3…13^13). `[CONFIRMED]` 
- **Helium** — irrational prime-root band; maps prime base addresses to bands (1/2) for later irrational/root behavior. `[CONFIRMED]` 
- **Water** — universal return-to-base resolver; routes any integer up to ±13^13 back into 1..13 depending on range. `[CONFIRMED]` 

Cards, dominoes, bytes, and token systems can help explain the model, but these resolver states are the actual working vocabulary of the library.

### Exact and approximate

The engine distinguishes between two kinds of truth:

- **Exact** — when a value is known cleanly within the current scope.
- **Approximate** — when a value does not fold cleanly inside the current scope but still resolves to a base address through the engine (this is where the system's helium exists, irrational numbers resolved, something we can't see but still account for).
That distinction separates mathematical accuracy from resolver behavior. A value can be out of local scope while still being meaningfully resolved.

## Current scope

The present project stays grounded in a small, stable foundation:

- Base addresses 1..13.
- Resolver behavior through Hydrogen, Helium, Oxygen, and Water.
- A calculator-style interface used to test limits and inspect how values resolve.
- Ada as the host language for the core library, compiled to WebAssembly for the browser. 

This README is intentionally scoped to the current engine. Broader symbolic theories, long equivalence arguments, and deep interpretation notes live in `docs/` instead of the main project entry point.

## Repo layout

```text
gessence/
├── README.md              ← this file
├── .gitignore
├── gessence.gpr           ← GNAT project file (points to src/)
├── docs/
│   ├── CREDITS.md         ← external tools, specs, inspirations
│   └── GEssence.md        ← extended design notes, symbolic theory
└── src/
    ├── index.html         ← browser test surface, loads compiled wasm Rough Demo 
    ├── essence_resolver.ads
    ├── essence_resolver.adb
    ├── gessence_exports.ads
    ├── gessence_exports.adb
    └── gessence_wasm.adb
```

## Build and run (Ada → Wasm)

Requires GNAT-LLVM and AdaWebPack; see `docs/CREDITS.md` for exact versions and links.

```bash
# 1. Compile Ada to WebAssembly object code
llvm-gnat1 -x ada -gnatA --target=wasm32 -O1 -gnatp \
  -I/usr/include/adawebpack -I/usr/lib/rts-native/adainclude \
  gessence_wasm.adb -o gessence_wasm.o

# 2. Link with AdaWebPack runtime
wasm-ld --no-entry --export-dynamic --allow-undefined \
  /usr/lib/adawebpack/*.o gessence_wasm.o -o gessence.wasm

# 3. Serve src/index.html + gessence.wasm, then call from the browser:
#    instance.exports.water(M)
#    instance.exports.is_prime(M)
```

## Status

GEssence is considered **complete as a base-13 resolver skeleton**:

- Ada packages compile cleanly (Hydrogen, Helium, Oxygen, Water)
- The WebAssembly module runs in the browser and exposes `water()` and `is_prime()` correctly.
- The repo shape is stable; future work happens in new repos, using this one as a template.

## Next goals

The next phase is to prove the engine through small games before attempting a larger model.

### 1. Build a random number generator

Before the games, build an RNG layer on top of the resolver — this becomes the shared engine all three games below draw from.

### 2. Build three games from the engine

- **Coin flip** — the smallest on/off or 0/1 state demonstration.
- **Dice roller** — one die first, then two-dice behavior read through the same resolver logic.
- **Dominoes** — a broader test of paired values, folds, and address relationships.

These games make the engine easier to feel and test than a calculator alone, and are the first place the “exact vs approximate” distinction and irrational/Helium behavior get exercised interactively.

### 3. Keep the calculator as a test surface

For now, the calculator remains in place as the direct way to inspect limits, debug the resolver, and verify exact vs. approximate behavior — the measurement tool, even after the games become the more natural user experience.

### 4. Work through ASM and the web surface

1. Build the three games.
2. Continue working through ASM alongside the current `index.html` test surface.
3. Reuse the resolver, `Is_Prime`, and related core functions across those experiments.

### 5. Explore TempleOS and HolyC integration

A major next goal is to understand enough HolyC and TempleOS-oriented workflows to make these small games playable in that environment eventually. The aim is not to run the full operating system as the center of the project, but to create game logic that can target or be adapted to that world. This makes TempleOS/HolyC a practical learning step after the current Ada core, not a replacement for it.

### 6. Prepare for Grace

Once the engine is proven through games and low-level experiments, the next major creative step is **Grace**, the music visualizer. Games validate the resolver interactively; Grace later uses the same engine to drive sound, color, rhythm, and state transitions.

### 7. Grow into a larger model later

Only after the base-13 engine is proven through games and testing should the project branch into a larger notation model, such as 17 or 53, depending on difficulty and usefulness. That future work is an expansion layer, not a rewrite of the current core.

## Workflow from here

1. Stabilize the current Ada core and resolver vocabulary (Hydrogen, Helium, Oxygen, Water).
2. Build the random number generator for games.
3. Build coin flip, dice, and dominoes on top of the current engine.
4. Explore TempleOS and HolyC with small game-focused experiments.
5. Reuse what works for Grace, the music visualizer.
6. Only then evaluate whether the larger notation model should become 17, 53, or another expansion.

## Inspiration

This project was inspired by existing systems, formats, and engineering ideas that reveal strong mathematical structure — including the WebAssembly binary format, Ada Lovelace's Note G, and Terry A. Davis's TempleOS/HolyC. Those inspirations matter, but this repository is not meant to depend on them for its identity. See `docs/CREDITS.md` for full references.

The purpose of this core is to express and test the math through this engine directly. Inspiration stays documented in `docs/`; the Ada resolver itself is the proof surface for the current project.

## Naming

The library identity may evolve, but the project is currently understood as a reusable core that can support later packages, games, and visual systems. Names such as **GEssence**, **Eve#**, **Eve.H2O** both fit that role if kept consistent across the repository.

## In short

This project is the small engine before the bigger machine: a base-13 Ada core, four resolver states, a calculator for testing, and a roadmap toward games, TempleOS experiments, and later visual/music systems.
