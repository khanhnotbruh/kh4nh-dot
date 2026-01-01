def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def greet(names):
    for name in names:
        print(f"Hello, {name}!")

people = ["Alice", "Bob", "Charlie"]
greet(people)
print("5! =", factorial(5))

class Person:
    def __init__(self, name):
        self.name = name
    def say_hello(self):
        print(f"My name is {self.name}")

alice = Person("Alice")
alice.say_hello()

def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def greet(names):
    for name in names:
        print(f"Hello, {name}!")

people = ["Alice", "Bob", "Charlie"]
greet(people)
print("5! =", factorial(5))

class Person:
    def __init__(self, name):
        self.name = name
    def say_hello(self):
        print(f"My name is {self.name}")

alice = Person("Alice")
alice.say_hello()

thisthingsupposetoreturnerr
