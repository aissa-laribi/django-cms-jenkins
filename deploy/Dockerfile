FROM python:3.9
WORKDIR /app
COPY . /app
RUN pip install -e .
RUN pip install -r requirements.txt
RUN pip install -r dj_cms_modules.txt
RUN python manage.py collectstatic --noinput
CMD uwsgi --http=0.0.0.0:80 --module=backend.wsgi
