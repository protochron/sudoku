# Short Answers
1. What does O(n) mean? O(n ^ 2)

O(n) means that the runtime or space complexity of an algorithm has a linear growth pattern. This means that as the size of the input grows, the runtime of the algorithm will grow at the same rate. To contrast that, a O(n ^ 2) algorithm will scale quadratically with the size of the input so the runtime is squared for every single additional input.

2. Describe quick sort

Quick sort is one of the faster general purpose sorting algorithms since it has a runtime complexity of O(n log n) in the typical case. It works by choosing an initial value called the _pivot_ value. This value is used to partition the array into two arrays: one that contains values smaller than the pivot and one that has larger values than the pivot. Once the pivot has been moved, you then apply the same steps to the two sub arrays recursively until the entire array has been sorted.

3. In C, what is a pointer?
A pointer stores the address in memory where variable is storing its value. For example:


    int i = 12; # contains the value 12
    int *i_ptr = NULL;
    i_ptr = &i; # contains the address

4. What is the difference between stack and heap memory?

The stack is a fixed size set of allocated memory to a thread for storing values at runtime. The key takeway is that the stack is contiguous so that data stored in the stack occur in order. On the other hand, the heap is where arbitrary data can be declared stored at runtime. It is slower and more complicated to access data stored on the heap because you need to keep track of pointers to any data that has been allocated. The stack is much faster because all you need is a single pointer to the top of the stack, however you can quickly exhaust the space allocated to the stack (infinite recursion can lead to a stack overflow).

5. What is the purpose of a garbage collector?

A garbage collector is a process that is used to free up memory that has been allocated but is no longer needed. This frees up objects that were declared and used at one point by the program but are not referenced by anything else.
