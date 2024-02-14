# read 10 numbers into an array
# swap any pairs of of number which are out of order
# then print the 10 numbers

# i in register $t0,
# registers $t1 - $t3 used to hold temporary results

main:

    li   $t0, 0         # i = 0
scan_loop:
    bge  $t0, 10, end_scan_loop  # while (i < 10) {

    li   $v0, 5         #   scanf("%d", &numbers[i]);
    syscall             #

    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #
    sw   $v0, ($t3)     #   store entered number in array

    addi $t0, $t0, 1    #   i++;
    j    scan_loop         # }
end_scan_loop:

    li   $t0, 1         # i = 1

loop_swap:
    bge  $t0, 10, end2  #   while (i < 10) {

    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #   t3 = &numbers[i]
    lw   $t7, ($t3)     #   load numbers[i] into $a0

    sub  $t4, $t0, 1    #   t4 = i -1
    mul  $t5, $t4, 4    #   t5 = calculate &numbers[i]
    add  $t6, $t5, $t2  #
    lw   $t8, ($t6)     #   load numbers[i] into a0, y = numbers[i - 1] 

    # move  $a0, $t7              # printf("%d"); testing
    #li    $v0, 1
    # syscall
    
    #li   $a0, '\n'      #   printf("%c", '\n'); testing
    # li   $v0, 11
    # syscall

    # move  $a0, $t8      # printf("%d"); testing
    # li    $v0, 1
    # syscall

    # li   $a0, '\n'      #   printf("%c", '\n'); testing
    # li   $v0, 11
    # syscall

    #li   $a0, '\n'      #   printf("%c", '\n'); testing
    #li   $v0, 11
    # syscall

    bge $t7, $t8, skip_swap     # t7 < t8,  x < y
    sw   $t8, ($t3)     # numbers[i] = y;
    sw   $t7, ($t6)     # numbers[i - 1] = x;




skip_swap: 
    addi $t0, $t0, 1    #   i++;
    j loop_swap

end2: 
    li $t0, 0

print_loop: 
    bge  $t0, 10, end1  # while (i < 10) {

    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #
    lw   $a0, ($t3)     #   load numbers[i] into $a0
    li   $v0, 1         #   printf("%d", numbers[i])
    syscall

    li   $a0, '\n'      #   printf("%c", '\n');
    li   $v0, 11
    syscall

    addi $t0, $t0, 1    #   i++
    j    print_loop          # }



end1:
    li   $v0, 0
    jr   $ra            # return 0

.data

numbers:
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # int numbers[10] = {0};
