# Dockerfile from Docker tutorial

# Use an official Python runtime as a base image
FROM python:2.7-slim

# Copy current working directory to /app/
COPY . /app/

# Set the working directory to /app/pythonFiles/
WORKDIR /app/pythonFiles/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"] 
