//pointer to structure
struct properties{
    int displacement;
    int speed;
};
int main(){
    struct properties player1;
    struct properties *ptr;

    player1.displacement = 10;
    ptr = & player1;//pointing to all that set of variables
    printf("Properties of player 1, displacement : %d\n", player1.displacement);
    printf("Pointer to player1.displacement : %d", ptr->displacement);//way to point to a property of a structure
// The -> acts somewhat like *
return 0;

}
