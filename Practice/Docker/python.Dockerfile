# Mentioning the base image first
FROM python:latest

# Creating working Directory 
WORKDIR /app

# Copying the content to containers
COPY . .

# running the cmd after container creation
RUN ["python", "app.py"]

# Executing the cmd 
ENTRYPOINT [ "python","app.py" ]
