.text
	mov r12,#3	; keep track of car y location
	mov r11,#50	; keep track of object 1 x position
	mov r10,#80	;keep track of object 2 x position

	mov r0,#5
	mov r1,#2
	ldr r2,=asklevel1;
	swi 0x204
	mov r0,#5	
	mov r1,#4
	ldr r2,=asklevel2
	swi 0x204
	mov r0,#11
	mov r1,#6
	ldr r2,=asklevel3
	swi 0x204
	mov r0,#11
	mov r1,#8
	ldr r2,=asklevel4
	swi 0x204	
	
	ldr r2,=level
	;ldr r2,[r2]
	mov r0,#0
lvloop:	swi 0x203
	;cmp r0,#0
	;beq lvloop
	clz r0,r0
	rsb r0,r0,#31
	cmp r0,#1
	streq r0,[r2]
	beq go
	cmp r0,#2
	streq r0,[r2]
	beq go
	cmp r0,#3
	streq r0,[r2]
	beq go
	
	b lvloop	
 	
go:	swi 0x206
	ldr r2,=gamestart;
	mov r0,#4	;
	mov r1,#3	;
	swi 0x204	;	start of game...........
	mov r0,#0	;	
loop:	swi 0x203	;
	cmp r0,#0
	beq loop

	swi 0x206	;
	ldr r2,=outtrack	;
	mov r0,#0	;
	mov r1,#2	;       printintg the track
	swi 0x204	;
	mov r1,#6	;
	swi 0x204	;
	ldr r2,=intrack	;
	mov r1,#4	;
	swi 0x204

	mov r9,#50	;initializing pos of objects
	mov r7,#80	; r9 is pos of 1st object r7 is the pos of 2nd object

game:	mov r3,r12	;  remembering the cars y loc to check is it needed to clear the line or not?
	swi 0x203	;  get the input from the keys
	clz r0,r0	;
	rsb r0,r0,#31	;  find the key pressed
	cmp r0,#3	;  
	moveq r12,#3	;  key pressed is 3 be in 1st track
	cmp r0,#7	;  
  	moveq r12,#5 	;  key pressed is 7 jump to 2nd track
	
	cmp r3,r12	;  check whether the track is changed?
	movne r0,r3	;  
	swine 0x208	;  if diff is not zero then track changed so clear the previous track
			
	
	mov r0,#0	;
	mov r1,r12	; print the car in changed track/on same track
	ldr r2,=car	; 
	swi 0x204	;

	
	ldr r8,=obj1	;	r8 will b holding the addr of y loc of obj 1
	ldr r2,=object	;	
	mov r0,r9	;	print obj1 in pos r9
	ldr r1,[r8]	;	get the y loc of obj 1
	swi 0x204	;
	
	ldr r0,=level
	ldr r0,[r0]
	sub r9,r9,r0	;	decrese x pos of obj 1
	cmp r9,#5	;	
	ldrle r0,[r8]	;
	cmple r12,r0	;
	beq over	;
	cmp r9,#-1	;
	;movle r9,r11	;
	addle r11,r11,#80
	movle r9,r11	;
	ldrle r0,[r8]	;
	swile 0x208	;
	ldrle r1,=score	;
	ldrle r0,[r1]	;
	addle r0,r0,#5	;
	strle r0,[r1]	;
	
	
	ldr r8,=obj2
	ldr r2,=object
	mov r0,r7
	ldr r1,[r8]
	swi 0x204
	
	ldr r0,=level
	ldr r0,[r0]
	sub r7,r7,r0		; decrease by level value
	cmp r7,#5		; compare x pos of obj 
	ldrle r0,[r8]		
	cmple r12,r0		; if col of obj n car is same game over
	beq over
	cmp r7,#-1
	addle r7,r10,#50
	ldrle r0,[r8]
	swile 0x208
	ldrle r1,=score
	ldrle r0,[r1]
	addle r0,r0,#5
	strle r0,[r1]

	b game
	

over:	swi 0x206
	mov r0,#6
	mov r1,#2
	adr r2,gameover
	swi 0x204
	mov r0,#6
	mov r1,#4
	ldr r2,=printscore
	swi 0x204
	mov r0,#19
	mov r1,#6
	ldr r2,=score
	ldr r2,[r2]
	swi 0x205
	swi 0x11


gamestart:.asciz"*****PRESS ANY KEY TO PLAY*****"
gameover:.asciz"XXXXXXX GAME OVER XXXXXXXX"
printscore:.asciz"****** YOUR SCORE IS *****"
outtrack:.asciz"============================================"
intrack:.asciz"---------------------------------------------"
asklevel1:.asciz"which level you want to play?"
asklevel2:.asciz"press 1 for easy"
asklevel3:.asciz"2 for normal"
asklevel4:.asciz"3 for hard"
car:.asciz"[]=[]>"
object:.asciz"<[]=[]                                          "

obj1:.word 0x03
obj2:.word 0x05
score:.word 0x00
level:.word 0x00
.end