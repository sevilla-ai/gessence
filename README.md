# GEssence

A prime address system built in Ada, targeting both x86 ASM and WebAssembly.
Based off of webassembly website. [WebAssembly binary module section IDs]
(https://webassembly.github.io/spec/core/binary/modules.html):


---

## What This Is

GEssence maps a base address space of 1–13 onto the

creating an "Is_Prime" scenario that decomposes with these 13 first. 

```
0  → custom     (OFF, the flexible section)
1  → type       (H,  Hydrogen — the foundation)
2  → import     (He, Helium   — what comes from outside)
3  → function   (Li, π        — the actual functions)
4  → table                   (2², function pointer tables)
5  → memory                  (prime, the memory space)
6  → global                  (2×3, global state)
7  → export                  (prime, what you expose)
8  → start                   (2³,   the entry point)
9  → element                 (3²,   function references)
10 → code                    (2×5,  the bytecode)
11 → data                    (prime, raw data — Na pointer 1.1)
12 → data count              (4×3,  reverse pointer — factors everything below)
13 → tag                     (prime, closes the loop)
```

13 is not arbitrary:
```
3² + 2² = 9 + 4 = 13   ← sum of first two prime squares
12 = 4 × 3              ← reverse pointer, 4/3 ratio
13 × 2 = 26             ← full char() system (future_Prime)
13^13 = 302875106592253 ← upperbound that can both fit in U64
```

---

## Address System

### Base (1–13)
```
Primes  : 1, 2, 3, 5, 7, 11, 13 (one being prime is key)
Single digit (visible)    : 2, 3, 5, 7
Notated primes (composed) : 11 = 1+1, 13 = 1+3
```

### Pointer functions
Chemical Notation to better understand why 1 being a prime is important, 1 being hydrogen, meaning a prime still exists. Also makes 1/0 = 0 instead of undefined. 

```
Hydrogen (√)  — resolves addresses 14–169   (13×13 space)
Oxygen   (M^M)— resolves addresses 170–13^13 (self-power space)
Water         — routes any M back to base 1..13 (modular)
```

### Self-power boundaries (Oxygen)
```
1^1  = 1
2^2  = 4
3^3  = 27
4^4  = 256      ← fits U64, maps to Ada Long_Long_Integer
...
13^13 = 302_875_106_592_253   ← system ceiling, fits U64
```

---

## Coordinate Decomposition

Any `Long_Long_Integer` up to `13^13` decomposes into five
3-digit coordinates, each resolved back to a base address via `Water()`.

```
302_875_106_592_253
 ↑    ↑   ↑   ↑   ↑
coord5  4   3   2   1

mod 1000  → extract chunk
/ 1000    → shift right
mod 9     → I_Cycle (3² decompose, period resolves to base)
mod 11    → precision step, keeps ≤ 10
Water()   → resolve to base address 1..13
```

---

## Toolchain

Built and tested in a Podman container on Debian 13.

| Tool | Version | Purpose |
|------|---------|---------|
| GNAT | 14.2.1 | Native Ada compiler |
| gprbuild | — | Ada project builder |
| wasm-ld (LLD) | 18.1.8 | WebAssembly linker |
| clang16 | — | C → Wasm / x86 ASM |
| AdaWebPack | 24.0.0 | Ada → WebAssembly runtime |
| QEMU | planned | TempleOS / HolyC comparison |

---

## Structure

```
gessence/
├── README.md
├── .gitignore
├── gessence.gpr           ← Ada project file
├── container/
│   ├── Containerfile      ← Fedora minimal + GNAT + AdaWebPack
│   ├── world              ← unified launcher (configure before use)
│   ├── ada-dev.sh         ← container control script
│   └── Hello.sh           ← GEssence sandbox menu [1-9] (script for future OS run)
├── src/
│   ├── hello.adb          ← Ada sanity check
│   ├── essence_resolver.ads
│   └── essence_resolver.adb
└── docs/
    └── GEssence_Master_Pointer.md
```

---

## Getting Started

```bash
# 1. build the container
podman build -t ada-dev -f container/Containerfile .

# 2. enter the sandbox
# edit container/world — replace placeholder IPs with your own
./container/world

# 3. inside the container — run the sanity check
./hello

# 4. build the Ada packages
gprbuild -P gessence.gpr
```

---

## Targets (in progress)

- [x] Ada package compiling clean (essence_resolver)
- [x] Sandbox shell stack (world → PEBBLE → GEssence menu)
- [ ] hello.adb → .wasm (Ada running in browser)
- [ ] QEMU + TempleOS in container
- [ ] HolyC Is_Prime — compare ASM to Ada Is_Prime
- [ ] Coordinate decomposition package
- [ ] Scale to 26 (air mirror of water, full char() system)

---

## Learning Goals

This project exists to learn:
- Ada and SPARK by writing a real library
- x86 ASM by reading GNAT's `-S` output
- WebAssembly by compiling Ada to `.wasm`
- HolyC by running TempleOS in QEMU and comparing prime implementations
- How prime mathematics underlies binary module structure

---

Built by sevilla.ai 
