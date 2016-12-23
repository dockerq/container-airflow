"""
Code that goes along with the Airflow tutorial located at:
https://github.com/airbnb/airflow/blob/master/airflow/example_dags/tutorial.py
"""
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta


default_args = {
    'owner': 'adolphlwq',
    'depends_on_past': False,
    'start_date': datetime(2016, 12, 22),
    'email': ['kenan3015@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
}

dag = DAG('example-1', default_args=default_args)

# t1, t2 and t3 are examples of tasks created by instantiating operators
t1 = BashOperator(
    task_id='git_clone',
    bash_command='git clone https://github.com/dockerq/container-airflow.git ~/container-airflow',
    dag=dag)

t2 = BashOperator(
    task_id='install_httpie',
    bash_command='pip install httpie',
    retries=3,
    dag=dag)
templated_command = """
     {% for i in range(5) %}
         echo "{{ ds }}"
         echo "{{ macros.ds_add(ds, 7)}}"
         echo "{{ params.my_param }}"
     {% endfor %}
"""

t3 = BashOperator(
    task_id='templated',
    bash_command=templated_command,
    params={'my_param': 'Parameter I passed in'},
    dag=dag)

t2.set_upstream(t1)
t3.set_upstream(t1)
