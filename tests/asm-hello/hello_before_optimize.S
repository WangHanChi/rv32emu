.org 0
.global _start

/* newlib system calls */
.set SYSEXIT, 93
.set SYSWRITE, 64


.data
nums:		.word 49, 32, 48, 32, 48, 32, 50, 32, 53
            .set arr_size, .-nums
numsSize:	.word 5
space:		.word 32
before:		.ascii  "Before move zeroes = "
            .set str_before_len, .-before
after:		.ascii  "After  move zeroes = "
            .set str_after_len, .-after
nextline:	.ascii  "\n"
            .set str_next_len, .-nextline

.text
_start:
		la	s0, nums		# s0 = nums[0]
		lw	s1, numsSize	# s1 = numsSize
        addi t5, x0, 48
        addi t6, x0, 32
        li t4, 0x10000000
        li	a7, SYSWRITE	# print .string
        li  a0, 1           # standard output
		la	a1, before		# pointer to string
        li  a2, str_before_len
		ecall
		jal		printo		# print nums before move
        li	a7, SYSWRITE	# print .string
        li  a0, 1           # standard output
		la	a1, nextline	# pointer to string
        li  a2, str_next_len
		ecall

        li	a7, SYSWRITE	# print .string
        li  a0, 1           # standard output
		la	a1, after		# pointer to string
        li  a2, str_after_len
		ecall
        jal		moveZeroes	# moveZeroes (leaf procedure)

		jal		print		# print nums after move

		li	a7, SYSEXIT 	# exit
        addi a0, x0, 0       # Use 0 return code
		ecall

moveZeroes:
		addi	t3, zero, 0		# t3: start = 0
		addi	t0, zero, -1	# t0: i = -1
	Loop:
		addi	t0, t0, 1		# i += 1
		bge		t0, s1, While	# i >= len -> While: 
		slli	t1, t0, 3		# t1: i << 2
		add		t1, t1, s0		# t1 = nums[i]
		lw		t1, 0(t1)
		beq		t1, t5, Loop	# nums[i] == 0 -> Loop:
		slli	t2, t3, 3		# else, t2: start << 2
		add		t2, t2, s0		# t2 = nums[start]
		sw		t1, 0(t2)		# nums[start] = nums[i]
        sw      t1, 0(t4)
        addi    t4, t4, 4
        sw      t6, 0(t4)
        addi    t4, t4, 4
		addi	t3, t3, 1		# start += 1
		j		Loop
	While:
		bge		t3, s1, Exit	# start >= numsSize : Exit
		slli	t2, t3, 3		# t2: start << 2
		add		t2, t2, s0		# t2: nums[start]
		sw		t5, 0(t2)		# nums[start] = 0
        sw      t5, 0(t4)
        addi    t4, t4, 4
        sw      t6, 0(t4)
        addi    t4, t4, 4
		addi	t3, t3, 1		# start += 1
		j		While
	Exit:

		jr      ra

printo:
        li a7, SYSWRITE
        li a0, 1
        la a1, nums
        li a2, arr_size
        ecall
		jr  ra

print:
        li a7, SYSWRITE
        li a0, 1
        la a1, 0x10000000
        li a2, arr_size
        ecall

        li a7, SYSWRITE
        li a0, 1
        la a1, nextline
        li a2, 1
        ecall
		jr  ra
	