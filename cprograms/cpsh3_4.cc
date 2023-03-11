
template <class T> class LinkedList {
public :
T data ;
LinkedList<T>∗ next ;
} ;

// Generate a linkedlist with num elements
template <class T>
LinkedList<T>∗ gen_llist ( const unsigned num ) {
if ( num == 0 )
return NULL ;

unsigned cur_i = 0 ;
LinkedList<T>∗ init_node = new LinkedList<T >;
init_node−>next = NULL ;
cur_i++;

LinkedList<T>∗ cur_node = init_node ;
while ( cur_i < num ) {
LinkedList<T>∗ new_node = new LinkedList<T >;
new_node−>next = NULL ;
cur_node−>next = new_node ;
cur_node = new_node ;
cur_i++;
}
return init_node ;
}
// Get the number of elements in the list
template <class T>

unsigned size_list(LinkedList <T> * llist){

	unsigned size=1;
	LinkedList <T>* cur_node = list;
	
	while (cur_node -> next != NULL){
	size++;

	LinkedList <T>* cur_node = cur_node -> next;
	}
	return size;
}
