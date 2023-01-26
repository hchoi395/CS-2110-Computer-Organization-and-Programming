#include "list.h"

#include <stdio.h>

int main(void) {
    printf("Test\n");
    //write your tests here to check the failures
    LinkedList * list = create_list();
    UserUnion student;
    student.student.num_classes = 3; 
    double grades[] = {1, 2, 3};
    student.student.grades = grades; 
    push_back(list, "name", STUDENT, student);
    push_back(list, "name2", STUDENT, student);
}
