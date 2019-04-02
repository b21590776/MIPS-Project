.data
.globl main
A: .word 2, 4, 6, 8
.text		
							
main:				
	la $t1, A 		#array A
	add $s0, $0, $0	 #i
	addi $t0, $0, 3 	# i<'3'
	
	j for
	
for: 	
	slt $t4,$s0,$t0     	#checks if $t0 > $s0
	beq $t4,0,done    	# if $t0 < $s0, goes to done
	
	lw $t2, 0($t1)  	# $t2 = array[i]
	lw $t3, 4($t1)  	# $t2 = array[i+1]
	
	sub $s1, $t3, $t2	# dif =a(i+1)- a[i]  $s1
	
	
	slt $t5, $0, $s1     	#checks if $0 < $s1 (dif)
	beq $t5, 0, else	
	
	
	sll $t2, $t2, 2 	#A[i] = 4*A[i]
	addi $t2, $t2, 1	#A[i] = 4A[i]+A[i]
	j for
else:
	
	addi $s5 ,$0, -5	#-5 = t5 
	mul $t3, $t2, $s5 	#A[i+1] = -5*A[i];
	mflo $t3		

done:
	li	$v0,10	# exit
	syscall