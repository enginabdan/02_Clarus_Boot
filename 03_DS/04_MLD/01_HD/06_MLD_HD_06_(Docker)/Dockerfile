FROM ubuntu
RUN apt-get update -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip  -y
RUN pip3 install pandas joblib flask scikit-learn==0.23.2
WORKDIR /APP
COPY . .
CMD python3 flaskapp.py

FROM ubuntu
RUN apt-get update -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip  -y
WORKDIR /APP
COPY . .
RUN pip3 install -r requirements.txt
CMD python3 flaskapp.py