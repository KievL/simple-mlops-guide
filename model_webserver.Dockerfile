FROM python:3.10-slim

WORKDIR /app

COPY model_webserver.py model.pkl .

RUN pip install flask scikit-learn numpy

EXPOSE 5000

ENTRYPOINT python3 model_webserver.py