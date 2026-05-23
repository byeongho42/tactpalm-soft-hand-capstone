@echo off
setlocal
if not exist .venv (
    python -m venv .venv
)
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
python src\tacpalm_demo.py --out outputs --n-train 50 --n-test 20 --seed 42
pause
