import argparse
import threading
import requests
import rx
from rx import operators as op


class Checker():
    def __init__(self, host: str, port: int, timeout: int, health_endpoint: str) -> None:
        self.timeout = timeout
        self.url = f"http://{host}:{port}{health_endpoint}"
        self.request_interval = 1
        self.sleep_event = threading.Event()

    def check(self):
        try:
            response = requests.request("GET", self.url, headers={}, data={}, timeout=self.request_interval)
            return response.status_code >= 200 and response.status_code < 300
        except:
            return False

    def handle(self, is_up: bool):
        if is_up:
            print("UP")
            self.sleep_event.set()
        else: print ("DOWN")

    def start(self) -> None:
        rx.interval(self.request_interval).pipe(
            op.map(lambda i: self.check())
        ).subscribe(lambda i: self.handle(i))

        self.sleep_event.wait(timeout=self.timeout)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", type=str, required=False, default="localhost")
    parser.add_argument("--port", type=int, required=False, default=80)
    parser.add_argument("--timeout", type=int, required=True)
    parser.add_argument("--health_endpoint", type=str, required=True)
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    checker = Checker(
        args.host,
        args.port,
        args.timeout,
        args.health_endpoint,
    )
    checker.start()