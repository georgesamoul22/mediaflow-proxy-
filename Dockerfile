FROM python:3.13.5-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=7860

WORKDIR /mediaflow_proxy

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy dependency files
COPY pyproject.toml poetry.lock* /mediaflow_proxy/

# Install dependencies
RUN poetry config virtualenvs.in-project true \
    && poetry install --no-interaction --no-ansi --no-root --only main

# Copy project files
COPY . /mediaflow_proxy

# Expose Hugging Face default port
EXPOSE 7860

# Run the app with Uvicorn (simpler for Spaces)
CMD ["poetry", "run", "uvicorn", "mediaflow_proxy.main:app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
