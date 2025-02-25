# learn-x86-assembly

Running Instructions

```sh
as -o functions.o functions.s
gcc -c main.c -o main.o
gcc main.o functions.o -o program
./program
```