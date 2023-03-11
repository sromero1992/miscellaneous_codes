#include <iostream>
using namespace std;
struct Student
{
	int id;
	double gpa;
	int age;
	int no_classes;
	int income;
};

void print_info(Student stud){
	cout <<"ID: "<< stud.id <<"\n";
	cout <<"Age: "<< stud.age <<"\n";
	cout <<"GPA: "<< stud.gpa <<"\n";
	cout <<"no.classes: " << stud.no_classes<<"\n";
	cout <<"income: " << stud.income<<"\n";

}

int main(){
	
	Student Selim;
        Student Joe = {1015,3.8,25,4,12000};
	Selim.id = 1039;
	Selim.no_classes=3;
	Selim.age=26;
	Selim.gpa=3.7;
	Selim.income=1000000;
	cout<<"Joe info: "<<endl;	
	print_info(Joe);
	cout<<"Selim info: "<<endl;
	print_info(Selim);
	return 0;
	

}
