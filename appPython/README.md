## correr app en local
```sh
uvicorn main:app --reload
```

## correr test 
```sh
python3 test_main.py

python3 -m unittest test_main.py
```

generar archivo de dependencias
pip freeze > requirements.txt

fastapi==0.68.0
uvicorn==0.15.0
requests==2.26.0