.org 0
.global _start

/* newlib system calls */
.set SYSEXIT, 93
.set SYSWRITE, 64

.data
nums1:  .word 1, 0, 0, 2, 5
        .set arr_size1, .-nums1

nums2:  .word 1, 9, 0, 6, 7
        .set arr_size2, .-nums2

nums3:  .word 0, 0, 0, 0, 4
        .set arr_size3, .-nums3

nextline:    .ascii  "\n"
             .set str_next_len, .-nextline

blank:      .ascii  " "
             .set str_blank_len, .-blank

.text
_start:
    la s0, nums1                 # load nums base address to s0
    addi s1, x0, 5               #nums_size = 5
    
    #call function moveZeroes
    add a0, s0, x0            # a0 which stands for address of nums array is the first argument
    add t3, s1, x0            # t3 which stands for array size of nums is the second argument
    jal ra, moveZeroes        #jump to moveZeroes function
    
    #PrintArray
    jal ra, printArray

    # printf("\n");
    li  a7, SYSWRITE
    li  a0, 1
    la  a1, nextline
    li  a2, 1
    ecall

    # exit and return 0
    li  a7, SYSEXIT	    
    addi a0, x0, 0
    ecall
    
moveZeroes:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    li s1, 0                    #next non zero index = 0
    addi s2, x0, 0                 # i = 0
    
    
    loop:
    # loop unrooling
        bge s2, t3, exit           #i >= array_size exit
        slli t0, s2, 2             #i * 4
        add t0, a0, t0             #array + i*4
        lw t1, 0(t0)              #t1 = array[i]
        beq t1, x0, next_iter0
        slli t2, s1, 2             #next_nonzero_index * 4
        add t2, t2, a0             #array + next_nonzero_index * 4
        sw t1, 0(t2)              #array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex0             #if(next_nonzero_index != i)
        sw x0, 0(t0)              #store 0 to array[i]
    next_iter_addIndex0:
        addi s1,s1, 1             #next_nonzero_index++
    next_iter0:
        addi s2, s2, 1             #i++

        bge s2, t3, exit           #i >= array_size exit
        slli t0, s2, 2             #i * 4
        add t0, a0, t0             #array + i*4
        lw t1, 0(t0)              #t1 = array[i]
        beq t1, x0, next_iter1
        slli t2, s1, 2             #next_nonzero_index * 4
        add t2, t2, a0             #array + next_nonzero_index * 4
        sw t1, 0(t2)              #array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex1             #if(next_nonzero_index != i)
        sw x0, 0(t0)              #store 0 to array[i]
    next_iter_addIndex1:
        addi s1,s1, 1             #next_nonzero_index++
    next_iter1:
        addi s2, s2, 1             #i++

        bge s2, t3, exit           #i >= array_size exit
        slli t0, s2, 2             #i * 4
        add t0, a0, t0             #array + i*4
        lw t1, 0(t0)              #t1 = array[i]
        beq t1, x0, next_iter2
        slli t2, s1, 2             #next_nonzero_index * 4
        add t2, t2, a0             #array + next_nonzero_index * 4
        sw t1, 0(t2)              #array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex2             #if(next_nonzero_index != i)
        sw x0, 0(t0)              #store 0 to array[i]
    next_iter_addIndex2:
        addi s1,s1, 1             #next_nonzero_index++
    next_iter2:
        addi s2, s2, 1             #i++

        bge s2, t3, exit           #i >= array_size exit
        slli t0, s2, 2             #i * 4
        add t0, a0, t0             #array + i*4
        lw t1, 0(t0)              #t1 = array[i]
        beq t1, x0, next_iter3
        slli t2, s1, 2             #next_nonzero_index * 4
        add t2, t2, a0             #array + next_nonzero_index * 4
        sw t1, 0(t2)              #array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex3             #if(next_nonzero_index != i)
        sw x0, 0(t0)              #store 0 to array[i]
    next_iter_addIndex3:
        addi s1,s1, 1             #next_nonzero_index++
    next_iter3:
        addi s2, s2, 1             #i++

        bge s2, t3, exit           #i >= array_size exit
        slli t0, s2, 2             #i * 4
        add t0, a0, t0             #array + i*4
        lw t1, 0(t0)              #t1 = array[i]
        beq t1, x0, next_iter4
        slli t2, s1, 2             #next_nonzero_index * 4
        add t2, t2, a0             #array + next_nonzero_index * 4
        sw t1, 0(t2)              #array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex4             #if(next_nonzero_index != i)
        sw x0, 0(t0)              #store 0 to array[i]
    next_iter_addIndex4:
        addi s1,s1, 1             #next_nonzero_index++
    next_iter4:
        addi s2, s2, 1             #i++
        

        
 exit:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    jr ra
 
printArray:

    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)
    add s0, a0, x0 # s1 = pointer to array
    add t0, x0, x0 # t0 = i in for loop

    la t5, nums1
    addi t6, x0, 0
    addi s11, x0, arr_size1
    srli s11, s11, 2
    
    # loop unrooling

        bge t6, s11, finish_print_loop
        lw t4, 0(t5)
        addi t5, t5, 4
        mv a1, t4
        addi a1, a1, 48
        addi sp, sp, -4
        sw a1, 0(sp)
        addi a1, sp, 0
        li a7, SYSWRITE
        li a0, 1
        li a2, 4
        ecall
        addi sp,sp,4  
        li a7, SYSWRITE
        li a0, 1
        la a1, blank
        li a2, str_blank_len
        ecall
        addi t6, t6, 1

        bge t6, s11, finish_print_loop
        lw t4, 0(t5)
        addi t5, t5, 4
        mv a1, t4
        addi a1, a1, 48
        addi sp, sp, -4
        sw a1, 0(sp)
        addi a1, sp, 0
        li a7, SYSWRITE
        li a0, 1
        li a2, 4
        ecall
        addi sp,sp,4  
        li a7, SYSWRITE
        li a0, 1
        la a1, blank
        li a2, str_blank_len
        ecall
        addi t6, t6, 1

        bge t6, s11, finish_print_loop
        lw t4, 0(t5)
        addi t5, t5, 4
        mv a1, t4
        addi a1, a1, 48
        addi sp, sp, -4
        sw a1, 0(sp)
        addi a1, sp, 0
        li a7, SYSWRITE
        li a0, 1
        li a2, 4
        ecall
        addi sp,sp,4  
        li a7, SYSWRITE
        li a0, 1
        la a1, blank
        li a2, str_blank_len
        ecall
        addi t6, t6, 1

        bge t6, s11, finish_print_loop
        lw t4, 0(t5)
        addi t5, t5, 4
        mv a1, t4
        addi a1, a1, 48
        addi sp, sp, -4
        sw a1, 0(sp)
        addi a1, sp, 0
        li a7, SYSWRITE
        li a0, 1
        li a2, 4
        ecall
        addi sp,sp,4  
        li a7, SYSWRITE
        li a0, 1
        la a1, blank
        li a2, str_blank_len
        ecall
        addi t6, t6, 1

        bge t6, s11, finish_print_loop
        lw t4, 0(t5)
        addi t5, t5, 4
        mv a1, t4
        addi a1, a1, 48
        addi sp, sp, -4
        sw a1, 0(sp)
        addi a1, sp, 0
        li a7, SYSWRITE
        li a0, 1
        li a2, 4
        ecall
        addi sp,sp,4  
        li a7, SYSWRITE
        li a0, 1
        la a1, blank
        li a2, str_blank_len
        ecall
        addi t6, t6, 1

        

finish_print_loop:
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    jr ra
