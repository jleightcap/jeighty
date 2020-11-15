# MREQ Memory:
```
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
```

# IORQ Memory:
```
0xffff +------+
       |      |
       |      |
       | DART |
       |      |
       |      |
0x8000 +------+
       |      |
       |      |
       | PIO  | 0bxx11 Port B Control
       |      | 0bxx10 Port B Data
       |      | 0bxx01 Port A Control
0x0000 +------+ 0bxx00 Port A Data
```
