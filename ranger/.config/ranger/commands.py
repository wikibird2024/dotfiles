
from ranger.api.commands import Command
import os, subprocess

class open_nvim(Command):
    """:open_nvim
    Open selected file in Neovim."""
    def execute(self):
        f = self.fm.thisfile.path
        self.fm.notify(f"Opening {f} in Neovim")
        subprocess.run(["nvim", f])

class extract(Command):
    """:extract
    Extract archives (zip/tar) in current directory."""
    def execute(self):
        f = self.fm.thisfile.path
        if f.endswith(".zip"):
            self.fm.run(f'unzip "{f}" -d .')
        elif f.endswith(".tar.gz") or f.endswith(".tgz"):
            self.fm.run(f'tar -xzf "{f}" -C .')
        else:
            self.fm.notify("Unsupported archive", bad=True)

class compile_c(Command):
    """:compile_c
    Compile .c file with gcc automatically."""
    def execute(self):
        f = self.fm.thisfile.path
        out = os.path.splitext(f)[0]
        self.fm.run(f"gcc {f} -o {out} && echo 'Compiled -> {out}'")
