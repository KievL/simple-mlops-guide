FROM python:3.10-slim

WORKDIR /app

COPY webserver.py .

RUN pip install flask

# COPY requirements.txt .
# RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT python3 webserver.py