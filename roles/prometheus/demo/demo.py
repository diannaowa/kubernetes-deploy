#!/usr/bin/env python

from prometheus_client.core import CounterMetricFamily

class DemoMetrics(object):
    def __init__(self):
        pass

    def collect(self):

        http_request_total = CounterMetricFamily(
            'http_request_total', 'demo metric name.',labels=["path","code","__meta_kubernetes_namespace"])

        result = [
            {"path":"/","code":"400"},
            {"path":"/detail","code":"200"},
            {"path":"/me","code":"404"},
            {"path":"/me/error","code":"502"}
            ]
        for doc in result:
            http_request_total.add_metric([doc["path"],doc["code"],"default"],1)
        yield http_request_total


if __name__ == "__main__":

    from prometheus_client import make_wsgi_app
    from wsgiref.simple_server import make_server
    app = make_wsgi_app(DemoMetrics())
    httpd = make_server('', 8000, app)
    httpd.serve_forever()
