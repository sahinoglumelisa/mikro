**Lab 2 — Number Classification (Assembly .COM)**

- **Location:** `Lab 2/`
- **Files:** `lab2.asm` (source), `LAB2.COM` (DOS executable), archived project zip

- **What it does (high level):**
  - Iterates numeric ranges and classifies values into two arrays:
    - `primeOddSum` — stores numbers classified as prime (odd primes)
    - `nonPrimeOrEvenSum` — stores numbers that are even or non-prime
  - Uses a nested-loop approach and a simple integer check (trial division) to determine primality.
  - The program is written as a `.COM`-style 16-bit program (uses `ORG 100h`) and manipulates memory directly.

- **Key points in `lab2.asm`:**
  - `kaynak` is the main procedure that loops over candidate values and calls helper routines.
  - `sqrt` attempts to find an integer square (used as part of the classification logic).
  - `asalmi` performs a basic primality test and stores the value into the appropriate array.
  - Results are kept in the two byte arrays; the program does not print to the console.

- **How to assemble & run:**
  - Assemble with a 16-bit assembler that produces `.COM`/`.EXE` files (e.g., TAS/MASM configured for 16-bit): assemble then run the generated `.com` in DOSBox or a DOS-compatible environment.
  - Example (in DOSBox or legacy DOS):
    - `tasm lab2.asm` then `tlink lab2` (tooling may vary by assembler)
    - Run `LAB2.COM` directly in the DOS environment.

- **Notes & caveats:**
  - The program does not display results — to examine output, use a debugger, memory dump tool, or add an output routine.
  - Primality testing is naive (trial division) and intended for small ranges only.

If you want, I can add a small output routine to print the arrays (for use in DOSBox) or rewrite the README for the next lab.
