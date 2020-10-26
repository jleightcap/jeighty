import sys

assert(len(sys.argv) == 3)

# null pad the input file to the expected 2^15 size
with open(sys.argv[1], "rb") as i_file, open(sys.argv[2], "wb") as o_file:
    data = i_file.read()
    flen = len(data)
    assert(flen < 32768)
    o_file.write(data + bytearray([0x00] * (32768 - flen)))
