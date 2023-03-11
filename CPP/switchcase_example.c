//This is an example of switch case
#include <stdio.h>
//Prints for the cases

void playgame(){
    printf("Play game called");
}
void loadgame(){
    printf("Load game called");
}
void playmultiplayer(){
    printf("Play multiplayer called");
}
//////////////////////Main function
int main(){
    int input;
    printf("1 -> Play game\n");
    printf("2 -> Load game\n");
    printf("3 -> Play multiplayer\n");
    printf("4 -> Exit game\n");
    printf("Select any of the choice numbers :");
    scanf("%d", &input);
    switch(input){
    case 1:
        playgame();
        break;
    case 2:
        loadgame();
        break;
    case 3:
        playmultiplayer();
        break;
    case 4:
        printf("Thanks for playing!\n");
        break;
    default:
        printf("Bad input, quitting...\n");
        break;
    }
    getchar();
}


