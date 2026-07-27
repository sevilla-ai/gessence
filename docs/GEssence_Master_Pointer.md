GEssence — a prime address system that maps directly onto
the WebAssembly binary module specification (sections 0–13).
Built in Ada, targeting both x86 ASM and WebAssembly output.

## Unity as a direct prime — IMPLEMENTED

`Is_Prime (1)` returns `True` on this branch. The base 1–13 therefore has
seven direct primes (1, 2, 3, 5, 7, 11, 13) and six composites
(4, 6, 8, 9, 10, 12). This is a deliberate domain-specific definition, not
the standard number-theory convention.

PR #3 (`docs/proposed-unity-prime-and-div-zero-axioms`) still describes this
as *proposed*. Once these branches land in order, that note needs reconciling
to *implemented*.

