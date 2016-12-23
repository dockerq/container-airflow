# Apache AirFlow on container

## Usage
- pull and run image
```
docker run -d --name airflow --net host dockerq/container-airflow
```
- start webserver
```
docker exec airflow airflow webserver -p 6060
```
- start airflow scheduler
```
docker exec airflow airflow scheduler
```

## Examples
The files in examples will help you.

## Note
You must start the process `airflow scheduler` and then you can run you dags on the web ui. If not,
you dags will not run although you taggle it on the web ui.
