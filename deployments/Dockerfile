FROM python:3.8

WORKDIR /app

COPY app/ /app/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 10007

CMD ["python", "routes.py"]