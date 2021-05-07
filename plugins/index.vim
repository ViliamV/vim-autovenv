python3 << EOF
import os
import pathlib
import subprocess

venv = f'./{os.environ.get("VENV_PREFIX", ".venv")}/bin/activate'
if pathlib.Path(venv).is_file():
    venv_path = pathlib.Path(venv)
    try:
        process = subprocess.run([f'source {venv_path.absolute()}; echo $VIRTUAL_ENV; echo $PATH'], capture_output=True, shell=True, check=True)
        output = process.stdout.decode().splitlines()
        os.environ.update({
            'VIRTUAL_ENV': output[0],
            'PATH': output[1]
        })
    except subprocess.CalledProcessError:
        pass
EOF
