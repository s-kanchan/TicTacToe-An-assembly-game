.text

	ldr r2,=starter1
	mov r0,#2
	mov r1,#5
	swi 0x204
	ldr r2,=starter2
	mov r0,#5
	mov r1,#7
	swi 0x204
	mov r0,#0
stloop:	swi 0x203
	cmp r0,#0
	beq stloop
	
	swi 0x206
	

	ldr r2,=xline;
	mov r0,#0
	mov r1,#2
	swi 0x204
	mov r1,#5
	swi 0x204
	mov r1,#8
	swi 0x204
	mov r1,#11
	swi 0x204

	mov r3,#2
pl:	mov r4,#0
pinlp:	mov r0,r4
	mov r1,r3
	ldr r2,=yline
	swi 0x204
	add r4,r4,#9
	cmp r4,#36
	bne pinlp
	add r3,r3,#1
	cmp r3,#12
	bne pl

	mov r3,#0
	ldr r12,=entered		; r12 having entered addrs	
	;ldr r4,=val			; to check overriding		r4 having addrs of val


game:	cmp r9,#9
	beq exit
	ldr r2,=player1
	mov r0,#0
	swi 0x208
	mov r0,#15
	mov r1,#0	
	swi 0x204
	mov r0,#0
p1:	swi 0x203
	cmp r0,#0
	beq p1
	clz r0,r0
	rsb r11,r0,#31

	mov r10,#0
	ldr r0,=entered	
ovrd1: 	ldrb r1,[r0]
	cmp r11,r1			;checking overriding
	beq p1
	add r0,r0,#4
	add r10,r10,#1
	cmp r10,#9
	bne ovrd1

	ldr r2,=p1style
	ldr r4,=val

	cmp r11,#0
	moveq r0,#2
	moveq r1,#3
	moveq r5,#1
	streq r5,[r4]

	cmp r11,#1
	moveq r0,#11
	moveq r1,#3
	moveq r5,#2
	streq r5,[r4]
	
	cmp r11,#2
	moveq r0,#20
	moveq r1,#3
	moveq r5,#3
	streq r5,[r4]

	cmp r11,#4
	moveq r0,#2
	moveq r1,#6
	moveq r5,#4
	streq r5,[r4]
	
	cmp r11,#5
	moveq r0,#11
	moveq r1,#6
	moveq r5,#5
	streq r5,[r4]

	cmp r11,#6
	moveq r0,#20
	moveq r1,#6
	moveq r5,#6
	streq r5,[r4]

	cmp r11,#8
	moveq r0,#2
	moveq r1,#9
	moveq r5,#7
	streq r5,[r4]

	cmp r11,#9
	moveq r0,#11
	moveq r1,#9
	moveq r5,#8
	streq r5,[r4]

	cmp r11,#10
	moveq r0,#20
	moveq r1,#9
	moveq r5,#9
	streq r5,[r4]

	str r11,[r12]  
	add r12,r12,#4
	
	swi 0x204		; printing the corresponding value in pos
	add r9,r9,#1
	
	ldr r5,[r4]
	sub r0,r5,#1
	mov r0,r0,lsl #2	; storing val in corresponding pos in p1entered
	ldr r2,=p1entered
	add r2,r2,r0
	str r5,[r2]

				;check winner
	ldr r11,=p1entered
	ldr r0,[r11],#4
	ldr r1,[r11],#4	
	ldr r2,[r11],#4
	ldr r3,[r11],#4
	ldr r4,[r11],#4
	ldr r5,[r11],#4
	ldr r6,[r11],#4
	ldr r7,[r11],#4
	ldr r8,[r11],#4
	
	cmp r0,#0
	cmpne r1,#0
	cmpne r2,#0
	bne p1wins
	
	cmp r3,#0
	cmpne r4,#0
	cmpne r5,#0
	bne p1wins
	
	cmp r6,#0
	cmpne r7,#0
	cmpne r8,#0
	bne p1wins

	cmp r0,#0
	cmpne r3,#0
	cmpne r6,#0
	bne p1wins
	
	cmp r1,#0
	cmpne r4,#0
	cmpne r7,#0
	bne p1wins
	
	cmp r2,#0
	cmpne r5,#0
	cmpne r8,#0
	bne p1wins

	cmp r0,#0
	cmpne r4,#0
	cmpne r8,#0
	bne p1wins
	
	cmp r2,#0
	cmpne r4,#0
	cmpne r6,#0
	bne p1wins
	
	cmp r9,#9
	beq exit
	ldr r2,=player2
	mov r0,#0
	swi 0x208
	mov r0,#15
	mov r1,#0	
	swi 0x204
	mov r0,#0
