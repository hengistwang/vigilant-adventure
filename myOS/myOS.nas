;; myOS

    ORG     0x7c00          ;; 程序的装载地址

;; FAT12格式软盘专用格式

    JMP     entry
    DB      0x90
    DB      "IPL     "       ;; 启动区名称(固定8 BYTE)
    DW      512              ;; 每个扇区(sector)的大小(固定512 BYTE)
    DB      1                ;; cluster 的大小(一个扇区)
    DW      1                ;; FAT起始位置(第一个扇区)
    DB      2                ;; FAT的个数(固定值2)
    DW      224              ;; 根目录的大小(一般为224)
    DW      2880             ;; 磁盘的大小(2880扇区)
    DB      0xf0             ;; 磁盘的种类(固定值0xf0)
    DW      9                ;; FAT的长度(固定值9扇区)
    DW      18               ;; 一个磁道(track)的扇区数(固定值18)
    DW      2                ;; 磁头数(固定值2)
    DD      0                ;; 不使用分区
    DD      2880             ;; 重写一次磁盘的大小
    DB      0, 0, 0x29
    DD      0xffffffff
    DB      "OS         "    ;; 磁盘的名称(11 BYTE)
    DB      "FAT12   "       ;; 磁盘格式名称(8 BYTE)
    RESB    18               ;; 预留18 BYTE

;; 程序核心

entry:
        MOV AX,0              ;; 初始化寄存器  
        MOV SS,AX
        MOV SP,0x7c00
        MOV DS,AX
        MOV ES AX

        MOV SI,msg
putloop:
        MOV AL,[SI]
        ADD SI,1
        CMP AL,0
        JE  fin
        MOV AH,0x0e
        MOV BX,15
        INT 0x10                ;; 调用0x10中断
        JMP putloop
fin:
        HLT                     ;; 类似于sleep语句
        JMP fin
msg:
        DB      0x0a
        DB      "hello, hengist!"
        DB      0x0a
        DB      0

        RESB    0x7dfe-$

        DB      0x55, 0xaa

;; others

    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    4600
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    1469432
