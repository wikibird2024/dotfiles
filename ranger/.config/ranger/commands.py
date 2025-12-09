# ================================
# Ranger PRO Commands
# ================================
from ranger.api.commands import Command
import os
import subprocess


# ----------------------------------------------------
# Open file in Neovim
# ----------------------------------------------------
class open_nvim(Command):
    def execute(self):
        f = self.fm.thisfile.path
        subprocess.run(["nvim", f])


# ----------------------------------------------------
# Copy LaTeX includegraphics to clipboard
# ----------------------------------------------------
class yanklatex(Command):
    def execute(self):
        f = self.fm.thisfile.path
        cmd = f"\\includegraphics[width=0.7\\textwidth]{{{f}}}"
        try:
            subprocess.run(["xclip", "-selection", "clipboard"], input=cmd.encode(), check=True)
            self.fm.notify("Copied LaTeX command to clipboard")
        except Exception:
            self.fm.notify("xclip error", bad=True)


# ----------------------------------------------------
# Copy absolute path
# ----------------------------------------------------
class copy_path(Command):
    def execute(self):
        f = self.fm.thisfile.path
        try:
            subprocess.run(["xclip", "-selection", "clipboard"], input=f.encode(), check=True)
            self.fm.notify("Copied path to clipboard")
        except Exception:
            self.fm.notify("xclip not found", bad=True)


# ----------------------------------------------------
# fzf select
# ----------------------------------------------------
class fzf_select(Command):
    """
    :fzf_select
    Use fzf to select a file or directory and jump there.
    """
    def execute(self):
        try:
            fzf = subprocess.run(
                ["fzf", "--height", "40%", "--layout=reverse", "--border"],
                capture_output=True, text=True
            )
            if fzf.stdout.strip():
                path = fzf.stdout.strip()
                self.fm.select_file(path)
        except FileNotFoundError:
            self.fm.notify("fzf not installed", bad=True)


# ----------------------------------------------------
# Create directory then cd
# ----------------------------------------------------
class mkcd(Command):
    def execute(self):
        dirname = self.rest(1)
        if not dirname:
            self.fm.notify("Usage: mkcd <dirname>", bad=True)
            return
        os.makedirs(dirname, exist_ok=True)
        self.fm.cd(dirname)


# ----------------------------------------------------
# Extract archives
# ----------------------------------------------------
class extract(Command):
    def execute(self):
        f = self.fm.thisfile.path
        if f.endswith(".zip"):
            self.fm.run(f'unzip "{f}" -d .')
        elif f.endswith(".tar.gz") or f.endswith(".tgz"):
            self.fm.run(f'tar -xzf "{f}" -C .')
        elif f.endswith(".7z"):
            self.fm.run(f'7z x "{f}"')
        else:
            self.fm.notify("Unsupported archive", bad=True)


# ----------------------------------------------------
# Compile C file
# ----------------------------------------------------
class compile_c(Command):
    def execute(self):
        f = self.fm.thisfile.path
        out = os.path.splitext(f)[0]
        self.fm.run(f"gcc {f} -o {out} && echo 'Compiled -> {out}'")


# ----------------------------------------------------
# Safe delete (trash)
# ----------------------------------------------------
class trash(Command):
    def execute(self):
        f = self.fm.thisfile.path
        self.fm.run(f"trash-put '{f}'")


# ----------------------------------------------------
# Jump to file via fzf (directories only)
# ----------------------------------------------------
class fzf_jump(Command):
    def execute(self):
        try:
            p = subprocess.run(
                ["fzf", "--type=d"],
                capture_output=True, text=True
            )
            path = p.stdout.strip()
            if path:
                self.fm.cd(path)
        except Exception:
            self.fm.notify("fzf error", bad=True)


# ----------------------------------------------------
# Compress to tar.gz
# ----------------------------------------------------
class compress(Command):
    def execute(self):
        f = self.fm.thisfile.path
        out = f"{os.path.basename(f)}.tar.gz"
        self.fm.run(f'tar -czf "{out}" "{f}"')


# ----------------------------------------------------
# Bulk rename with nvim
# ----------------------------------------------------
class bulk_rename(Command):
    def execute(self):
        self.fm.run("bulkrename")