p2:	swi 0x203
	cmp r0,#0
	beq p2
	clz r0,r0
	rsb r11,r0,#31
	
	mov r10,#0
	ldr r0,=entered	
ovrd2: 	ldrb r1,[r0]
	cmp r11,r1			;checking overriding
	beq p2
	add r0,r0,#4
	add r10,r10,#1
	cmp r10,#9
	bne ovrd2

	ldr r2,=p2style
	ldr r4,=val

	cmp r11,#0
	moveq r0,#2
	moveq r1,#3
	moveq r5,#1
	streq r5,[r4]

	cmp r11,#1
	moveq r0,#11
	moveq r1,#3
	moveq r5,#2
	streq r5,[r4]
	
	cmp r11,#2
	moveq r0,#20
	moveq r1,#3
	moveq r5,#3
	streq r5,[r4]

	cmp r11,#4
	moveq r0,#2
	moveq r1,#6
	moveq r5,#4
	streq r5,[r4]
	
	cmp r11,#5
	moveq r0,#11
	moveq r1,#6
	moveq r5,#5
	streq r5,[r4]

	cmp r11,#6
	moveq r0,#20
	moveq r1,#6
	moveq r5,#6
	streq r5,[r4]

	cmp r11,#8
	moveq r0,#2
	moveq r1,#9
	moveq r5,#7
	streq r5,[r4]

	cmp r11,#9
	moveq r0,#11
	moveq r1,#9
	moveq r5,#8
	streq r5,[r4]

	cmp r11,#10
	moveq r0,#20
	moveq r1,#9
	moveq r5,#9
	streq r5,[r4]

	

	str r11,[r12]  
	add r12,r12,#4

	swi 0x204
	add r9,r9,#1
	
	ldr r5,[r4]
	sub r0,r5,#1
	mov r0,r0,lsl #2	; storing val in corresponding pos in p2entered
	ldr r2,=p2entered
	add r2,r2,r0
	str r5,[r2]

				;check winner
	ldr r11,=p2entered
	ldr r0,[r11],#4
	ldr r1,[r11],#4	
	ldr r2,[r11],#4
	ldr r3,[r11],#4
	ldr r4,[r11],#4
	ldr r5,[r11],#4
	ldr r6,[r11],#4
	ldr r7,[r11],#4
	ldr r8,[r11],#4
	
	cmp r0,#0
	cmpne r1,#0
	cmpne r2,#0
	bne p2wins
	
	cmp r3,#0
	cmpne r4,#0
	cmpne r5,#0
	bne p2wins
	
	cmp r6,#0
	cmpne r7,#0
	cmpne r8,#0
	bne p2wins

	cmp r0,#0
	cmpne r3,#0
	cmpne r6,#0
	bne p2wins
	
	cmp r1,#0
	cmpne r4,#0
	cmpne r7,#0
	bne p2wins
	
	cmp r2,#0
	cmpne r5,#0
	cmpne r8,#0
	bne p2wins

	cmp r0,#0
	cmpne r4,#0
	cmpne r8,#0
	bne p2wins
	
	cmp r2,#0
	cmpne r4,#0
	cmpne r6,#0
	bne p2wins
	
	b game

p1wins:	swi 0x206
	ldr r2,=winner1
	mov r0,#5
	mov r1,#5
	swi 0x204
	;ldr r2,=bingo
	;swi 0x204
	swi 0x11

p2wins:	swi 0x206
	ldr r2,=winner2
	mov r0,#5
	mov r1,#5
	swi 0x204
	;ldr r2,=bingo
	;swi 0x204
	swi 0x11


exit:	swi 0x206
	ldr r2,=draw
	mov r0,#5
	mov r1,#5
	swi 0x204
	;ldr r2,=bingo
	;swi 0x204
	swi 0x11

xline:.asciz"============================"
yline:.asciz"|"
p1style:.asciz"X"
player1:.asciz"1st player turn"
player2:.asciz"2nd player turn"
p2style:.asciz"O"
winner1:.asciz"***** PLAYER 1 WINS********"
starter1:.asciz"PLEASE USE 1st 3X3 No's IN DISPLAY"
starter2:.asciz"PRESS ANY KEY TO CONTINUE"
winner2:.asciz"***** PLAYER 2 WINS********"
draw:.asciz"******** GAME TIE	***********"


entered:.word 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff
p1entered:.word 0,0,0,0,0,0,0,0,0,0
p2entered:.word 0,0,0,0,0,0,0,0,0,0

val:.word 0x00
