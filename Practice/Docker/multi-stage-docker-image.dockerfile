FROM python:latest as first

WORKDIR /app

COPY . .

FROM python:3.9-alpine

RUN pip install flask

COPY --from=first /app .

ENTRYPOINT [ "python","flask-app.py" ]