.org 0
.global _start

/* newlib system calls */
.set SYSEXIT, 93
.set SYSWRITE, 64

.data
nums1:
    .word 1
    .word 0
    .word 0
    .word 2
    .word 5
    .set arr_size, .-nums1
    
nums2:
    .word 1
    .word 9
    .word 0
    .word 6
    .word 7

nums3:
    .word 0
    .word 0
    .word 0
    .word 0
    .word 4

.text
_start:
    la s0, nums1                 # load nums base address to s0
    addi s1, x0, 5               # nums_size = 5
    
    #call function moveZeroes
    add t4, s0, x0            # t4 which stands for address of nums array is the first argument
    add t3, s1, x0            # t3 which stands for array size of nums is the second argument
    jal ra, moveZeroes        # jump to moveZeroes function
    
    #PrintArray
    jal ra, printArray
    li a7, SYSEXIT
    add t4, x0, 0		# new addition
    ecall
    
moveZeroes:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    li s1, 0                    # next non zero index = 0
    addi s2, x0, 0                 # i = 0
    loop:
        bge s2, t3, exit           # i >= array_size exit
        slli t0, s2, 2             # i * 4
        add t0, t4, t0             # array + i*4
        lw t1, 0(t0)              # t1 = array[i]
        beq t1, x0, next_iter
        slli t2, s1, 2             # next_nonzero_index * 4
        add t2, t2, t4             # array + next_nonzero_index * 4
        sw t1, 0(t2)              # array[next_nonzero_index] = array[i]
        beq s1, s2, next_iter_addIndex             # if(next_nonzero_index != i)
        sw x0, 0(t0)              # store 0 to array[i]
    next_iter_addIndex:
        addi s1, s1, 1             # next_nonzero_index++
    next_iter:
        addi s2, s2, 1             # i++
        j loop
 exit:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    jr ra
 
printArray:
    li a7, SYSWRITE
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)
    add s0, t4, x0 # s1 = pointer to array
    add t0, x0, x0 # t0 = i in for loop
    printloop:
        bge t0, t3, finish_print_loop
        slli t1, t0, 2 # t1 = i * 4
        add t1, t1, s0 # t1 = t1 + array address
        lw t4, 0(t1) # t4 = element in nums[i]
        li a7, SYSWRITE
        li a0, 1
        mv a1, t4
        addi a1, a1, 48
		li a2, arr_size
        ecall
        addi t0, t0, 1
        j printloop
    finish_print_loop:
        lw ra, 0(sp)
        lw s0, 4(sp)
        addi sp, sp, 8
        jr ra
