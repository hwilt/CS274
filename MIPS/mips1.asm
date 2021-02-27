.globl main 
    .text         
main:
    li $t1, 7        
    li $t2, 0        
Mark:    bge $t2,$t1, Mix    
    li    $v0, 1        
    move    $a0, $t2    
    syscall
    li    $v0, 4        
    la    $a0, EOL    
    syscall

    
    addi    $t2,$t2,1
    j    Mark            
Mix:    
    li $v0, 10 
    syscall 
    .data
EOL:.asciiz "\n"
