#include<iostream>
using namespace std;

int main(){

int i,j,n,m;
double pval;

cout<< "Capture the number of elements i,j of your matrix :"<<'\n';
cin>>i>>j;

//double *array = new double[i,j];
double *array = (double *)malloc(i * j * sizeof(double ));

for(n=0;n<i;n++)
	for(m=0;m<j;m++){
	cout<<"Capure the element "<<n+1<<" , "<<m+1<<" :"<<'\n';
	cin>> *(array + n*j + m);
	}

cout<< " Your matrix is :"<<'\n';

for(n=0;n<i;n++){
	cout<<"| ";	
	for(m=0;m<j;m++){
        //cout<< array[n][m] <<" "; // didnt work
	cout<< *( array + n*j + m )<<" ";	

	}
	cout<<"|"<<endl;
}
delete[] array;

return 0;
}
