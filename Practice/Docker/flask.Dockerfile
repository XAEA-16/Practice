# taking base flask image
FROM python:latest

WORKDIR /app

COPY . .

RUN pip install flask

EXPOSE 8000

ENTRYPOINT  ["python","flask-app.py"]
