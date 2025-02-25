.intel_syntax noprefix
.text
.globl array_sum
.globl array_multiply_by_2
.globl array_max
.globl search

# Calculate sum of array elements
array_sum:
    push rbp
    mov rbp, rsp
    
    mov rcx, rsi           # Load size into counter
    xor rax, rax           # Clear accumulator
    xor r8, r8             # Initialize index
    
sum_loop:
    add eax, [rdi + r8 * 4]   # Add current element
    inc r8
    loop sum_loop
    
    pop rbp
    ret

# Multiply all elements by 2
array_multiply_by_2:
    push rbp
    mov rbp, rsp
    
    mov rcx, rsi           # Load size
    xor r8, r8             # Initialize index
    
multiply_loop:
    mov eax, [rdi + r8 * 4]   # Load element
    shl eax, 1                # Multiply by 2
    mov [rdi + r8 * 4], eax   # Store back
    inc r8
    loop multiply_loop
    
    pop rbp
    ret

# Find maximum element
array_max:
    push rbp
    mov rbp, rsp
    
    mov rcx, rsi           # Load size
    xor r8, r8             # Initialize index
    mov eax, [rdi + r8 * 4]   # Initialize max with first element
    
max_loop:
    inc r8
    cmp rcx, r8
    je max_done            # Exit if we've checked all elements
    
    cmp eax, [rdi + r8 * 4]   # Compare current max
    cmovl eax, [rdi + r8 * 4] # Update if current is larger
    jmp max_loop
    
max_done:
    pop rbp
    ret

# Binary Search in Assembly
search:
    push rbp
    mov rbp, rsp
    
    cmp rsi, 0             # Check if size <= 0
    jle not_found
    
    mov r8d, 0             # left = 0
    mov r9d, esi           # right = size
    dec r9d                # right = size - 1

binary_search_loop:
    cmp r8d, r9d
    jg not_found           # if left > right, exit loop

    mov ecx, r8d
    add ecx, r9d
    shr ecx, 1             # mid = (left + right) / 2

    mov r10d, ecx          # Store mid in r10d
    shl r10d, 2            # mid * 4 (for int array indexing)
    mov r11, rdi           # Get the base address of array
    add r11, r10           # Calculate address of array[mid]
    mov eax, [r11]         # Load array[mid] into eax
    
    cmp eax, edx           # Compare array[mid] with target
    je found               # If equal, found

    jl move_right          # If array[mid] < target, move right
    mov r9d, ecx           # right = mid - 1
    dec r9d
    jmp binary_search_loop

move_right:
    mov r8d, ecx           # left = mid + 1
    inc r8d
    jmp binary_search_loop

found:
    mov eax, ecx           # Return index of found element
    jmp end_search

not_found:
    mov eax, -1            # Return -1 if not found

end_search:
    pop rbp
    ret