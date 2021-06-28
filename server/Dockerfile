FROM python:3.7-buster

RUN apt-get update && apt-get install -y build-essential

# Copy files to working directory
RUN mkdir /code /code/ctracker /code/data
COPY ./ctracker /code/ctracker/

COPY requirements.txt /code
COPY manage.py /code

RUN if [ ! -f /code/ctracker/.env ]; then echo $'\
INIT=fakeinit\n\
WEBAPP_STORAGE_HOME=fakehome\n\
HOST_URL=https://fake.com\n\
DJANGO_SECRET_KEY=notsosecretkey\n\
SERVER_API_KEY=notsosecretkey\n\
' >> /code/ctracker/.env; fi

EXPOSE 8000

# Install dependencies
WORKDIR /code
RUN pip install -r requirements.txt

# collect static assets
RUN python manage.py collectstatic --noinput --ignore=*.scss

CMD python manage.py runserver --nostatic 0.0.0.0:8000