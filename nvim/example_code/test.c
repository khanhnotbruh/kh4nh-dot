#include <stdio.h>

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

void greet(const char *names[], int count) {
    for (int i = 0; i < count; i++) {
        printf("Hello, %s!\n", names[i]);
    }
}

typedef struct {
    char name[50];
} Person;

void say_hello(Person p) {
    printf("My name is %s\n", p.name);
}

int main() {
    const char *people[] = {"Alice", "Bob", "Charlie"};
    greet(people, 3);
    printf("5! = %d\n", factorial(5));

    Person alice;
    snprintf(alice.name, 50, "Alice");
    say_hello(alice);

    return 0;
}

