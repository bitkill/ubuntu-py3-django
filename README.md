# Container for django with deps to generate pdf

Deploy your pyhon app with django + uwsgi

mount your app volume in the /code dir

sample entrypoint:
````
CMD [ "uwsgi", "--http", ":80", \
    "--module","myapp.wsgi", \
    "--master" ]
````