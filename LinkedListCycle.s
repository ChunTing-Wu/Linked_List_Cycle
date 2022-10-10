.data
len1: .word 10
len2: .word 5
len3: .word 5
len4: .word 2


first: .string "=========first=========\n "
second: .string "=========second=========\n "
third:  .string "=========third=========\n "

.text
main:
    
    # first
    #la a0, first
    #li a7, 4
    #ecall
    
    #lw a1, len1                  # a1 = arr_len
    #jal ra, initNormalList      # a0 = return value = struct ListNode head
    #jal ra, start_cycle
 
    # second
    #la a0, second
    #li a7, 4
    #ecall

    #lw a1, len2                  # a1 = arr_len
    #jal ra, initNormalList      # a0 = return value = struct ListNode head
    #jal ra, start_cycle
    
    # third
    la a0, third
    li a7, 4
    ecall
    lw a1, len3                  # a1 = arr_len
    lw a2, len4
    jal ra, initErrorList      # a0 = return value = struct ListNode head
    jal ra, start_cycle
    j exit

start_cycle:
    # prologue
    addi sp, sp, -8
    sw ra, 0(sp)
    sw a0, 4(sp)

    # body
    mv t1, a0        # t1 = list head
    li a7, 4
    ecall
    # print end
    
    jal ra, print_list   # for test linked list function
    
    # epilogue
    lw ra, 0(sp)        # back to main
    lw a0, 4(sp)
    addi sp, sp, 8
    jr ra

initNormalList:
    # prologue
    addi sp, sp, -8      # push stack pointer to the bottom
    sw ra, 0(sp)
    
    # body
    addi t0, a1, -1     # t0 = len
    li s0, 0x20000000   # s0 will handle the address of each list node
    sw s0, 4(sp)        # store list head to stack
       
    jal ra malloc       # for - malloc
    addi s1, zero, 0    # head->val = 0, 
    addi t3, s0  , 0    # ListNode head
    
    addi s0, s0, 8
    li s1, 0            # i == 0
loop:
    jal ra malloc       # struct ListNode *next = malloc    
    addi t4, s1, 1      # for i 0 
    sw t4, 0(s0)        # next->val = s0
    sw s0, 4(t3)        # c -> next = next
    addi t3, t3, 8      # push heap 8 byte
    
    addi s1, s1, 1      # i++

    addi s0,s0, 8       # push new ListNode
    
    
    bne s1, t0 loop     # for loop condition
    
    sw zero, 4(t3)
    
    lw ra, 0(sp)        # load return address
    lw a0, 4(sp)        # load list head address
    addi sp, sp, 8
    
    jr ra



initErrorList:
    # prologue
    addi sp, sp, -8      # push stack pointer to the bottom
    sw ra, 0(sp)
    
    # body
    addi t5, a2, -1
    addi t0, a1, -1     # t0 = len
    li s0, 0x20000000   # s0 will handle the address of each list node
    sw s0, 4(sp)        # store list head to stack
       
    jal ra malloc       # for - malloc
    addi s1, zero, 0    # head->val = 0, 
    addi t3, s0  , 0    # ListNode head
    
    addi s0, s0, 8
    li s1, 0            # i == 0
loop_error:
    jal ra malloc       # struct ListNode *next = malloc    
    addi t4, s1, 1      # value + 1 (for varify) 
    sw t4, 0(s0)
    sw s0, 4(t3)        # c -> next = next
    
    addi t3, t3, 8      # push heap 8 byte
    addi s1, s1, 1      # i++
    addi s0, s0, 8      # push new ListNode
    
    beq s1, t5 StorageCycle
    bne s1, t0 loop_error     # for loop condition
    
    sw t6, 4(t3)
    
    lw ra, 0(sp)        # load return address
    lw a0, 4(sp)        # load list head address
    addi sp, sp, 8
    
    jr ra
    
StorageCycle: 
    addi t6, t3, 0
    ecall
    jr ra
print_list:
    lw a0, 0(t1)        # load value to a0
    li a7, 1            # system call: print int
    ecall
    
    li a0, 9            # tab
    li a7, 11           # print char
    ecall
    
    lw t1, 4(t1)        # t1 = t1->next
    bne t1, zero print_list
    li a0, 10           # next line
    li a7, 11           # print char
    ecall
    
    jr ra
malloc:
    li a7, 214          # brk
    ecall
    jr ra
    
exit:
    li a7, 10           # end
    ecall