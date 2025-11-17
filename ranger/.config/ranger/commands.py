
# commands.py – custom ranger commands
from ranger.api.commands import Command
import os
import subprocess


# ----------------------------------------------------------------------
# Open selected file in Neovim
# ----------------------------------------------------------------------
class open_nvim(Command):
    """:open_nvim
    Open the selected file in Neovim."""
    def execute(self):
        f = self.fm.thisfile.path
        self.fm.notify(f"Opening {f} in Neovim")
        subprocess.run(["nvim", f])


# ----------------------------------------------------------------------
# Copy LaTeX includegraphics command to clipboard
# ----------------------------------------------------------------------
class yanklatex(Command):
    r""":yanklatex
    Copy LaTeX \includegraphics command for the selected file."""
    def execute(self):
        f = self.fm.thisfile.path
        cmd = f"\\includegraphics[width=0.7\\textwidth]{{{f}}}"

        try:
            subprocess.run(
                ["xclip", "-selection", "clipboard"],
                input=cmd.encode(),
                check=True
            )
            self.fm.notify("Copied LaTeX includegraphics to clipboard!")
        except FileNotFoundError:
            self.fm.notify("Error: 'xclip' not found. Install xclip.", bad=True)
        except subprocess.CalledProcessError:
            self.fm.notify("Error: xclip failed.", bad=True)


# ----------------------------------------------------------------------
# Extract archive (zip/tar.gz/tgz)
# ----------------------------------------------------------------------
class extract(Command):
    """:extract
    Extract archives in the current directory."""
    def execute(self):
        f = self.fm.thisfile.path

        if f.endswith(".zip"):
            self.fm.run(f'unzip "{f}" -d .')
        elif f.endswith(".tar.gz") or f.endswith(".tgz"):
            self.fm.run(f'tar -xzf "{f}" -C .')
        else:
            self.fm.notify("Unsupported archive type", bad=True)


# ----------------------------------------------------------------------
# Compile a .c file with gcc
# ----------------------------------------------------------------------
class compile_c(Command):
    """:compile_c
    Compile the selected .c file with gcc."""
    def execute(self):
        f = self.fm.thisfile.path
        out = os.path.splitext(f)[0]

        self.fm.run(f"gcc {f} -o {out} && echo 'Compiled -> {out}'")
