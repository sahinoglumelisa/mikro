**Lab 1 — Weighted Average & Sorting (Assembly)**

- **Location**: `Lab 1/`
- **Files:** `lab1.asm` (source), `C20061072_MelisaSahinoglu.zip` (archived project)
- **Author:** `C20061072_MelisaSahinoglu`

- **What it does:**
  - **Purpose:** Computes a weighted course score (OBP) for a list of students from two arrays: `vize` (midterm) and `final` (final exam), then sorts the computed OBP values.
  - **Calculation:** For each student the program computes (vize*4 + final*6) / 10 and applies rounding (increments the quotient when remainder >= 5).
  - **Storage:** Results are stored in the `obp` array in the data segment.
  - **Sorting:** After computing OBP for all students, the program performs a bubble-like sort so the OBP values are ordered (larger values are moved toward the start of the array).

- **Key symbols in `lab1.asm`:**
  - `vize` — word array of midterm scores
  - `final` — word array of final exam scores
  - `n` — number of students
  - `obp` — result array (words)
  - `ANA` — main procedure that computes OBP and calls the sort routine

- **How to assemble & run:**
  - This source is written for x86 16-bit assemblers (MASM/TASM). Use the assembler/toolchain your course specifies.
  - Typical workflow (on Windows with MASM/TASM or in an emulator like DOSBox):
    - Assemble: `masm lab1.asm` or `tasm lab1.asm`
    - Link: `link lab1.obj` or use the linker appropriate to your assembler
    - Run the produced `.exe`/`.com` in DOSBox or a compatible emulator if running on a modern OS

- **Notes & caveats:**
  - The program does not print output to the console — it computes values in memory. To view results you can attach a debugger, add code to print the array, or dump memory after execution.
  - The OBP calculation uses integer arithmetic and manual rounding by examining the remainder after division by 10.

If you want, I can update other `README.md` files in the repository the same way. Which labs should I start with next?
