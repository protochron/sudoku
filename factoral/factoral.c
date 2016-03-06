#include <stdio.h>
#include <stdlib.h>

long factoral(int x) {
  if(x == 1) {
    return x;
  }
  return x * factoral(x - 1);
}

int main(int argc, char *argv[]) {
  long factoral_start;
  long computed_factoral;

  if(argc > 1) {
    factoral_start = strtol(argv[1], NULL, 10);
  }
  else {
    puts("You must provide a value to compute the factoral!");
    return 1;
  }

  if(factoral_start == 0) {
    puts("Invalid value for computing a factoral");
    return 1;
  }

  computed_factoral = factoral(factoral_start);
  printf("Factoral of %ld is %ld\n", factoral_start, computed_factoral);

  return 0;
}
