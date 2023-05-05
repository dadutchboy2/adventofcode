#include <stdio.h>
#include <stdlib.h>
int main() {
    FILE *input;
    input = fopen("aocc2201.txt", "r");
    char string[7];
    int sumAmount;
    int maxAmount;
    int count = 0;
    while (fgets(string, 7, input)) {
        int amount = atoi(string);
        if (amount == 0) {
            maxAmount = sumAmount > maxAmount ? sumAmount : maxAmount;
            sumAmount = 0;
        }
        else {
            sumAmount += amount;
        }
        count++;
    }
    printf("%d", maxAmount);
    return 0;
}
