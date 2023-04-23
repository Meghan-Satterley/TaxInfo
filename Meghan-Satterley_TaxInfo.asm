;Meghan Satterley
;CSIS250
;Spring 2022
;This program simulates a tax form, Prompting the user for a first, middle, last name and dependents
;then returns standard, dependent, and total deductions

TITLE TaxInfo (Meghan-Satterley_TaxInfo.asm)

INCLUDE Irvine32.inc

.data

;declare three 8 bit variables with DUP arrays initialized to null values

bufferFirst	BYTE	16	DUP(0)
bufferMid	BYTE	16	DUP(0)
bufferLast	BYTE	21	DUP(0)

;declare three 16 bit constants for deduction values

sDeduction	DWORD	12400
dDeduction	DWORD	4050	
tDeduction  DWORD 0

;declare promtps for first, middle, lastname and dependents 

promptFirst	BYTE	0Dh,0Ah,"Enter your first name:   ",0
promptMid	BYTE	0Dh,0Ah,"Enter your middle name:   ",0
promptLast	BYTE	0Dh,0Ah,"Enter your last name:   ",0
promptDep	BYTE	0Dh,0Ah,"Enter Number of Dependents:   ",0

;declare variables to hold space, comma, dependents, and name

holdSpace   BYTE  ' '
holdComma   BYTE  ','
holdDep	DWORD  0
holdName	BYTE   0

;declare all necessary lines to display client information

display00	BYTE  0Dh,0Ah," First name:   ",0
display01	BYTE  0Dh,0Ah,"     Middle:   ",0
display02	BYTE  0Dh,0Ah,"  Last name:   ",0
display03	BYTE	0Dh,0Ah," Dependents:   ",0
display04	BYTE	0Dh,0Ah,"       Name:   ",0
display05	BYTE	0Dh,0Ah,"=Deductions=   ",0
display06	BYTE	0Dh,0Ah,"  Standard $   ",0
display07	BYTE	0Dh,0Ah," Dependent $   ",0
display08	BYTE	0Dh,0Ah,"     Total $   ",0

.code
main PROC
	
	call Clrscr

; prompt user for first name
	
	mov  edx,OFFSET promptFirst
	call WriteString
	mov  edx, OFFSET bufferFirst
	mov  ecx,SIZEOF  bufferFirst
	call ReadString
	call Crlf

; prompt user for middle name

	mov  edx,OFFSET promptMid	
	call WriteString
	mov  edx, OFFSET bufferMid
	mov  ecx,SIZEOF  bufferMid
	call ReadString
	call Crlf

; prompt user for last name

	mov  edx,OFFSET promptLast
	call WriteString
	mov  edx, OFFSET bufferLast
	mov  ecx,SIZEOF  bufferLast
	call ReadString
	call Crlf

; prompt user for number of dependents

	mov  edx,OFFSET promptDep	
	call WriteString
	call ReadDec
	mov  holdDep,eax

	call ClrScr

; display first name

	mov  edx,OFFSET display00	
	call WriteString
	mov  edx,OFFSET bufferFirst
	call WriteString
	call Crlf
	
; display middle name

	mov  edx,OFFSET display01	
	call WriteString
	mov  edx,OFFSET bufferMid
	call WriteString
	call Crlf

; display last name

	mov  edx,OFFSET display02	
	call WriteString
	mov  edx,OFFSET bufferlast
	call WriteString
	call Crlf

; display dependents

	mov  edx,OFFSET display03	
	call WriteString 
	mov  eax,holdDep
	call WriteDec
	call Crlf
	call Crlf

; display full name

	mov  edx,OFFSET display04	
	call WriteString
	mov  edx,OFFSET bufferlast 	
	mov  ecx,SIZEOF bufferLast
	call WriteString
	mov  al,holdComma			 
	call WriteChar
	mov  al,holdSpace			
	call WriteChar
	mov  edx,OFFSET bufferFirst	
	mov  ecx,SIZEOF bufferFirst
	call WriteString
	mov  al,holdSpace		
	call WriteChar
	mov  edx,OFFSET bufferMid
	mov  ecx,SIZEOF bufferMid
	call WriteString
	call Crlf
	
; deductions

	mov  edx,OFFSET display05	
	call WriteString
	call Crlf

; standard deductions

	mov  edx,OFFSET display06	
	call WriteString
	mov  eax,sDeduction
	call WriteDec
	call Crlf

; dependent deductions

	mov  edx,OFFSET display07	
	call WriteString
	mov  eax,dDeduction
	mul  holdDep
	call WriteDec
	call Crlf

; total deductions

	mov  edx,OFFSET display08	
	call WriteString
	mov  eax,dDeduction
	mul  holdDep
	add  eax,sDeduction
	mov  tDeduction,eax
	call WriteDec
	call Crlf

	call Crlf
	call Crlf
	call WaitMsg

	exit
main ENDP
END main