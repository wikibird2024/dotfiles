# commands.py – custom ranger commands

from ranger.api.commands import Command
import subprocess

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

class yankpath(Command):
    """:yankpath
    Copy full path to clipboard
    """
    def execute(self):
        f = self.fm.thisfile.path

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
