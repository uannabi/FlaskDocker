FROM python:3.6
COPY . /appdir
WORKDIR /appdir
RUN pip install Flask==1.0.2
EXPOSE 5000
CMD ["python", "app.py"]