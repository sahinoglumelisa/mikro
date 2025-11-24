**Lab 3 — Mode Finder (Assembly)**

- **Location:** `Lab 3/`
- **Files:** `C20061072.asm` (source), archived project zip

- **What it does:**
  - Prompts the user for a number of elements (up to 10) and reads that many bytes into an array (`sayilar`).
  - Determines the mode — the value that appears most frequently in the entered array — and prints it.

- **Key routines in `C20061072.asm`:**
  - `GIRIS_DIZI` / `GETN` — read integer input from the user and store values into the array.
  - `MOD_FONK` — computes the most frequent value (mode) and stores it in `mod_sayi`.
  - `PUTN` — prints the result as a decimal number using DOS interrupts.

- **How to assemble & run:**
  - This is a 16-bit DOS-style program using `INT 21h`. Assemble with a 16-bit assembler (MASM/TASM) and run in DOSBox or another DOS-compatible environment.
  - Example in a DOS environment: assemble `C20061072.asm`, link, then run the produced executable.

- **Notes:**
  - Input validation messages are included; if invalid characters are entered the program prints an error and asks again.
  - The program prints only the computed mode (no extra formatted output). Use a debugger or add more print calls to inspect internal arrays if needed.
