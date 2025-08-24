
# commands.py – custom ranger commands

from ranger.api.commands import Command
import subprocess

class yanklatex(Command):
    """:yanklatex
    Copy LaTeX \includegraphics command for the selected file
    """
    def execute(self):
        f = self.fm.thisfile.path
        cmd = f"\\includegraphics[width=0.7\\textwidth]{{{f}}}"
        subprocess.run("xclip -selection clipboard", input=cmd.encode(), shell=True)
        self.fm.notify("Copied LaTeX includegraphics to clipboard!")

class yankpath(Command):
    """:yankpath
    Copy full path to clipboard
    """
    def execute(self):
        f = self.fm.thisfile.path
        subprocess.run("xclip -selection clipboard", input=f.encode(), shell=True)
        self.fm.notify("Copied path to clipboard!")
