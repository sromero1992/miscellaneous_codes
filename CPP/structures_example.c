//structures example
#include <stdio.h>
struct database {
    int id_number;
    int age;
    float salary;

};

int main() {
    struct database employee; //Now there is an employee variable
                            //that has modifiable variables inside it
    employee.age = 22;
    employee.id_number = 1000;
    employee.salary = 20021.21;
    printf("The age of employee is %d\n", employee.age);
    printf("The id number is %d\n", employee.id_number);
    printf("The salary is %f  ", employee.salary);
}
