FROM python:3.10
WORKDIR ./
RUN pip install dice
COPY main.py ./
CMD ["python","main.py"]
