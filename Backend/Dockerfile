FROM python:3.8.9

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install dependencies
RUN pip install Flask
RUN pip install APScheduler

# Setup app
RUN mkdir -p /app

# Switch working environment
WORKDIR /app

# Add application
COPY src .

# Expose port the server is reachable on
EXPOSE 1337

# start app
ENTRYPOINT ["python", "run.py"]