**Ödev 1 — Image Processing (C++ with STB)**

- **Location:** `Ödev 1/C20061072_MelisaSahinoglu/`
- **Files:** `C20061072.cpp`, Visual Studio solution/project files (`hw1.sln`, `hw1.vcxproj`), `stb_image.h`, `stb_image_write.h`, and build outputs in `Debug/`.

- **What it does:**
  - Loads a grayscale input image (`input_image3.png`) and performs two image-processing tasks implemented partly in inline x86 assembly:
    1. Color inversion: for each pixel compute `255 - pixel` and write `output_image3.png`.
    2. Histogram equalization: compute the histogram and CDF, normalize it, and map pixels to produce an equalized image `3output_image.png`.

- **How to build & run:**
  - Open `hw1.sln` in Visual Studio and build (recommended for the provided project files).
  - Alternatively compile with `cl` (MSVC) or `g++` ensuring the `stb_image` headers are present and linking C runtime appropriately.
  - The program expects `input_image3.png` in the working directory and writes `output_image3.png` and `3output_image.png`.

- **Notes & caveats:**
  - The code uses `stb_image`/`stb_image_write` for file I/O and performs core processing in C++ with some sections implemented in inline assembly.
  - Check memory allocations when running on large images; the code assumes grayscale images and uses 1 byte per pixel.
  - If you want, I can add a small README `Usage` section that explains how to change the input/output filenames or add command-line arguments.
