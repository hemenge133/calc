.data

input_type:		.asciz "%d %d %c"
string_type: 	.asciz "%s"
double_type: 	.asciz "%d"
char_type:  	.asciz "%c"
errormsg:		.asciz "Error"
string:			.asciz "Calculate: \n"
newLine:		.asciz "\n"
test:			.asciz "This is a test\n"
b1:				.space 32
b2:				.space 32
b3:				.space 32

.text

.global main

main:

	ldr x0, =string_type
	ldr x1, =string
	bl printf

	ldr x0, =input_type
	ldr x1, =b1
	ldr x2, =b2
	ldr x3, =b3

	bl scanf

	//A->x1 B->x2 operand->x3
	ldr x1, =b1
	ldr x2, =b2
	ldr x3, =b3

	//A->x22 B->x23 operand->x20
	ldr x22, [x1, #0]
	ldr x23, [x2, #0] //Including offset into the memory register so that the correct addresses are being stored.
	ldrb w20, [x3, #0]

	//Check if addition
	subs x21, x20, #43
	cbz x21, add

	//check if subtraction
	subs x21, x20, #45
	cbz x21, subtract

	//check if mult
	subs x21, x20, #42
	cbz x21, multiply

	//check if div
	subs x21, x20, #47
	cbz x21, divide

	add:

		add x24, x22, x23
		mov x1, x24
		ldr x0, =double_type

		bl printf
		b exit

	subtract:
		sub x24, x22, x23
		mov x1, x24
		ldr x0, =double_type

		bl printf
		b exit


	multiply:
		mul x24, x22, x23
		mov x1, x24
		ldr x0, =double_type

		bl printf
		b exit

	divide:
		//check if B=0
		cbz w23, dividebyzero
		sdiv w24, w22, w23

		mov x1, x24
		ldr x0, =double_type

		bl printf
		b exit

	dividebyzero:
		ldr x0, =string_type
		ldr x1, =errormsg
		bl printf
		b exit

	exit:
		ldr x0, =newLine
		bl printf

		mov x0, #0
		mov x8, #93
		svc #0
