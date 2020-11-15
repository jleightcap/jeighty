import sys

class bcolors:
    ALRT = '\033[92m'
    ENDC = '\033[0m'

assert(len(sys.argv) == 3)

romsize = 2 << 15 - 1

# null pad the input file to the expected 2^15 size
with open(sys.argv[1], "rb") as i_file, open(sys.argv[2], "wb") as o_file:
    data = i_file.read()
    flen = len(data)
    assert(flen < romsize)
    print(f'{bcolors.ALRT}rom image uses {hex(flen)} bytes, {hex(romsize - flen)} remaining{bcolors.ENDC}')
    o_file.write(data + bytearray([0x00] * (romsize - flen)))
