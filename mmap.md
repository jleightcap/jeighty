# MREQ Memory:
0xffff +-----+ <-+-- stack (grows down)
       |     |   |
       |     |   |
0xb000 | RAM | <-+
       | 32K |
       |     |
0x8000 +-----+ <- tmpfs start
       |     |
       |     |
0x4000 | ROM | <- romfs start
       | 32K |
       |     |
0x0000 +-----+ <- BIOS start

# IORQ Memory:
0xffff +------+
       |      |
       |      |
       | PIO  |
       |      |
       |      |
0x8000 +------+
       |      |
       |      |
       | DART | 0x0003 Port B Control
       |      | 0x0002 Port B Data
       |      | 0x0001 Port A Control
0x0000 +------+ 0x0000 Port A Data
