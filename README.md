# jeighty microkernel

jeighty is a microkernel for my Z80 homebrew minicomputer written in [JAL](https://github.com/jleightcap/jal) and Z80 assembly.

jeighty is in early development, and currently boots past a BIOS into a JAL programs which can interact with hardware drivers.

# Building

To build the ROM,
```bash
make -C src/
```

To upload ROM image with `minipro`,
```bash
make -C src/ upload
```

# TODO
jeighty development closely follows JAL development.

- [X] BIOS
- [X] Boot from BIOS into JAL program entrypoint
- [X] LCD driver
- [X] Buzzer sound driver
- [ ] Keyboard driver
- [ ] Basic shell
- [ ] Basic filesystem
