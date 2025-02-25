#include <stdio.h>

// Function declarations for the assembly implementations
extern int array_sum(int* array, int size);
extern void array_multiply_by_2(int* array, int size);
extern int array_max(int* array, int size);
extern int search(int* array, int size, int target);

int main() {
    int array[5] = {1, 2, 3, 4, 5};  // Sorted array
    int size = 5;
    
    // Test sum function
    int sum = array_sum(array, size);
    printf("Sum: %d\n", sum);
    
    // Test multiply function
    array_multiply_by_2(array, size);
    printf("After multiplication: ");
    for(int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
    
    // Test max function
    int max = array_max(array, size);
    printf("Maximum element: %d\n", max);

    int nums[5] = {1, 2, 3, 4, 5};
    // Test binary search function
    int target = 3;  
    int target_index = search(nums, size, target);
    
    if (target_index != -1) {
        printf("Element %d found at index %d\n", target, target_index);
    } else {
        printf("Element %d not found\n", target);
    }

    return 0;
}