# WebAppBD

A web Application for the DataBase class in Faculdade de Ciências da Universidade do Porto

## Setup the application packages

You'l need to have installed the following packages:

-   python-dotenv
-   PyMySQL
-   Flask

You can use this console coommand to install the packages:

```console
    pip3 install --user python-dotenv Flask PyMySQL
```

### Setup the environment variables

This project is using environment variables and there is **.example.env** serving as example
To use your own values, rename the **.example.env** to **.env**. After that, change the values **USER** and **PASSWORD** to work properly. You can also change the other values as you like.
`DB="PROJETO" USER="USER" PASSWORD="PASSWORD" HOST="127.0.0.1" PORT=3306 CHARSET="utf8"`

## Run

To run this project, you need to run the following command:

```console
python3 server.py
```
