# GEssence / Eve.H2O Core

A base-13 resolver skeleton written in Ada, designed as a small foundational library that can grow into games, visual tools, and larger symbolic models.

This project keeps the core intentionally small: a 1..13 address system, four resolver states, and a calculator-style test surface. The goal is to prove the core math first, then reuse that engine in future projects instead of expanding the foundation too early.

## What this is

This repository is the first stable layer of a larger idea. Right now it should be understood as:

- A base-13 notation skeleton.
- A resolver engine with four states: Hydrogen, Helium, Oxygen, and Water.
- A calculator/test harness for checking how values fold back into the base address space.
- A future library for games, visualization, and system experiments.

The core model is intentionally built without relying on outside math libraries so the behavior of the 1..13 system stays understandable and testable before expansion.

## Core concepts

### Base-13 skeleton

The current notation model uses 1..13 as the foundational address range. That range is the human-scale core of the system and acts as the first stable boundary for experimentation.

This is not the final size of the model. It is the first clean scope that can later be expanded into larger notational systems after the current engine is proven through use.

### Resolver states

The current scope of the engine is expressed through four states:

- **Hydrogen** — local square/root address field.
- **Helium** — prime-root or irrational banding within the current local field.
- **Oxygen** — larger overflow, self-power, or out-of-local-scope resolution.
- **Water** — universal return-to-base resolver back into 1..13.

These states define the current scope of the engine more clearly than external analogies. Cards, dominoes, bytes, and token systems can help explain the model, but the resolver states are the actual working vocabulary of the library.

### Exact and approximate

The engine should distinguish between two kinds of truth:

- **Exact** — when a value is known cleanly within the current scope.
- **Approximate** — when a value does not fold cleanly inside the current scope but still resolves to a base address through the engine.

That distinction is important because it separates mathematical accuracy from resolver behavior. A value can be out of local scope while still being meaningfully resolved.

## Current scope

The present project should stay grounded in a small, stable foundation:

- Base addresses 1..13.
- Resolver behavior through Hydrogen, Helium, Oxygen, and Water.
- A calculator-style interface used to test limits and inspect how values resolve.
- Ada as the host language for the core library.

This README is intentionally scoped to the current engine. Broader symbolic theories, long equivalence arguments, and deep interpretation notes should live in `docs/` instead of the main project entry point.

## Next goals

The next phase is to prove the engine through small games before attempting a larger model.

### 1. Build three games from the engine

Planned first games:

- **Coin flip** — the smallest on/off or 0/1 state demonstration.
- **Dice roller** — one die first, then two-dice behavior read through the same resolver logic.
- **Dominoes** — a broader test of paired values, folds, and address relationships.

These games are intended to make the engine easier to feel and test than a calculator alone.

### 2. Use the calculator as a test surface

The calculator should remain in place as the direct way to inspect limits, debug the resolver, and verify exact vs approximate behavior. It is the measurement tool, even if the games become the more natural user experience.

### 3. Work through ASM and the web surface

The immediate workflow from here is:

1. Build the three games.
2. Continue working through ASM alongside the current `index.html` test surface.
3. Reuse the resolver, `Is_Prime`, and related core functions across those experiments.

### 4. Explore TempleOS and HolyC integration

A major next goal is to understand enough HolyC and TempleOS-oriented workflows to make these small games playable in that environment eventually. The aim is not necessarily to run the full operating system as the center of the project, but to create game logic that can target or be adapted to that world.

That makes TempleOS and HolyC a practical learning step after the current Ada core, not a replacement for it.

### 5. Prepare for Grace

Once the engine is proven through games and low-level experiments, the next major creative step is **Grace**, the music visualizer. The idea is that games will validate the resolver interactively, while Grace can later use the same engine to drive sound, color, rhythm, and state transitions.

### 6. Grow into a larger model later

Only after the base-13 engine is proven through games and testing should the project branch into a larger notation model, such as 17 or 53 depending on difficulty and usefulness. That future work should be treated as an expansion layer, not a rewrite of the current core.

## Workflow from here

A grounded workflow for the next stage:

1. Stabilize the Ada core and resolver vocabulary.
2. Build Random Number Generator for games. 
3. Build coin flip, dice, and dominoes on top of the current engine.
4. Explore TempleOS and HolyC with small game-focused experiments.
5. Reuse what works for Grace, the music visualizer.
6. Only then evaluate whether the larger notation model should become 17, 53, or another expansion.

## Repo guidance

The repository should present itself as a core library first and an experiment second.

Recommended emphasis:

- Keep the build instructions.
- Keep the project structure.
- Keep the resolver definitions and current scope.
- Keep a short inspiration section.
- Move long symbolic or speculative interpretation notes into `docs/`.

A README works best when it explains what the project is, what it currently does, how to run it, and what comes next without forcing readers through every theory note first.

## Inspiration

This project was inspired by existing systems, formats, and engineering ideas that seem to reveal strong mathematical structure. Those inspirations matter, but this repository is not meant to depend on them for its identity.

The purpose of this core is to express and test the math through this engine directly. Inspiration can remain documented, but the Ada resolver itself is the proof surface for the current project.

## Naming

The library identity may evolve, but the project is currently understood as a reusable core that can support later packages, games, and visual systems. Names such as **GEssence** and **Eve.H2O** both fit that role if kept consistent across the repository.

## In short

This project is the small engine before the bigger machine: a base-13 Ada core, four resolver states, a calculator for testing, and a roadmap toward games, TempleOS experiments, and later visual/music systems.
