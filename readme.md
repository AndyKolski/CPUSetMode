
# CPU Set Mode
CPU Set Mode is a simple tool to set the speed of the CPU. It helps save power on laptops and get the most out of a system where power usage isn't a concern.


## Usage
To set the cpu mode, use the following command:
```console
$ ./setmode.sh <mode>
```

Where mode is one of the following:
- `spud`: The lowest possible speed.
- `powersaver`: A low speed that is still reasonably usable.
- `performance`: The highest possible speed.
- `freq`: A custom speed. (eg, `$ ./setmode.sh freq 1.2Ghz` or `$ ./setmode.sh freq 1200Mhz`).


You can also get the current average speed and governor across all cores by using the `getmode.sh` tool:
```console
$ ./getmode.sh
```

## Who made this?
CPU Set Mode is written by [Andy Kolski](https://andyk.ca/)
