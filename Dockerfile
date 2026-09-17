FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -e ".[stack]"
CMD ["dagster","dev","-m","orchestration.definitions","-h","0.0.0.0"]
