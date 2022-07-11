FROM python:3.10.5-slim-buster

EXPOSE 8084/tcp

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_ENV "development"

WORKDIR /app

COPY static/requirements.txt .

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python3", "-B", "app.py" ]