FROM python:2.7

RUN pip install prometheus_client

ADD demo.py /
EXPOSE 8000
CMD ["python","/demo.py"]
