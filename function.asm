.text
.globl main
.data 


main:
	addi $a0, $0, 3 	# argument a0 = 3
	addi $a1, $0, 5 	# argument a1 = 5
	add  $s0,$0,$0	#result $s0 = 0
	
	addi $sp, $sp, -4
	sw $ra 0($sp)
	
	bne $a0 , $a1, else	#if(a == b)
	add $s1, $a0, $a1
	sll $s0, $s1, 3 	# $s0 <= $t1 << 3
	jr $ra
	
else:
	jal compare	# call Function
	add $s0, $v0, $0 	# result = returned value
	
	lw $ra 0($sp)
	addi $sp, $sp, 4
	jr $ra 	
			
compare:
	addi $sp, $sp, -8 	# make space on stack to store 2 registers
	sw $t0, 4($sp) 	# save $t0 on stack
	sw $t1, 0($sp) 	# save $t1 on stack
	
	slt $t7,$a0,$a1    	#checks if  a <b  t7=1
	beq $t7, 0 ,else2    	# if b < a, goes to else 	
	jal punish
	
	lw $ra 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
else2:
	jal award
	
	lw $t1, 0($sp)   	# restore $t1 from stack
	lw $t0, 4($sp)   	# restore $t0 from stack
	addi $sp, $sp,8  	# deallocate stack space
	
	jr $ra
	
punish:
	
	addi $sp, $sp, -8 	# make space on stack to store 2 registers
	sw $t0, 4($sp) 	# save $t0 on stack
	sw $t4, 0($sp) 	# save $t1 on stack
	
	
	sub $t4, $a0, $a1			
	sll $t4, $s1, 1	#{ return (a-b)*2;}
	add $v0, $t4, $0 	# put return value in $v0
	

	lw $t1, 0($sp)   	# restore $t1 from stack
	lw $t4, 4($sp)   	# restore $t0 from stack
	addi $sp, $sp,8  	# deallocate stack space
	
	jr $ra
	
	li	$v0,10	# exit
	syscall
	
award:
	addi $sp, $sp, -8 	# make space on stack to store 2 registers
	sw $t0, 4($sp) 	# save $t0 on stack
	sw $t5, 0($sp) 	# save $t5 on stack

	add $t5,$a0,$a1			
	sll $t5, $s1, 2	#{ return (a+b)*4;}
	add $v0, $t5, $0 	# put return value in $v0
	
	
	lw $t1, 0($sp)   	# restore $t1 from stack
	lw $t0, 4($sp)   	# restore $t0 from stack
	addi $sp, $sp,8  	# deallocate stack space
	
	jr $ra
	
	li	$v0,10	# exit
	syscall

	
	
	
	
	
	