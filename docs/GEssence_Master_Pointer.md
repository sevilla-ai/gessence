GEssence — a prime address system that maps directly onto
the WebAssembly binary module specification (sections 0–13).
Built in Ada, targeting both x86 ASM and WebAssembly output.

---

## Why 13 Specifically

The base address space is `1 .. 13` (`Base_Address` in `essence_resolver.ads`).
13 closes the loop because it is the sum of the first two prime squares:

```
3² + 2² = 9 + 4 = 13
12 = 4 × 3              ← reverse pointer, 4/3 ratio
13 × 2 = 26             ← full char() system (future)
```

### Currently shipped definition (active)

`Is_Prime` in `essence_resolver.adb` returns True for exactly six addresses.
1 is **not** prime under the shipped definition.

```
Direct primes (6) : 2, 3, 5, 7, 11, 13
Composites    (7) : 1, 4, 6, 8, 9, 10, 12
                    6 + 7 = 13
```

### Proposed redefinition (not yet implemented)

> **Status: PROPOSED / NOT YET IMPLEMENTED IN CODE.**
> The shipped `Is_Prime` still returns False for 1. Nothing below is in the
> compiled library yet, and no code change has been decided on.

The owner intends `Is_Prime(1)` to eventually return **True**: 1 = Unity, the
identity, treated as a *direct prime* in this system. This is a deliberate
domain-specific axiom, **not a math error**. Standard number theory excludes 1
from the primes so that unique factorization holds; GEssence is knowingly
departing from that convention for internal consistency of the address system,
where Unity is a first-class address rather than a factorization unit.

If adopted, the counts flip — and both still sum to 13:

```
Direct primes (7) : 1, 2, 3, 5, 7, 11, 13
Composites    (6) : 4, 6, 8, 9, 10, 12
                    7 + 6 = 13
```

The shipped 6/7 split above remains the active definition until this decision
is made and implemented.

---

## Ground State and Division

`Hydrogen_Resolve` is the ground state function: any `M rem 1 = 0`, so every
address is fully consumed and returned to the origin. It works for both the
positive (water) and negative (air) side. In the same spirit, **1/0 = 0 means
ground state, not undefined.**

### Companion axiom: 1/0 = 0, not undefined (PROPOSED)

> **Status: PROPOSED / NOT YET IMPLEMENTED IN CODE.**
> Recorded here as a design decision only.

In the owner's words:

> "It is a 'pass off' to the next system, where it resolves to 0 on Ada, so it's
> resolved. If I am making 1 prime to make my math work, then I am making
> 1/0 = 0 instead of undefined to make the math work as well."

This is the matched pair to the Unity-as-prime redefinition above. The two are a
single package, not independent tweaks:

*   **Unity is prime** — 1 enters the address space as a direct prime.
*   **1/0 = 0** — division by the origin resolves to the origin rather than
    trapping as undefined.

Both are **intentional, non-standard conventions chosen for the internal
self-consistency of this system** — in the same spirit as mathematical
conventions such as `0! = 1` or `0^0 = 1`, which are *defined by convention
because they make the surrounding math work*, not derived from anything deeper.
Neither is a discovery about numbers in general, and neither is claimed to be
externally true. They are axioms this system adopts on purpose, and they stand
or fall together.
