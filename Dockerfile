# Use the official Python image as base
FROM python:3.12.0-slim

# Set the working directory in the container
WORKDIR /app

# Update package lists and install libpq-dev and build-essential for building psycopg2-binary
RUN apt-get update && apt-get install -y libpq-dev build-essential

# Create a non-root user
RUN adduser --disabled-password --gecos "" --home "/nonexistent" --shell /bin/bash myuser

# Copy the requirements file into the container at /app
COPY requirements.txt requirements.txt

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install dependencies from requirements.txt
# Install psycopg2-binary instead of attempting to build psycopg2 from source
RUN python -m pip install -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY . .

# Specify the user to run the container
USER myuser

# Command to run the application
CMD ["python", "app.py"]
