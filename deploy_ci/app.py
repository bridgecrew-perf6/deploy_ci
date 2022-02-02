#!/usr/bin/env python3.9
# coding: utf-8

import requests
from flask import Flask, render_template


app = Flask(__name__)


@app.route("/")
def index():
    products = ["primeiro", "segundo", "terceiro"]
    url = (
        "https://httpstat.us/200"
    )
    result = requests.get(url)
    return render_template("index.html", **locals())


def somar(a, b):
    return a + b


def subtrair(a, b):
    return a - b


if __name__ == "__main__":
    app.run()
