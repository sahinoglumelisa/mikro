**Mikro — Assembly & Course Projects (Repository Overview)**

- **Purpose:** Collection of student assignments and lab exercises for microprocessor/assembly coursework. Projects include 16-bit assembly labs (.asm, .com/.exe), Proteus project files (`.pdsprj`), and a C++ image-processing assignment using `stb_image`.

- **Contents (top-level folders):**
  - `Lab 1/` — assembly solution `lab1.asm` (weighted OBP calculation + sorting). See `Lab 1/README.md` for details.
  - `Lab 2/` — assembly solution `lab2.asm` and `LAB2.COM` (number classification, primality checks). See `Lab 2/README.md`.
  - `Lab 3/` — assembly solution `C20061072.asm` (reads numbers and computes the mode). See `Lab 3/README.md`.
  - `Lab 5/`, `Lab 6/`, `Lab 7/`, `Lab 8/` — Proteus project files (`.pdsprj`) and archives for simulation experiments. See each lab's README for notes.
  - `Ödev 1/` — C++ assignment `C20061072.cpp` (grayscale image inversion + histogram equalization using `stb_image`).
  - `Ödev 2/` — project files and archives for the second homework. 

**How to run the 16-bit assembly labs (general guidance)**
- These labs are written as 16-bit DOS programs (use `ORG 100h`, `INT 21h`, etc.). They do not always print results to the console — many compute values in memory.
- Recommended environment: DOSBox or another DOS emulator on modern Windows.

Example workflow (typical, toolchain-dependent):

PowerShell / DOSBox commands (examples):

```powershell
# If you have TASM installed in DOSBox or on a DOS VM:
tasm lab1.asm
tlink lab1
# inside DOSBox or DOS environment:
LAB1.COM  # or the produced .EXE
```

```powershell
# If you use MASM (older MASM for 16-bit) the commands vary by version; a generic example:
masm lab1.asm
link lab1.obj
# run the produced program in DOSBox
```

Notes:
- If a program does not print output, use a debugger (e.g., `debug` in DOSBox), add print routines, or instrument the `.asm` to write values via `INT 21h` before running.
- Exact assembler/linker commands depend on the assembler version (TASM vs MASM) and host environment. If you'd like, I can add small print routines to specific labs so outputs are visible in DOSBox.

**How to build/run the C++ assignment (`Ödev 1`)**
- Open `Ödev 1/C20061072_MelisaSahinoglu/hw1.sln` in Visual Studio and build the solution (recommended).
- The program uses `stb_image.h` and `stb_image_write.h` and expects an input file named `input_image3.png` by default; it writes `output_image3.png` and `3output_image.png`.

Command-line (MSVC) example:

```powershell
# Open Developer PowerShell for Visual Studio, then:
cd "Ödev 1\C20061072_MelisaSahinoglu"
msbuild hw1.sln /p:Configuration=Debug
# Run the produced exe (path depends on build configuration):
.
```

**Notes about project files and archives**
- `.pdsprj` files are Proteus project files used for circuit/simulation work. Open with Proteus 
