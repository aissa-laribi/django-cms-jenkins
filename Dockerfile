FROM python:3.9
WORKDIR /app
COPY . /app
RUN pip install -r docs/requirements.txt
RUN python3 manage.py collectstatic --noinput
CMD uwsgi --http=0.0.0.0:80 --module=backend.wsgi
