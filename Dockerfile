FROM python:3.11-slim-bullseye
WORKDIR /app

# Install git and poetry
RUN apt-get update && apt-get install -y git python3-pip
RUN pip install poetry

# Copy project files
COPY . /app

# Install dependencies via Poetry
RUN poetry install --no-root --no-interaction --no-ansi

# Expose Hugging Face default port
EXPOSE 7860

# Run the app with Uvicorn
CMD ["poetry", "run", "uvicorn", "mediaflow_proxy.main:app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
