<<<<<<< HEAD
=======
# commands.py – custom ranger commands
>>>>>>> df70299fc361acef84985177c03587b96811d96f

from ranger.api.commands import Command
import os, subprocess

<<<<<<< HEAD
class open_nvim(Command):
    """:open_nvim
    Open selected file in Neovim."""
    def execute(self):
        f = self.fm.thisfile.path
        self.fm.notify(f"Opening {f} in Neovim")
        subprocess.run(["nvim", f])
=======
class yanklatex(Command):
    r""":yanklatex
    Copy LaTeX \includegraphics command for the selected file
    """
    def execute(self):
        f = self.fm.thisfile.path
        # Tạo chuỗi lệnh LaTeX
        cmd = f"\\includegraphics[width=0.7\\textwidth]{{{f}}}"

        # Thao tác với subprocess.run:
        # - Chuyển lệnh thành list các đối số để loại bỏ shell=True, tăng bảo mật.
        # - Dữ liệu đầu vào (cmd.encode()) được chuyển trực tiếp qua stdin.
        try:
            subprocess.run(
                ["xclip", "-selection", "clipboard"],
                input=cmd.encode(),
                check=True # Kiểm tra nếu lệnh xclip thất bại (ví dụ: xclip chưa cài)
            )
            self.fm.notify("Copied LaTeX includegraphics to clipboard!")
        except FileNotFoundError:
             self.fm.notify("Error: 'xclip' command not found. Please install xclip.", bad=True)
        except subprocess.CalledProcessError:
             self.fm.notify("Error: xclip failed to execute.", bad=True)
>>>>>>> df70299fc361acef84985177c03587b96811d96f

class extract(Command):
    """:extract
    Extract archives (zip/tar) in current directory."""
    def execute(self):
        f = self.fm.thisfile.path
<<<<<<< HEAD
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
=======

        # Thao tác với subprocess.run:
        # - Chuyển lệnh thành list các đối số để loại bỏ shell=True.
        # - Dữ liệu đầu vào (f.encode()) được chuyển trực tiếp qua stdin.
        try:
            subprocess.run(
                ["xclip", "-selection", "clipboard"],
                input=f.encode(),
                check=True
            )
            self.fm.notify("Copied path to clipboard!")
        except FileNotFoundError:
            self.fm.notify("Error: 'xclip' command not found. Please install xclip.", bad=True)
        except subprocess.CalledProcessError:
             self.fm.notify("Error: xclip failed to execute.", bad=True)
>>>>>>> df70299fc361acef84985177c03587b96811d96f
