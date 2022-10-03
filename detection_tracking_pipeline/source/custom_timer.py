from threading import Timer
from multiprocessing import Process, Event
from typing import Callable

class Timer(Process):
    def __init__(self, interval, function, args=[], kwargs={}):
        super(Timer, self).__init__()
        self.interval = interval
        self.function = function
        self.args = args
        self.kwargs = kwargs
        self.finished = Event()

    def cancel(self):
        """Stop the timer if it hasn't finished yet"""
        self.finished.set()

    def run(self):
        self.finished.wait(self.interval)
        if not self.finished.is_set():
            self.function(*self.args, **self.kwargs)
        self.finished.set()

class PeriodicTimer(Timer):
    def __init__(self, interval: int, function: Callable, args=[]):
        super(PeriodicTimer, self).__init__(interval, function, args=args)

    def run(self):
        while not self.finished.is_set():
            # function callback could set the stop event
            self.function(*self.args, **self.kwargs)
            self.finished.wait(self.interval)